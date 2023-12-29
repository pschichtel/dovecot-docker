ARG DEBIAN_CODENAME="bullseye"

FROM debian:${DEBIAN_CODENAME}-slim

ARG DEBIAN_CODENAME

LABEL maintainer="Phillip Schichtel <phillip@schich.tel>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends dovecot-imapd dovecot-lmtpd dovecot-sieve dovecot-managesieved dovecot-solr dovecot-auth-lua lua-socket lua-json curl

RUN addgroup --system --gid 5000 vmail \
 && adduser --system --uid 5000 --ingroup vmail --home "/var/lib/vmail" --disabled-login --disabled-password vmail

COPY rspamd-client.sh /usr/local/bin/rspamd-client
COPY entrypoint.sh /docker-entrypoint.sh

COPY auth-mailmanager.lua /etc/dovecot/auth-mailmanager.lua
COPY conf.d/* /etc/dovecot/conf.d/

COPY sieve /usr/lib/dovecot/sieve
RUN find /usr/lib/dovecot/sieve/ -type f -name '*.sieve' -exec sievec "{}" \;

COPY sieve-pipe /usr/lib/dovecot/sieve-pipe

VOLUME [ "/var/lib/vmail" ]

ENTRYPOINT ["/docker-entrypoint.sh"]

