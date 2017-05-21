#!/bin/bash

if [[ ! -r "$1" ]]; then
    echo "Usage: ./parsh.sh [file.chlsj]"
    exit 1
fi

outfile="$(basename "$1" chlsj)csv"

echo "time,latency,duration,headers,body,X-Cache-CF,X-Cache,X-Cache-Remote" > "$outfile"

./jq-osx-amd64 -r -f parse.jq "$1" >> "$outfile"
