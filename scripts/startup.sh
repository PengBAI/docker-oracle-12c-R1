#!/bin/bash

echo "Starting tnslsnr"
su oracle -c "/u01/app/oracle/product/12.1.0/xe/bin/tnslsnr &"
echo "Starting database"
su oracle -c 'echo startup\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'
echo "Starting web console on 8080"
su oracle -c 'echo EXEC DBMS_XDB.sethttpport\(8080\)\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'

echo "Oracle started Successfully !"
while true; do
    sleep 1m
done;
