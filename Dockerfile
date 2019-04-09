FROM alpine:3.9

RUN apk update \
 && apk add dovecot dovecot-lmtpd dovecot-sqlite dovecot-pigeonhole-plugin dovecot-pop3d dovecot-ldap luajit

ENTRYPOINT ["dovecot", "-F"]

