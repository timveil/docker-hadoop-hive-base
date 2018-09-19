FROM timveil/docker-hadoop-core:3.1.x

LABEL maintainer="tjveil@gmail.com"

ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH
ENV HIVE_CONF_DIR=$HIVE_HOME/conf

ARG HIVE_VERSION=3.1.0
ARG HIVE_DOWNLOAD_DIR=/tmp/hive
ARG POSTGRESQL_JDBC_VERSION=42.2.5

# Install Hive and PostgreSQL JDBC
RUN curl -fSL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -o /tmp/hive.tar.gz \
    && mkdir -pv $HIVE_DOWNLOAD_DIR \
    && tar -xvf /tmp/hive.tar.gz -C $HIVE_DOWNLOAD_DIR --strip-components=1 \
    && mv -v $HIVE_DOWNLOAD_DIR /opt \
    && rm -rfv /tmp/hive.tar.gz \
    && rm -rfv $HIVE_HOME/lib/postgresql-*.jre*.jar \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar

# Removing conflicting debendinceis which cause multiple binding warnings in slf4j
# RUN rm -rfv $HADOOP_HOME/share/hadoop/common/lib/slf4j-log4j12-*.jar $HADOOP_HOME/share/hadoop/common/lib/log4j-*.jar

# after removing above jars, the following is seen
# SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
# SLF4J: Defaulting to no-operation (NOP) logger implementation
# SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.

# Custom configuration goes here
ADD conf/hive-site.xml $HIVE_CONF_DIR
ADD conf/metastore-site.xml $HIVE_CONF_DIR
ADD conf/metastore-log4j2.properties $HIVE_CONF_DIR
ADD conf/beeline-log4j2.properties $HIVE_CONF_DIR
ADD conf/hive-exec-log4j2.properties $HIVE_CONF_DIR
ADD conf/hive-log4j2.properties $HIVE_CONF_DIR
ADD conf/llap-daemon-log4j2.properties $HIVE_CONF_DIR
ADD conf/llap-cli-log4j2.properties $HIVE_CONF_DIR

EXPOSE 10000

# hive ui
EXPOSE 10002