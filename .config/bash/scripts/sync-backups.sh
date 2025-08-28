#!/usr/bin/env bash

cd ~
rclone sync --interactive "backups" "gdrive-archivos:Backups"
