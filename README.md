# docker-oracle-12c-R1
## Oracle 12c Release 1 

[![imagelayers.io](https://badge.imagelayers.io/pengbai/docker-oracle-12c-r1:latest.svg)](https://imagelayers.io/?images=pengbai/docker-oracle-12c-r1:latest 'Get your own badge on imagelayers.io')
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/pengbai/docker-oracle-12c-r1/)

Image on docker hub: [https://hub.docker.com/r/pengbai/docker-oracle-12c-r1/](https://hub.docker.com/r/pengbai/docker-oracle-12c-r1/)

Based on [https://github.com/MaksymBilenko/docker-oracle-12c](https://github.com/MaksymBilenko/docker-oracle-12c).

Thanks **sath89** for his great work !

Changes as needed:
 * Add startup sql **init** database feature **NEW!**
 * Easy to use, **just pull and run**
 * Impove performance on startup
 * Persist database SID xe in image

## Description

Pull image:
```
docker pull pengbai/docker-oracle-12c-r1
```

Run with 8080 and 1521 ports opened:
```
docker run -d -p 8080:8080 -p 1521:1521 pengbai/docker-oracle-12c-r1
```

**NEW!** Option: Execute automatically scripts sql when contaner startup:

In folder where you put your ```*.sql``` files for database init from /local-initdb to ```/entrypoint-initdb.d``` in contaner
```
docker run -d -p 8080:8080 -p 1521:1521 -v /local-initdb:/entrypoint-initdb.d pengbai/docker-oracle-12c-r1
```

Connect database with following setting:
```
hostname: localhost
port: 1521
sid: xe
username: system
password: oracle
```

Password for SYS & SYSTEM:
```
oracle
```

Connect to Oracle Application Express web management console with following settings:
```
http://localhost:8080/apex
workspace: INTERNAL
user: ADMIN
password: 0Racle$
```
