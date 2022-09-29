#!/bin/bash

FILE=$1

while read -r line
do
  #TIMESTAMP=$(echo $line | jq '.timestamp')
  TIMESTAMP=$(echo "$line" | grep -o "\"timestamp\":\d*\.*\d*" | cut -d ":" -f 2)
  EPOCH_TIME=$(echo "$TIMESTAMP" | cut -d "." -f 1)
  MILLISECONDS=$(echo "$TIMESTAMP" | cut -d "." -s -f 2)
  UTC_TIME=$(date -r "$EPOCH_TIME" -u +"%Y-%m-%dT%T")
  if [ -n "$MILLISECONDS" ]
  then
    UTC_TIME=$UTC_TIME.$MILLISECONDS
  fi
  echo "${line/"$TIMESTAMP"/"$UTC_TIME"}"
done < "$FILE"
