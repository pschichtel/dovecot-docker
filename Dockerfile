FROM debian:buster-slim

LABEL maintainer="Phillip Schichtel <phillip@schich.tel>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends dovecot-imapd dovecot-lmtpd dovecot-sqlite dovecot-sieve dovecot-managesieved dovecot-pop3d dovecot-ldap dovecot-lucene dovecot-auth-lua lua-socket lua-json

RUN addgroup --system --gid 5000 vmail \
 && adduser --system --uid 5000 --ingroup vmail --home "/var/lib/vmail" --disabled-login --disabled-password vmail

ENTRYPOINT ["dovecot", "-F"]

