# docker-files

Directory Structure
```
docker
|-- docker-files
|   |-- README.md
|   |-- docker-compose-kafka.yaml
|   |-- docker-compose-nginx.yaml
|   `-- docker-compose-postgres.yaml
|-- kafka-docker
|   |-- docker-compose-kafka.yaml
|   `-- kafka_data
|-- nginx-docker
|   |-- docker-compose-nginx.yaml
|   `-- var
|       `-- www
|           `-- html
|               `-- index.html
|-- postgres-docker
|   |-- db
|   `-- docker-compose-postgres.yaml
```

# nginx docker

Starting nginx docker

```
$ cd docker/nginx-docker
$ docker compose -f docker-compose-nginx.yaml up

time="2024-07-15T12:05:02+05:30" level=warning msg="D:\\Sanjeev\\docker\\nginx-docker\\docker-compose-nginx.yaml: `version` is obsolete"
[+] Running 1/1
 ✔ Container nginx-docker-nginx-1  Recreated                                                                       0.7s
Attaching to nginx-1
nginx-1  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
nginx-1  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
nginx-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
nginx-1  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
nginx-1  | 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
nginx-1  | /docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
nginx-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
nginx-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
nginx-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
nginx-1  | 2024/07/15 06:35:04 [notice] 1#1: using the "epoll" event method
nginx-1  | 2024/07/15 06:35:04 [notice] 1#1: nginx/1.27.0
nginx-1  | 2024/07/15 06:35:04 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
nginx-1  | 2024/07/15 06:35:04 [notice] 1#1: OS: Linux 5.15.153.1-microsoft-standard-WSL2
```
Check nginx docker
```
$ docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED         STATUS                        PORTS                    NAMES
4ed79c855b82   nginx:latest         "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes                  0.0.0.0:80->80/tcp       nginx-docker-nginx-1
```

Issue command  to nginx docker image
```
$ docker exec -it nginx-docker-nginx-1 nginx -t

nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful


$ docker exec -it nginx-docker-nginx-1 env

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=127.0.0.1
TERM=xterm
NGINX_VERSION=1.27.0
NJS_VERSION=0.8.4
NJS_RELEASE=2~bookworm
PKG_RELEASE=2~bookworm
HOME=/root

```

Starting docker for postgres in background
```
$ docker compose -f docker-compose-postgres.yaml up -d
time="2024-07-15T12:17:45+05:30" level=warning msg="D:\\Sanjeev\\docker\\postgres-docker\\docker-compose-postgres.yaml: `version` is obsolete"
[+] Running 1/1
 ✔ Container postgres-docker-postgres-1  Started        
 
 $ docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS                        PORTS                    NAMES
9542cdcaa6a3   postgres:14-alpine   "docker-entrypoint.s…"   2 minutes ago    Up 2 minutes                  0.0.0.0:5432->5432/tcp   postgres-docker-postgres-1

 ```

postgres docker image check database schema
```
$ docker exec -it  postgres-docker-postgres-1 psql -U root wiki -c "\l" -c "\du;" -c "\dn;"
                                  List of databases
   Name    |   Owner   | Encoding |  Collate   |   Ctype    |    Access privileges
-----------+-----------+----------+------------+------------+-------------------------
 org_db    | root      | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | root      | UTF8     | en_US.utf8 | en_US.utf8 |
 root      | root      | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | root      | UTF8     | en_US.utf8 | en_US.utf8 | =c/root                +
           |           |          |            |            | root=CTc/root
 template1 | root      | UTF8     | en_US.utf8 | en_US.utf8 | =c/root                +
           |           |          |            |            | root=CTc/root
 testdb    | test_user | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/test_user          +
           |           |          |            |            | test_user=CTc/test_user
 wiki      | root      | UTF8     | en_US.utf8 | en_US.utf8 |
(7 rows)

                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 root      | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test_user | Cannot login                                               | {}

List of schemas
  Name  | Owner
--------+-------
 public | root
(1 row)


What's next:
    Try Docker Debug for seamless, persistent debugging tools in any container or image → docker debug postgres-docker-postgres-1
    Learn more at https://docs.docker.com/go/debug-cli/

```


kafka docker
```

Madhavi@madhavikrishna MINGW64 /d/Sanjeev/docker/kafka-docker
$ docker compose -f docker-compose-kafka.yaml up -d
time="2024-07-15T12:21:43+05:30" level=warning msg="D:\\Sanjeev\\docker\\kafka-docker\\docker-compose-kafka.yaml: `version` is obsolete"
[+] Running 1/1
 ✔ Container kafka-docker-kafka-1  Started                                                                         0.5s

$ docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS                          PORTS                    NAMES
c9aad26ce792   bitnami/kafka:3.7    "/opt/bitnami/script…"   20 seconds ago   Up 19 seconds                   0.0.0.0:9092->9092/tcp   kafka-docker-kafka-1



$ docker exec -it  kafka-docker-kafka-1 kafka-topics.sh  --bootstrap-server localhost:9092 --list
__consumer_offsets
solobyte-kafka-primer-topic
test

$ docker exec -it  kafka-docker-kafka-1 kafka-topics.sh  --bootstrap-server localhost:9092 --describe --topic test
Topic: test     TopicId: H8nHQVwmQyCYYJ9HCgAJkg PartitionCount: 1       ReplicationFactor: 1    Configs:
        Topic: test     Partition: 0    Leader: 0       Replicas: 0     Isr: 0


$ docker exec -it  kafka-docker-kafka-1 kafka-topics.sh  --bootstrap-server localhost:9092 --describe --topic solobyte-kafka-primer-topic
Topic: solobyte-kafka-primer-topic      TopicId: 2TKHP0ztQvaeBnZMJiF31Q PartitionCount: 1       ReplicationFactor: 1   Configs:
        Topic: solobyte-kafka-primer-topic      Partition: 0    Leader: 0       Replicas: 0     Isr: 0

```


$ docker exec -it  kafka-docker-kafka-1 kafka-topics.sh  --bootstrap-server localhost:9092 --describe --topic solobyte-kafka-primer-topic

$ docker exec -it  kafka-docker-kafka-1 kafka-run-class.sh kafka.admin.ConsumerGroupCommand  --group my-group  --bootstrap-server localhost:9092  --describe
	
