FROM ubuntu:14.04

ENV INFLUXDB_VERSION 0.10.3-1

#difine non interactive mode 
ENV DEBIAN_FRONTEND noninteractive

ENV	INFLUXDB_URL http://localhost:8086

ENV	INFLUXDB_DATA_USER root
ENV	INFLUXDB_DATA_PW root
ENV	INFLUXDB_GRAFANA_USER root
ENV	INFLUXDB_GRAFANA_PW root
ENV	ROOT_PW root
ENV CONFIG_FILE="/etc/influxdb/influxdb.conf"
ENV API_URL="http://localhost:8086"

#Keep Package List Updated & software upgraded
RUN apt-get -y update 
RUN apt-get -y upgrade

#Install VIM , in case you need to change any config inside docker.  
FROM  confluent/postgres-bw:0.1
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "vim"]

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "wget"]

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "curl"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates apt-transport-https

RUN wget -q https://repos.influxdata.com/influxdb.key && \
    gpg --import influxdb.key && \
    rm -f influxdb.key

ENV INFLUXDB_VERSION 0.10.3

RUN wget -q https://s3.amazonaws.com/influxdb/influxdb_$INFLUXDB_VERSION-1_amd64.deb.asc && \
    wget -q https://s3.amazonaws.com/influxdb/influxdb_$INFLUXDB_VERSION-1_amd64.deb && \
    gpg --verify influxdb_$INFLUXDB_VERSION-1_amd64.deb.asc influxdb_$INFLUXDB_VERSION-1_amd64.deb && \
    dpkg -i influxdb_$INFLUXDB_VERSION-1_amd64.deb && \
    rm -f influxdb_$INFLUXDB_VERSION-1_amd64.deb*

#Exposing port influxdb
EXPOSE 8083 8086 8088 8091 
#jmeter
EXPOSE 2003

ENV INFLUXDB_META_DIR=/var/lib/influxdb/meta \
    INFLUXDB_DATA_DIR=/var/lib/influxdb/data \
    INFLUXDB_DATA_WAL_DIR=/var/lib/influxdb/wal \
    INFLUXDB_HINTED_HANDOFF_DIR=/var/lib/influxdb/hh

VOLUME ["/var/lib/influxdb"]

COPY influxdb.conf /etc/influxdb/influxdb.conf

CMD ["influxd", "-config=/etc/influxdb/influxdb.conf"]
