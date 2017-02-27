FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install --no-install-recommends -y \
	python \
	python-ldap \
	inetutils-ping && \
	rm -rf /var/lib/apt/lists/*

ENV VISUAL=vi LDAP_USER=nobody LDAP_PASSWORD=password LDAP_SERVER=not_set LDAP_BASE_DN=notset
RUN mkdir /data && mkdir /app
VOLUME ["/data"]

COPY docker-entrypoint.sh /
WORKDIR /app

COPY ldapdump.py /app/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dump"]
