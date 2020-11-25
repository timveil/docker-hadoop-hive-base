# Docker Hadoop - Hive Base (3.1.x)

`Dockerfile` responsible for extending `docker-hadoop-core` and installing and configuring core Hive components.  This image is extended by a number of other Hive related images including HiveServe2.

## Building the Image
```bash
docker build --no-cache -t timveil/docker-hadoop-hive-base:3.1.x-fork .
```

## Publishing the Image
```bash
docker push timveil/docker-hadoop-hive-base:3.1.x-fork
```

## Running the Image
```bash
docker run -it timveil/docker-hadoop-hive-base:3.1.x-fork
```