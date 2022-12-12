#!/bin/bash

# granting storege permission 
termux-setup-storage

# restoring backup file
tar -zxf /sdcard/termux-backup.tar.gz -C /data/data/com.termux/files --recursive-unlink --preserve-permissions

# exit
exit