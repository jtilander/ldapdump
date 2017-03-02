FROM alpine:3.5

RUN apk add --no-cache \
		py2-pyldap \
		python \
		bash

RUN mkdir /data && mkdir /app
VOLUME ["/data"]

COPY ldapdump.py /app/
WORKDIR /app

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dump"]
