#!/usr/bin/env sh

find /etc/dovecot/sieve/ -type f -name '*.sieve' -exec sievec "{}" \;

exec dovecot -F "$@"

