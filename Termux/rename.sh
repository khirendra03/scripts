#!/bin/bash

# Change to the directory containing the files
cd /path/to/files

# Specify the pattern to match
pattern="oldfile_*.txt"

# Loop through each file matching the pattern
for file in $pattern; do
  # Extract the filename without the prefix
  new_name="${file#oldfile_}"
  
  # Rename the file
  mv "$file" "newfile_$new_name"
done

echo "Files renamed successfully."
