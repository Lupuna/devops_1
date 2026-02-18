#!/bin/sh
set -e

ENV_FILE="${ENV_FILE:-/app/.env}"
printenv > "$ENV_FILE"

exec /app/main "$@"