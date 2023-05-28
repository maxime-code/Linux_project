# Linux_project
Tout d'abord, modifier config.sh avec vos données

1) Ensuite lancer le script avec comme argument le serveur, le login de mail et le mot de passe de mail, exemple :\n
>bash script smtp.office365.com:587 maxime.roquelle@isen-ouest.yncrea.fr motdepassdemail

Si certaines applications ne sont pas déjà installés, il faudra accepter les installations en tapant "Y".
MySQL risque de demander un mot de passe pour créer la base de données Nextcloud, si MySQL n'était pas installé auparavant ou que le mot de passe n'a jamais été changé, alors il sera vide. Il faudra donc juste presser "entrer".

2) NextCloud :

Une fois le script lancé, se rendre sur http://10.30.48.100/nextcloud/index.php
Puis tapper le log de l'administrateur, puis son mot de passe et remplir les informations comme si : 


Une fois cela fait, vous pouvez créer les utilisateurs NextCloud en lançant :\n
>bash scriptNexcloud.sh

3) Monitoring : 

Lancer le script :
>bash scriptMonitoring.sh > /var/www/html/Linux_monitoring.html
\n
Puis se rendre sur http://localhost/Linux_monitoring.html
