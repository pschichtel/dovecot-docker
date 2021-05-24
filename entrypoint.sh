#!/usr/bin/env sh

find /etc/dovecot/sieve/ -type f -name '*.sieve' -exec sievec "{}" \;

echo "base_url = \"${MAILMANAGER_BASE_URL:-}\""      > /etc/dovecot/mailmanager.conf
echo "auth_token = \"${MAILMANAGER_AUTH_TOKEN:-}\"" >> /etc/dovecot/mailmanager.conf

exec dovecot -F "$@"

