#!/usr/bin/env sh

set -eu

# this is necessary because the process calling this script might not inherit the env from its parent
. /etc/default/rspamc

if [ -z "${RSPAMD_CONTROLLER_ADDRESS:-}" ]
then
    echo "No rspamd controller address given! Use RSPAMD_CONTROLLER_ADDRESS env var!" 1>&2
    exit 1
fi

if [ -n "${RSPAMD_CONTROLLER_PASSWORD_FILE:-}" -a -r "${RSPAMD_CONTROLLER_PASSWORD_FILE:-}" ]
then
    password="$(cat "${RSPAMD_CONTROLLER_PASSWORD_FILE}")"
else
    password="${RSPAMD_CONTROLLER_PASSWORD:-}"
fi

endpoint=${1?no endpoint given!}
shift

# remaining arguments are additional request headers, e.g. "Flag: 11"
for header
do
    shift
    set -- "$@" -H "$header"
done

curl -sS --fail-with-body -H "Password: ${password}" "$@" --data-binary @- "http://${RSPAMD_CONTROLLER_ADDRESS}/${endpoint}"

