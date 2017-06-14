# jmeter-grafana-influxdb-docker

Real time  monitoring solution :

This is very simple solution :

First of all install docker and add a docker user.

Running grafana ->
From command line :

sh run-grafana-docker.sh

Running Influxdb -> From command line

sh build.sh

and after building the image , from command line

sh run-influx-docker.sh

# Exposed Links

Grafana Dashboard (admin, admin) -> http://localhost:3000/

InfluxDB admin -> http://localhost:8083/

influxDB access localhost:8086

influxdb jmeter access localhost:2003
 
 
 use for testing
