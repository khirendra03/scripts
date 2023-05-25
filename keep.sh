#!/bin/bash

# A shell script to upload and download a file from keep.sh

# Set the bucket name to free
BUCKET=free

# Parse the command line options
while getopts "V" opt; do
  case $opt in
    V) # Enable verbose mode
      VERBOSE="-v"
      ;;
    \?) # Invalid option
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Shift the positional parameters
shift $((OPTIND-1))

# Ask the user to choose between upload and download
read -p "Do you want to upload or download a file? (u/d): " CHOICE

# Check if the choice is valid
if [ "$CHOICE" != "u" ] && [ "$CHOICE" != "d" ]; then
  echo "Invalid choice"
  exit 1
fi

# If the choice is upload
if [ "$CHOICE" == "u" ]; then
  # Ask the user to enter the file name
  read -p "Enter the file name: " FILE

  # Check if the file exists
  if [ ! -f "$FILE" ]; then
    echo "File $FILE does not exist"
    exit 2
  fi

  # Upload the file to keep.sh and get the link
  LINK=$(curl --upload-file "$FILE" "https://$BUCKET.keep.sh")

  # Check if the upload was successful
  if [ $? -eq 0 ]; then
    echo "File uploaded successfully"
    echo "Link: $LINK"
  else
    echo "File upload failed"
    exit 3
  fi

# If the choice is download
else
  # Ask the user to enter the link
  read -p "Enter the link: " LINK

  # Extract the file name from the link
  FILE=${LINK##*/}

  # Download the file from keep.sh and save it as new-$FILE
  curl -L "$LINK" > "new-$FILE"

  # Check if the download was successful
  if [ $? -eq 0 ]; then
    echo "File downloaded successfully"
    echo "Saved as new-$FILE"
  else
    echo "File download failed"
    exit 4
  fi
fi
