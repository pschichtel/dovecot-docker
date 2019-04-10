FROM debian:buster-slim

RUN apt-get update \
 && apt-get install -y dovecot-imapd dovecot-lmtpd dovecot-sqlite dovecot-sieve dovecot-managesieved dovecot-pop3d dovecot-ldap dovecot-lucene dovecot-auth-lua

RUN adduser --system --group --home "/var/lib/vmail" --disabled-login --disabled-password vmail

ENTRYPOINT ["dovecot", "-F"]

