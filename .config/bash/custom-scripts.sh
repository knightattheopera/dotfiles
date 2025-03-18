#!/usr/bin/env bash

# aliases that depend on relatively complex scripts
# the convention here is that all functions declared here occupy the __custom_script namespace.

# rclone syncs
function __custom_script_sync_home_directory_with_drive_using_rclone {
	local FILTER_FILES_DIR="$HOME/.config/rclone/filters/"
	cd ~

	echo "Syncing Pictures/Backups..."
	rclone sync --interactive "Pictures/Backups" "gdrive-archivos:Pictures Backups"

	echo
	echo "Syncing Documents..."
	rclone sync --interactive "Documents" "gdrive-archivos:Laptop Home/Documents"

	echo
	echo "Syncing books..."
	rclone sync --interactive "books" "gdrive-archivos:Laptop Home/books"

	echo
	echo "Syncing Music..."
	rclone sync --interactive --include="/README.md" --include="download-playlist.sh" --include="m4a-to-mp3.sh" "Music" "gdrive-archivos:Laptop Home/Music"

	echo
	echo "Starting syncs with filters..."
	local GENERAL_FILTER_FILE="${FILTER_FILES_DIR}general-filter-file.txt"
	if [ ! -f "$GENERAL_FILTER_FILE" ]
	then
		echo "Could not find file '$GENERAL_FILTER_FILE'. Skipping all syncs with filters..."
	else
		echo
		echo "Syncing projects..."
		local FILTER_FILE="${FILTER_FILES_DIR}projects-filter-file.txt"
		if [ ! -f "$FILTER_FILE" ]
		then
			echo "Could not find file '$FILTER_FILE'. Skipping sync."
		else
			rclone sync --interactive --copy-links --filter-from="$GENERAL_FILTER_FILE" --filter-from="$FILTER_FILE" "projects" "gdrive-archivos:Laptop Home/projects"
		fi

		echo
		echo "Syncing coding..."
		rclone sync --interactive --copy-links --filter-from="$GENERAL_FILTER_FILE" "coding" "gdrive-archivos:Laptop Home/coding"

		echo
		echo "Syncing courses..."
		FILTER_FILE="${FILTER_FILES_DIR}courses-filter-file.txt"
		if [ ! -f "$FILTER_FILE" ]
		then
			echo "Could not find file '$FILTER_FILE'. Skipping sync."
		else
			rclone sync --interactive --copy-links --filter-from="$GENERAL_FILTER_FILE" --filter-from="$FILTER_FILE" "courses" "gdrive-archivos:Laptop Home/courses"
		fi
	fi

	echo "Done."
}
alias sync-home=__custom_script_sync_home_directory_with_drive_using_rclone

# basic script to download music
# assumes you are logged in to youtube on firefox 
function __custom_script_download_music_playlist_as_mp3 {
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

		yt-dlp $cookies_options --format ba --extract-audio --audio-format mp3 --audio-quality 0 --output "%(playlist_index)s-%(title)s.%(ext)s" $1
	else
		echo "Usage: yt-mp3 <playlist-url> <output-directory>"
	fi
}
alias yt-mp3=__custom_script_download_music_playlist_as_mp3

# change current course latex notes directory
function __custom_script_change_current_course_latex_notes {
	if [ "$#" -eq 2 ]
	then
		local latex_notes_path=$HOME/latex-notes/$1/$2
		if [ -d $latex_notes_path ]
		then
			ln -sfn $latex_notes_path/ultisnips/$2.snippets ~/.vim/ultisnips-snippets/tex/current
			cd $latex_notes_path
		else
			echo "course or semester not found"
			echo "Usage: switch-notes <semester-code> <course-code>"
		fi
	else
		echo "Usage: switch-notes <semester-code> <course-code>"
	fi
}
alias switch-notes=__custom_script_change_current_course_latex_notes
