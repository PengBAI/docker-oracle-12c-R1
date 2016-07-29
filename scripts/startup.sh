#!/bin/bash
set -e
touch /var/log/startup.log

echo "Starting tnslsnr" 2>&1 | tee /var/log/startup.log
su oracle -c "/u01/app/oracle/product/12.1.0/xe/bin/tnslsnr &" 2>&1 | tee /var/log/startup.log
echo "Starting database" 2>&1 | tee /var/log/startup.log
su oracle -c 'echo startup\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba' 2>&1 | tee /var/log/startup.log
echo "Starting web console on 8080" 2>&1 | tee /var/log/startup.log
su oracle -c 'echo EXEC DBMS_XDB.sethttpport\(8080\)\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba' 2>&1 | tee /var/log/startup.log

echo "Database init..." 2>&1 | tee /var/log/startup.log
for f in /entrypoint-initdb.d/*; do
    case "$f" in
        *.sh)  echo "$0: running $f"; . "$f"  2>&1 | tee /var/log/startup.log ;; 
        *.sql) echo "$0: running $f"; su oracle -c "echo \@$f\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba" 2>&1 | tee /var/log/startup.log ;;
        *)     echo "No volume sql script, ignoring $f"  2>&1 | tee /var/log/startup.log ;;
    esac
    echo
done
echo "End init." 2>&1 | tee /var/log/startup.log1

echo "Oracle started Successfully !" 2>&1 | tee /var/log/startup.log

while true; do
    sleep 1m
done;
