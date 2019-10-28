# docker-hadoop-hive-base

docker build --no-cache -t timveil/docker-hadoop-hive-base:3.1.x .

docker push timveil/docker-hadoop-hive-base:3.1.x

Original SLF4J error

```
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/hive/lib/log4j-slf4j-impl-2.6.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
```

Removing conflicting dependencies to solve above
```
rm -rfv $HADOOP_HOME/share/hadoop/common/lib/slf4j-log4j12-*.jar
```


New error after above command; this indicates that calls to hadoop (when adding tez jars) have no logger.  this isn't great but probably not as bad as original
```
adding tez libs hadoop
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
```