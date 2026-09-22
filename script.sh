#!/bin/bash
set -uo pipefail

INTERVAL=10
ITERATIONS=6
LOGFILE="${1:-monitor.log}"

if ! touch "$LOGFILE" 2>/dev/null; then
    echo "Ошибка: не могу писать в $LOGFILE" >&2
    exit 1
fi

for ((i = 1; i <= ITERATIONS; i++)); do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        df -h
        uptime
        echo
    } >> "$LOGFILE"

    [ "$i" -lt "$ITERATIONS" ] && sleep "$INTERVAL"
done

echo "Готово: $ITERATIONS замеров записано в $LOGFILE"
