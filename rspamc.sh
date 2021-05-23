#!/usr/bin/env sh

if [ -n "${RSPAMD_CONTROLLER_ADDRESS:-}" ]
then
    if [ -n "${RSPAMD_CONTROLLER_PASSWORD_FILE:-}" -a -r "${RSPAMD_CONTROLLER_PASSWORD_FILE}" ]
    then
        password="$(< "${RSPAMD_CONTROLLER_PASSWORD_FILE}")"
    else
        password="${RSPAMD_CONTROLLER_PASSWORD:-}"
    fi
    exec /usr/bin/rspamc --connect="${RSPAMD_CONTROLLER_ADDRESS}" --password="${password}" "$@"
else
    exec /usr/bin/rspamc "$@"
fi
