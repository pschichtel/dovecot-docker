#!/usr/bin/env sh

echo "base_url = \"${MAILMANAGER_BASE_URL:-}\""      > /etc/dovecot/mailmanager.conf
echo "auth_token = \"${MAILMANAGER_AUTH_TOKEN:-}\"" >> /etc/dovecot/mailmanager.conf

echo "RSPAMD_CONTROLLER_ADDRESS='${RSPAMD_CONTROLLER_ADDRESS:-}'"              > /etc/default/rspamc
echo "RSPAMD_CONTROLLER_PASSWORD='${RSPAMD_CONTROLLER_PASSWORD:-}'"           >> /etc/default/rspamc
echo "RSPAMD_CONTROLLER_PASSWORD_FILE='${RSPAMD_CONTROLLER_PASSWORD_FILE:-}'" >> /etc/default/rspamc

exec dovecot -F "$@"

