FROM ubuntu:14.04

ARG GRAFANA_VERSION

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

RUN apt-get update && \
    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates && \
    apt-get clean && \
    curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3000

VOLUME ["/data", "/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

COPY ./gr.sh /gr.sh

ENTRYPOINT ["/gr.sh"]