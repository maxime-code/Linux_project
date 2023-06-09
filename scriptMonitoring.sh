# Générer le code HTML
source config.sh

echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "    <title>Affichage des donnees d'utilisation des ressources</title>"
echo "</head>"
echo "<body>"
echo "    <h2>CPU</h2>"
echo "    <div id=\"cpuData\"></div>"
echo "    <script>"
echo "        // Fonction pour recuperer les donnees depuis les fichiers texte"
echo "        function getDataFromFile(file) {"
echo "            return fetch(file)"
echo "                .then(response => response.text())"
echo "                .then(data => data.trim());"
echo "        }"
echo "        // Attendre la recuperation de toutes les donnees"
echo "        Promise.all(["
echo "            getDataFromFile(\"cpu_usage.txt\"),"
echo "            getDataFromFile(\"memory_usage.txt\"),"
echo "            getDataFromFile(\"network_usage.txt\")"
echo "        ]).then(([cpuData, memoryData, networkData]) => {"
echo "            console.log(\"Donnees d'utilisation des CPU :\", cpuData);"
echo "            console.log(\"Donnees d'utilisation de la memoire :\", memoryData);"
echo "            console.log(\"Donnees d'utilisation du reseau :\", networkData);"
echo "            // Afficher les donnees dans les elements HTML correspondants"
echo "            document.getElementById(\"cpuData\").textContent = \"Pourcentage libre de CPU : \" + cpuData;"
echo "        });"
echo "    </script>"
echo "    <h2>Utilisation de la memoire</h2>"
echo "    <div id=\"memoryData\"></div>"
echo "    <script>"
echo "        // Fonction pour recuperer les donnees depuis le fichier texte"
echo "        function getDataFromFile(file) {"
echo "            return fetch(file)"
echo "                .then(response => response.text())"
echo "                .then(data => data.trim());"
echo "        }"
echo "        // Attendre la recuperation des donnees"
echo "        getDataFromFile(\"memory_usage.txt\")"
echo "            .then(memoryData => {"
echo "                console.log(\"Donnees d'utilisation de la memoire :\", memoryData);"
echo ""
echo "                // Separer les deux valeurs de memoire"
echo "                const [memoryUsed, memoryFree] = memoryData.split(\" \");"
echo ""
echo "                // Afficher les valeurs separement dans l'element HTML correspondant"
echo "                document.getElementById(\"memoryData\").innerHTML = \`"
echo "                    <p>Memoire utilisee : \${memoryUsed}</p>"
echo "                    <p>Memoire libre : \${memoryFree}</p>"
echo "                \`;"
echo "            });"
echo "    </script>"
echo "    <h2>Utilisation du reseau</h2>"
echo "    <div id=\"networkData\"></div>"
echo "    <script>"
echo "        // Fonction pour recuperer les donnees depuis le fichier texte"
echo "        function getDataFromFile(file) {"
echo "            return fetch(file)"
echo "                .then(response => response.text())"
echo "                .then(data => data.trim());"
echo "        }"
echo "        // Fonction pour extraire les valeurs du reseau à partir de la ligne"
echo "        function extractNetworkValues(line) {"
echo "            const values = line.split(/\\s+/).slice(2);"
echo "            return values.map(Number);"
echo "        }"
echo "        // Attendre la recuperation des donnees"
echo "        getDataFromFile(\"network_usage.txt\")"
echo "            .then(networkData => {"
echo "                console.log(\"Donnees d'utilisation du reseau :\", networkData);"
echo "                // Extraire les valeurs du reseau"
echo "                const values = extractNetworkValues(networkData);"
echo "                // Afficher les valeurs dans l'element HTML correspondant"
echo "                document.getElementById(\"networkData\").innerHTML = \`"
echo "                    <p>Rxpck/s  Le nombre de paquets recus par seconde: \${values[0]}</p>"
echo "                    <p>Txpck/s  Le nombre de paquets envoyes par seconde: \${values[1]}</p>"
echo "                    <p>RxkB/s Nombre moyen de kilo-octets recus par seconde: \${values[2]}</p>"
echo "                    <p>TxkB/s Nombre moyen de kilo-octets envoyes par seconde: \${values[3]}</p>"
echo "                    <p>Rxcmp/s Nombre moyen de paquets compresses recus par seconde: \${values[4]}</p>"
echo "                    <p>Txcmp/s Nombre moyen de paquets compresses envoyes par seconde: \${values[5]}</p>"
echo "                    <p>Rxmcst/s Nombre moyen de paquets multicasts recus par seconde: \${values[6]}</p>"
echo "                    <p>%ifutil Pourcentage moyen d'utilisation de l'interface reseau: \${values[7]}</p>"
echo "                \`;"
echo "            });"
echo "    </script>"
echo "</body>"
echo "</html>"

service apache2 start

# Enregistrer l'utilisation du CPU dans un fichier
ssh -i $pathtokey $log@$ip "top -b -n 1 | grep "Cpu(s)" | awk '{print $8}' > /var/www/html/cpu_usage.txt"
# Enregistrer l'utilisation de la mémoire dans un fichier
ssh -i $pathtokey $log@$ip "free -m | awk 'NR==2{print $3 " " $4}' > /var/www/html/memory_usage.txt"
# Enregistrer l'utilisation du réseau dans un fichier
ssh -i $pathtokey $log@$ip "sar -n DEV 1 1 | grep 'Average' | sed -n '2p' > /var/www/html/network_usage.txt"

touch cron_temp
echo "* * * * 1-5 ssh -i $pathtokey $log@$ip "free -m | awk 'NR==2{print $3 " " $4}' > /var/www/html/memory_usage.txt"" >> cron_temp
echo "* * * * 1-5 ssh -i $pathtokey $log@$ip "top -b -n 1 | grep "Cpu\(s\)" | awk '{print $8}' > /var/www/html/cpu_usage.txt"" >> cron_temp
echo "* * * * 1-5 ssh -i $pathtokey $log@$ip "sar -n DEV 1 1 | grep 'Average' | sed -n '2p' > /var/www/html/network_usage.txt"" >> cron_temp
crontab cron_temp
rm cron_temp
