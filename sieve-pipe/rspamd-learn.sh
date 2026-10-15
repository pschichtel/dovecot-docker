#!/usr/bin/env sh

set -eu

kind="${1?no kind given, expected spam or ham}"

case "$kind" in
    spam)
        ;;
    ham)
        ;;
    *)
        echo "unknown kind: $kind, expected spam or ham" >&2
        exit 1
        ;;
esac

message="$(mktemp)"
trap 'rm -f "$message"' EXIT
cat > "$message"

fuzzy() {
    fuzzy_rc=0
    output="$(rspamd-client "$@" < "$message" 2>&1)" || fuzzy_rc=$?
    case "$fuzzy_rc:$output" in
        0:*)
            printf '%s\n' "$output"
            ;;
        # messages too small for fuzzy hashing are rejected with HTTP 404, that's not an error
        *"No content to generate fuzzy"*)
            ;;
        *)
            printf '%s\n' "$output" >&2
            return "$fuzzy_rc"
            ;;
    esac
}

# run both requests even if one fails, but report the failure
rc=0
rspamd-client "learn$kind" < "$message" || rc=$?
if [ "$kind" = spam ]
then
    # flag 11 = LOCAL_FUZZY_DENIED in rspamd's local fuzzy rule
    fuzzy fuzzyadd "Flag: 11" "Weight: 10" || rc=$?
else
    # undo a previous fuzzyadd for this message
    fuzzy fuzzydel "Flag: 11" || rc=$?
fi
exit "$rc"
