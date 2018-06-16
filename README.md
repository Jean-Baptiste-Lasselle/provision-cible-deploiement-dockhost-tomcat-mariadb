# Utilisation

Ce repo contient:
* Une recette de provision d'une cible de déploiement tomcat / mariadb, pour y déployer des applications Jee, par exemple des "webapps", faisant usage d'une base de données mariadb
* une application web Java jee, faisant office d'exemple à déployer dans le cible provisionnée. Il s'agit d'un fichier *war, que vous trouverez dans ce repo à l'emplacement:
`./application-1/srv-jee/appli-a-deployer-pour-test.war` 

## Provision de la cible de déploiement

Ce repository contient donc une recette de provision d'une cible de déploiement tomcat / mariadb.

### Dépendances 

Cette recette doit être exécutée sur une machine sur laquelle CentOS 7 est le système d'exploitation, et sur laquelle 
la [recette de provision d'un hôte docker centos](https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos) a été exécutée. 

Cette recette a donc pour dépendances:

* Le système CentOS 7
* La recette de provision d'un [hôte docker centos](https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos)


### Exécution
Exécutez la recette de provision de la cible de déploiement (ce qui créera un répertoire `provision-dockhost-cible-deploiement-tomcat-mariadb` dans le répertoire courant):

```
export URI_REPO_GIT_RECETTE=https://github.com/Jean-Baptiste-Lasselle/provision-cible-deploiement-dockhost-tomcat-mariadb
export PROVISIONING_HOME
PROVISIONING_HOME=$(pwd)/provision-dockhost-cible-deploiement-tomcat-mariadb
rm -rf $PROVISIONING_HOME
mkdir -p $PROVISIONING_HOME
cd $PROVISIONING_HOME
export $NOMFICHIERLOG=provision.log
git clone $URI_REPO_GIT_RECETTE . 
sudo chmod +x $PROVISIONING_HOME/operations.sh
$PROVISIONING_HOME/operations.sh >> $NOMFICHIERLOG
cd $PROVISIONING_HOME
```

Soit en une seule ligne:
 
`export URI_REPO_GIT_RECETTE=https://github.com/Jean-Baptiste-Lasselle/provision-cible-deploiement-dockhost-tomcat-mariadb && export PROVISIONING_HOME && PROVISIONING_HOME=$(pwd)/provision-dockhost-cible-deploiement-tomcat-mariadb && rm -rf $PROVISIONING_HOME && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && export $NOMFICHIERLOG=provision.log && git clone $URI_REPO_GIT_RECETTE . && sudo chmod +x $PROVISIONING_HOME/operations.sh && $PROVISIONING_HOME/operations.sh && cd $PROVISIONING_HOME >> $NOMFICHIERLOG`


## Déploiements dans la cible provisionnée


Pour déployer l'application exemple de ce repo, vous trouverez un script `deployer-appli-web.sh` dans le 
répertoire `./provision-dockhost-cible-deploiement-tomcat-mariadb/application-1/srv-jee/tomcat/`, créé par 
la recette de provision de la cible de déploiement.

Exécutez-le avec les instructions suivantes:
`sudo chmod +x ./application-1/srv-jee/tomcat/deployer-appli-web.sh && ./application-1/srv-jee/tomcat/deployer-appli-web.sh $PROVISIONING_HOME/application-1/srv-jee/tomcat/appli-a-deployer-pour-test.war`


Pour déployer un fichier war quelconque, utilisez le script `deployer-appli-web.sh` de la manière suivante:

* Soit sans argument, et alors le script vous demandera interactivement, le chemin du fichier wart à déployer:
  `./provision-dockhost-cible-deploiement-tomcat-mariadb/application-1/srv-jee/tomcat/deployer-appli-web.sh`
* Soit avec un argument, par lequel vous précisez le chemin du fichier wart à déployer:
  ```
  export CHEMIN_FICHIER_WAR=/opt/deploiements/jee/une-deuxieme-application-web-jee.war
  ./application-1/srv-jee/tomcat/deployer-appli-web.sh $CHEMIN_FICHIER_WAR
  ```



# ANNEXE

```
 sudo -l -U jibl
[sudo] Mot de passe de jibl : 
Entrées par défaut pour jibl sur pc-65 :
    !visiblepw, always_set_home, match_group_by_gid, env_reset, env_keep="COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS", env_keep+="MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE", env_keep+="LC_COLLATE
    LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES", env_keep+="LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE", env_keep+="LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY",
    secure_path=/sbin\:/bin\:/usr/sbin\:/usr/bin

L'utilisateur jibl peut utiliser les commandes suivantes sur pc-65 :
    (ALL) ALL
[jibl@pc-65 ~]$

```