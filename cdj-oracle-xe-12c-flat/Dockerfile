########################################
#  refer to https://github.com/MaksymBilenko/docker-oracle-12c
#  localhost:1521:xe	
#		username: system		password: oracle
#  http://localhost:8080/apex 	
#		workspace: INTERNAL		user: ADMIN		password: 0Racle$
########################################
FROM pengbai/oracle-12c-base:tmp

MAINTAINER https://github.com/PengBAI

LABEL oracle.version=oracle-12c-R1

EXPOSE 1521 8080

CMD /startAll.sh