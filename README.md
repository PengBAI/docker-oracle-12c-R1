# docker-oracle-12c-R1
## Oracle 12c Release 1 
based on [https://github.com/MaksymBilenko/docker-oracle-12c](https://github.com/MaksymBilenko/docker-oracle-12c)
Please refer to [https://hub.docker.com/r/sath89/oracle-12c/](https://hub.docker.com/r/sath89/oracle-12c/) for more detail
Thanks **sath89** for his great work !
 * Impove performance on startup
 * Persist database SID xe in image
 * Delete mount feature

## Installation

```
docker pull pengbai/docker-oracle-12c-r1
```

Run with 8080 and 1521 ports opened:

```
docker run -d -p 8080:8080 -p 1521:1521 pengbai/docker-oracle-12c-r1
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
