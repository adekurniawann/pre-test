#!/bin/bash

# define jumlah log files dan simpan di directory 2024-09-11-access-logs
NUM_FILES=3  
LOG_DIR="./2024-09-11-access-logs"

# Generate dummy log files di directory 2024-09-11-access-logs
for i in $(seq 1 $NUM_FILES); do
    LOG_FILE="$LOG_DIR/$i-access.log"
    echo "Generating $LOG_FILE"

    # generete random status code 500 sebesar +- 20% dari 100 line
    for j in $(seq 1 100); do
        if (( RANDOM % 5 == 0 )); then
            STATUS="HTTP 500 error"
        else
            STATUS=$((RANDOM % 600))  
        fi

        # Generate random timestamp dalam 10 minutes
        MINUTES_AGO=$((RANDOM % 10))  
        SECONDS_AGO=$((RANDOM % 60))
        TIMESTAMP=$(date -d "-$MINUTES_AGO minutes -$SECONDS_AGO seconds" '+%Y-%m-%d %H:%M:%S')

        # Write the log entry ke masing2 file logs
        echo "[$TIMESTAMP] - Status: $STATUS" >> "$LOG_FILE"
    done
done
