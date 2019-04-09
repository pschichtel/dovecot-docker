FROM alpine:3.9

RUN apk update \
 && apk add dovecot luajit

ENTRYPOINT ["dovecot", "-F"]

