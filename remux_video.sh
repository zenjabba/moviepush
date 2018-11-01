#!/bin/bash

dirname=$(dirname "$1")
filename=$(basename "$1")
extension=$(echo "${filename##*.}" | tr "[:upper:]" "[:lower:]")
basename="${filename%.*}"
tmpfile="$dirname/$basename-tmp.$extension"

if [[ "$extension" =~ ^(mkv|m4v|m2v|mp4|avi|mov|mpg)$ ]]; then
        ffmpeg -i "$1" -c copy -map 0 -metadata comment="$2" "$tmpfile"
        echo "Exit code: $?"
        if [ $? -eq 0 ]; then
                echo "Deleting original video"
                rm "$1"
                echo "Renaming new video"
                mv "$tmpfile" "$1"
        fi
fi
