#!/usr/bin/env bash

# Download the audio from a YouTube playlist
# There must be an active YouTube session on a Firefox browser

if [[ "$#" -eq 2 ]]
then
    mkdir -p $2
    cd $2

    local cookies_options=--cookies-from-browser\ firefox

    # attempt to find the cookies file explicitly
    local cookies_dir=$HOME/.var/app/org.mozilla.firefox/
    if [ -d $cookies_dir ]
    then
        local cookies_file_path=$(find $cookies_dir -name cookies.sqlite)
        if [ "$?" -eq 0 ]
        then
            # use parameter expansion to get only the path of the directory and not of the file itself
            cookies_file_path=${cookies_file_path%/*.*}
            cookies_options=$cookies_options:$cookies_file_path
        fi
    fi

    yt-dlp $cookies_options --format ba --extract-audio --audio-format mp3 --audio-quality 0 --output "%(playlist_index)s %(title)s.%(ext)s" $1
else
    echo "Usage: <command> <playlist-url> <output-directory>"
fi
