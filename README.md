# Linux_project
Tout d'abord, modifier config.sh avec vos données

## 1) Ensuite lancer le script avec comme argument le serveur, le login de mail et le mot de passe de mail, exemple :
>bash script smtp.office365.com:587 maxime.roquelle@isen-ouest.yncrea.fr motdepassdemail

Si certaines applications ne sont pas déjà installése, il faudra accepter les installations en tapant "Y".
MySQL risque de demander un mot de passe pour créer la base de données Nextcloud, si MySQL n'était pas installé auparavant ou que le mot de passe n'a jamais été changé, alors il sera vide. Il faudra donc juste presser "entrer".

## 2) NextCloud :

Une fois le script lancé, se rendre sur http://10.30.48.100/nextcloud/index.php
Puis rentrer :
-log de l'administrateur (nextcloud-admin)
-puis son mot de passe (N3x+_Cl0uD)

Choisir la base de données MySQL puis :

-utilisateur de la base de données (isen)
-mot de passe de la base de données (nesi3630)
-nom de la base de données (nextcloudBASEDEDONNEES)

Une fois cela fait, l'installation de NextCloud va continuer. Vous pouvez créer les utilisateurs NextCloud en lançant :
>bash scriptNexcloud.sh

## 3) Monitoring : 

Executer le script :
>bash scriptMonitoring.sh > /var/www/html/Linux_monitoring.html

Puis se rendre sur http://localhost/Linux_monitoring.html
