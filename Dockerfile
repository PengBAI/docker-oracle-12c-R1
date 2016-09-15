########################################
#  refer to https://github.com/PengBAI/docker-oracle-12c-R1
#  based on https://github.com/MaksymBilenko/docker-oracle-12c
#  localhost:1521:xe	
#		username: system		password: oracle
#  http://localhost:8080/apex 	
#		workspace: INTERNAL		user: ADMIN		password: 0Racle$
########################################
FROM sath89/oracle-12c-base

MAINTAINER https://github.com/PengBAI

LABEL oracle.version=oracle-12c-R1

ENV DBCA_TOTAL_MEMORY 1024
ENV ORACLE_HOME	/u01/app/oracle/product/12.1.0/xe
ENV ORACLE_SID xe

ADD scripts /scripts
RUN chmod +x /scripts/*
RUN /scripts/install.sh

EXPOSE 1521 8080

CMD /scripts/startup.sh