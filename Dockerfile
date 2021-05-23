FROM debian:buster-slim

LABEL maintainer="Phillip Schichtel <phillip@schich.tel>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install --no-install-recommends -y gnupg ca-certificates \
 && apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 3FA347D5E599BE4595CA2576FFA232EDBF21E25E \
 && echo "deb http://rspamd.com/apt-stable/ buster main" > /etc/apt/sources.list.d/rspamd.list \
 && apt-get purge -y gnupg \
 && apt-get autoremove --purge -y \
 && apt-get update

RUN apt-get update \
 && apt-get install -y --no-install-recommends dovecot-imapd dovecot-lmtpd dovecot-sqlite dovecot-sieve dovecot-managesieved dovecot-pop3d dovecot-ldap dovecot-lucene dovecot-auth-lua lua-socket lua-json rspamd

RUN addgroup --system --gid 5000 vmail \
 && adduser --system --uid 5000 --ingroup vmail --home "/var/lib/vmail" --disabled-login --disabled-password vmail

COPY rspamc.sh /usr/local/bin/rspamc
COPY sieve /etc/dovecot/sieve
COPY entrypoint.sh /docker-entrypoint.sh

COPY mailmanager/auth-mailmanager.auth /etc/dovecot/auth-mailmanager.lua
COPY mailmanager/auth-mailmanager.conf /etc/dovecot/conf.d/auth-mailmanager.conf.ext

ENTRYPOINT ["/docker-entrypoint.sh"]

