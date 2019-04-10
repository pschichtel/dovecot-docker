FROM alpine:3.9

RUN apk update \
 && apk add dovecot dovecot-lmtpd dovecot-sqlite dovecot-pigeonhole-plugin dovecot-pigeonhole-plugin-ldap dovecot-pop3d dovecot-ldap dovecot-fts-lucene luajit

RUN addgroup -S vmail \
 && adduser -S -h "/var/lib/vmail" -s "/bin/false" -g vmail vmail

ENTRYPOINT ["dovecot", "-F"]

