FROM timveil/docker-hadoop-base

LABEL maintainer="tjveil@gmail.com"

ENV HIVE_VERSION 2.3.3
ENV POSTGRESQL_JDBC_VERSION 42.2.4
ENV HIVE_HOME /opt/hive
ENV HIVE_CONF_DIR $HIVE_HOME/conf
ENV HIVE_TMP_DIR /tmp/hive
ENV PATH $HIVE_HOME/bin:$PATH

# Install Hive and PostgreSQL JDBC; procps needed for hive ps command
RUN apt-get update \
    && apt-get install -y procps \
    && curl -fSL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -o /tmp/hive.tar.gz \
    && mkdir -pv $HIVE_TMP_DIR \
    && tar -xvf /tmp/hive.tar.gz -C $HIVE_TMP_DIR --strip-components=1 \
    && mv -v $HIVE_TMP_DIR /opt \
    && rm -rfv /tmp/hive.tar.gz \
    && rm -rfv $HIVE_HOME/lib/postgresql-*.jre*.jar \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar

# Custom configuration goes here
ADD conf/hive-site.xml $HIVE_CONF_DIR
ADD conf/beeline-log4j2.properties $HIVE_CONF_DIR
ADD conf/hive-exec-log4j2.properties $HIVE_CONF_DIR
ADD conf/hive-log4j2.properties $HIVE_CONF_DIR
ADD conf/llap-daemon-log4j2.properties $HIVE_CONF_DIR
ADD conf/llap-cli-log4j2.properties $HIVE_CONF_DIR

EXPOSE 10000

# hive ui
EXPOSE 10002