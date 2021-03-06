FROM ubuntu:20.04

ENV VERSION=2.7.1

ADD https://s3.amazonaws.com/files.molo.ch/builds/ubuntu-20.04/moloch_$VERSION-1_amd64.deb .
RUN apt-get update && \
apt-get install -y curl libwww-perl libjson-perl ethtool libyaml-dev && \
dpkg -i moloch_$VERSION-1_amd64.deb && \
apt-get install -y libmagic-dev && \
rm -rf moloch_$VERSION-1_amd64.deb && \
rm -rf /var/lib/apt/lists/*

WORKDIR /data/moloch
RUN curl https://raw.githubusercontent.com/maxmind/MaxMind-DB/master/test-data/GeoIP2-Anonymous-IP-Test.mmdb > /data/moloch/etc/GeoLite2-Country.mmdb
RUN curl https://raw.githubusercontent.com/wireshark/wireshark/master/manuf > /data/moloch/etc/oui.txt
RUN mkdir raw

COPY *.sh ./
COPY config.default.ini ./etc/config.ini

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
