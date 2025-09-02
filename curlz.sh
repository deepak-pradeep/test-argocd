#!/bin/bash

LOGFILE="curl_status.log"

run_curl() {

  curl -s -o /dev/null -w "%{http_code}" --location 'https://google.com' #replace this with your curl command

}

while true; do
  TS=$(date '+%Y-%m-%d %H:%M:%S')

  CODE=$(run_curl)
  EXIT=$?

  if [ $EXIT -eq 0 ]; then
    if [ "$CODE" -ge 200 ] && [ "$CODE" -lt 300 ]; then
      STATUS="SUCCESS"
    else
      STATUS="HTTP_ERROR"
    fi
    echo "$CODE ------ $STATUS --- $TS" >> "$LOGFILE"
  else
    echo "$EXIT ------ CURL_ERROR --- $TS" >> "$LOGFILE"
  fi

done
