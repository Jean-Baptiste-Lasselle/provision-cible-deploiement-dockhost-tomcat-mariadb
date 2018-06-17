FROM mariadb:10.1
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
HEALTHCHECK --interval=1s --timeout=300s --start-period=1s --retries=300 CMD curl --fail http://VAL_ADRESSE_IP_SRV_MARIADB:VAL_NO_PORT_IP_SRV_MARIADB/ || exit 1
EXPOSE 3306
CMD ["mysqld"]