FROM timveil/docker-hadoop-base

LABEL maintainer="tjveil@gmail.com"

ENV HIVE_VERSION 2.3.3
ENV HIVE_HOME /opt/hive-$HIVE_VERSION
ENV PATH $HIVE_HOME/bin:$PATH

# Install Hive and PostgreSQL JDBC
RUN curl -fSL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -o /tmp/hive.tar.gz \
    && tar -xzvf /tmp/hive.tar.gz -C /opt/ \
    && mv /opt/apache-hive-$HIVE_VERSION-bin $HIVE_HOME \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-42.2.4.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar \
    && rm -rf /tmp/hive.tar.gz \
    && rm -rf $HIVE_HOME/lib/log4j-slf4j-impl-*.jar

# Custom configuration goes here
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 10000

# hive ui
EXPOSE 10002

CMD ["/startup.sh"]
