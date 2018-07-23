FROM timveil/docker-hadoop-base

LABEL maintainer="tjveil@gmail.com"

ENV HIVE_VERSION 2.3.3
ENV POSTGRESQL_JDBC_VERSION 42.2.4
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH

# Install Hive and PostgreSQL JDBC
RUN curl -fSL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -o /tmp/hive.tar.gz \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && mv /opt/apache-hive-$HIVE_VERSION-bin $HIVE_HOME \
    && rm -rf /tmp/hive.tar.gz \
    && rm -rf $HIVE_HOME/lib/log4j-slf4j-impl-*.jar \
    && rm -rf $HIVE_HOME/lib/postgresql-*.jre*.jar \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar

# Custom configuration goes here
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf


EXPOSE 10000

# hive ui
EXPOSE 10002


