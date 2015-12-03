FROM debian:jessie

ENV http_proxy=http://proxy.wdf.sap.corp:8080 \
    https_proxy=http://proxy.wdf.sap.corp:8080 \
    no_proxy=sap.corp,localhost,127.0.0.1

ADD sap_global_root_ca.crt /usr/local/share/ca-certificates/

RUN (apt-get update &&\
  apt-get install -y curl wget jq)
### use docker-1.6.2; upgrading will break password decryption
RUN (wget "https://get.docker.com/builds/Linux/x86_64/docker-1.6.2" -O /usr/bin/docker &&\
  chmod +x /usr/bin/docker)
ADD migrator.sh /usr/local/bin/migrator.sh




CMD ["/usr/local/bin/migrator.sh"]
