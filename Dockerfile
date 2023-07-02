FROM docker.io/library/alpine:latest
RUN apk upgrade --no-cache
RUN apk add --no-cache execline libmediainfo
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing mono
ADD https://services.sonarr.tv/v1/download/main/latest?version=3&os=linux /tmp/sonarr.tar.gz
RUN mkdir -p /opt/sonarr/bin
RUN tar xf /tmp/sonarr.tar.gz -C /opt/sonarr/bin --strip-components=1
RUN rm /tmp/sonarr.tar.gz
RUN rm -r /opt/sonarr/bin/Sonarr.Update
RUN echo UpdateMethod=Docker >/opt/sonarr/package_info
COPY /init /
EXPOSE 8989
ENTRYPOINT ["/init"]
STOPSIGNAL KILL
