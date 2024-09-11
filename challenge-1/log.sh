#!/bin/bash

#Define logs directory dan timestamp 
LOG_DIR="./2024-09-11-access-logs"
NOW=$(date '+%Y-%m-%d %H:%M:%S')
TEN_MINUTES_AGO=$(date -d '-10 minutes' '+%Y-%m-%d %H:%M:%S')

# Looping setiap log files di directory 2024-09-11-access-logs
for LOG_FILE in "$LOG_DIR"/*.log; do
    # Filter lines dengan "Status: HTTP 500 error" kemudian filter timestam dalam 20 menit terakhir
    ERROR_COUNT=$(grep 'Status: HTTP 500 error' "$LOG_FILE" | awk -v now="$NOW" -v ten_mins_ago="$TEN_MINUTES_AGO" '
    BEGIN { count = 0 }
    {
        log_time = substr($0, 2, 19)
        if (log_time >= ten_mins_ago && log_time <= now) {
            count++
        }
    }
    END { print count }')
    
    echo "There were: $ERROR_COUNT -- HTTP 500 Errors in file $(basename "$LOG_FILE") in last 10 minutes"
done