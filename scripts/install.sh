#!/bin/bash
set -e
# Prevent owner issues on mounted folders
chown -R oracle:dba /u01/app/oracle
rm -f /u01/app/oracle/product
ln -s /u01/app/oracle-product /u01/app/oracle/product

#Run Oracle root scripts
/u01/app/oraInventory/orainstRoot.sh > /dev/null 2>&1
echo | /u01/app/oracle/product/12.1.0/xe/root.sh > /dev/null 2>&1 || true

echo "Initializing database."
mv /u01/app/oracle-product/12.1.0/xe/dbs /u01/app/oracle/dbs
ln -s /u01/app/oracle/dbs /u01/app/oracle-product/12.1.0/xe/dbs

#create DB for SID: xe
su oracle -c "$ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname xe.oracle.docker -sid xe -responseFile NO_VALUE -characterSet AL32UTF8 -totalMemory $DBCA_TOTAL_MEMORY -emConfiguration LOCAL -pdbAdminPassword oracle -sysPassword oracle -systemPassword oracle"

#config Apex console
echo "Configuring Apex console"
cd $ORACLE_HOME/apex
su oracle -c 'echo -e "0Racle$\n8080" | $ORACLE_HOME/bin/sqlplus -S / as sysdba @apxconf > /dev/null'
su oracle -c 'echo -e "${ORACLE_HOME}\n\n" | $ORACLE_HOME/bin/sqlplus -S / as sysdba @apex_epg_config_core.sql > /dev/null'
su oracle -c 'echo -e "ALTER USER ANONYMOUS ACCOUNT UNLOCK;" | $ORACLE_HOME/bin/sqlplus -S / as sysdba > /dev/null'

rm /scripts/install.sh