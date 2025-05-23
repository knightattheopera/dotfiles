#!/user/bin/env bash

function sync-home {
	local FILTER_FILES_DIR="$HOME/.config/rclone/filters/"
	cd ~

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

function sync-backups {
	cd ~
	rclone sync --interactive "backups" "gdrive-archivos:Backups"
}
