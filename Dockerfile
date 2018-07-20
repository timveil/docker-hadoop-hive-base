FROM timveil/docker-hadoop-base

LABEL maintainer="tjveil@gmail.com"

ENV HIVE_VERSION 2.3.3
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

WORKDIR /opt

# Install Hive and PostgreSQL JDBC
RUN apt-get update \
    && apt-get install -y wget procps \
    && wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz \
    && tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz \
    && mv apache-hive-$HIVE_VERSION-bin hive \
    && wget https://jdbc.postgresql.org/download/postgresql-42.2.4.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar \
    && rm -rf apache-hive-$HIVE_VERSION-bin.tar.gz \
    && rm -rf $HIVE_HOME/lib/log4j-slf4j-impl-*.jar \
    && apt-get --purge remove -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Custom configuration goes here
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
#ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
#ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 10000

# hive ui
EXPOSE 10002

#ENTRYPOINT ["/entrypoint.sh"]

CMD ["/startup.sh"]
