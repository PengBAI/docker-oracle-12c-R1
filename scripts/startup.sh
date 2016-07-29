#!/bin/bash
set -e

echo "Starting tnslsnr" >> /var/log/startup.log 2>&1
su oracle -c "/u01/app/oracle/product/12.1.0/xe/bin/tnslsnr &"  >> /var/log/startup.log 2>&1
echo "Starting database" >> /var/log/startup.log 2>&1
su oracle -c 'echo startup\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba' >> /var/log/startup.log 2>&1
echo "Starting web console on 8080" >> /var/log/startup.log 2>&1
su oracle -c 'echo EXEC DBMS_XDB.sethttpport\(8080\)\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba' >> /var/log/startup.log 2>&1

echo "Database init..." >> /var/log/startup.log 2>&1
for f in /entrypoint-initdb.d/*; do
    case "$f" in
        *.sh)  echo "$0: running $f"; . "$f"  >> /var/log/startup.log 2>&1 ;; 
        *.sql) echo "$0: running $f"; su oracle -c "echo \@$f\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba" >> /var/log/startup.log 2>&1 ;;
        *)     echo "No volume sql script, ignoring $f"  >> /var/log/startup.log 2>&1 ;;
    esac
    echo
done
echo "End init." >> /var/log/startup.log 2>&1

echo "Oracle started Successfully !" >> /var/log/startup.log 2>&1

tail -f /var/log/startup.log

while true; do
    sleep 1m
done;
