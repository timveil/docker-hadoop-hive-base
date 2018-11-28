# docker-hadoop-hive-base

docker build --no-cache -t timveil/docker-hadoop-hive-base:2.3.x .


Removing conflicting dependencies which cause multiple binding warnings in slf4j
```
RUN rm -rfv $HADOOP_HOME/share/hadoop/common/lib/slf4j-log4j12-*.jar $HADOOP_HOME/share/hadoop/common/lib/log4j-*.jar
```


after removing above jars, the following is seen
```
# SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
# SLF4J: Defaulting to no-operation (NOP) logger implementation
# SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
```