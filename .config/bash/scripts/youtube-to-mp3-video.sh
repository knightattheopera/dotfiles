#!/usr/bin/env bash

# Download the audio from a YouTube playlist
# There must be an active YouTube session on a Chromium browser

if [[ "$#" -eq 2 ]]
then
    mkdir -p "$2"
    cd "$2"

    # cookies_options=--cookies-from-browser\ firefox
    cookies_options=--cookies-from-browser\ chromium

    # attempt to find the cookies file explicitly
    # for firefox
    # cookies_dir=$HOME/.var/app/org.mozilla.firefox/
    # cookies_file_name=cookies.sqlite
    # for chromium
    cookies_dir=$HOME/.var/app/org.chromium.Chromium/
    cookies_file_name=Cookies
    if [ -d $cookies_dir ]
    then
        cookies_file_path=$(find $cookies_dir -name $cookies_file_name)
        if [ "$?" -eq 0 ]
        then
            # use parameter expansion to get only the path of the directory and not of the file itself
            cookies_file_path=${cookies_file_path%/*.*}
            cookies_options=$cookies_options:$cookies_file_path
        fi
    fi

    format_options=--format\ ba\ --extract-audio\ --audio-format\ mp3\ --audio-quality\ 0

    uvx --with yt-dlp-getpot-wpc yt-dlp -v $cookies_options $format_options --js-runtimes node --extractor-args "youtube:player-client=default,web_music" --split-chapters --output "chapter:%(section_number)02d %(section_title)s.%(ext)s" $1
else
    echo "Usage: <command> <playlist-url> <output-directory>"
fi
