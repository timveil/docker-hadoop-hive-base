#!/bin/bash

echo "creating /tmp and updating ownership"
hadoop fs -mkdir       /tmp
hadoop fs -chmod g+w   /tmp

echo "creating /user/hive/warehouse and updating ownership"
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /user/hive/warehouse

cd $HIVE_HOME/bin

echo "starting hiveserver2"
./hiveserver2 --hiveconf hive.server2.enable.doAs=false
