FROM mariadb:10.1
RUN apt-get update -y && apt-get install -y curl ./my.cnf .
ADD ./my.cnf .
RUN cp /my.cnf /etc/mysql/my.cnf
ADD ./creer-bdd-application.sql .
ADD ./creer-bdd-application.sh .
ADD ./creer-utilisateur-applicatif.sql .
ADD ./creer-utilisateur-applicatif.sh .
ADD ./configurer-utilisateur-mgmt.sql .
ADD ./configurer-utilisateur-mgmt.sh .
RUN chmod +x ./creer-bdd-application.sh
RUN chmod +x ./creer-utilisateur-applicatif.sh
RUN chmod +x ./configurer-utilisateur-mgmt.sh
# Non, en réalité, il fauit utilsier l'implémentationd e healthcheck officielle fournie par docker:
# https://github.com/docker-library/healthcheck/blob/master/mysql/Dockerfile.mariadb
# et ce, avec la dépendance:
# https://github.com/docker-library/healthcheck/blob/master/mysql/docker-healthcheck
RUN curl -o docker-mariadb-healthcheck https://raw.githubusercontent.com/docker-library/healthcheck/master/mysql/docker-healthcheck
COPY docker-mariadb-healthcheck /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-mariadb-healthcheck
RUN rm -f docker-mariadb-healthcheck
HEALTHCHECK CMD ["docker-mariadb-healthcheck"]
# HEALTHCHECK --interval=1s --timeout=300s --start-period=1s --retries=300 CMD curl --fail /usr/bin/mysql --user=VAL_USER_MVN_PLUGIN_BDD --password=VAL_PWD_MVN_PLUGIN_BDD --execute "SHOW DATABASES;" || exit 1
EXPOSE 3306
CMD ["mysqld"]