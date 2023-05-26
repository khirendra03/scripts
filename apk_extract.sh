#!/bin/sh

# Check if Termux:API is installed
command -v termux-clipboard-get >/dev/null 2>&1 || { echo >&2 "Termux:API is required but not installed. Installing..."; pkg install -y termux-api; }

# Check if Termux:API package installation was successful
command -v termux-clipboard-get >/dev/null 2>&1 || { echo >&2 "Failed to install Termux:API. Aborting."; exit 1; }

# Check if Termux:API is authorized
termux-wake-lock >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo >&2 "Termux:API authorization required. Grant Termux:API the necessary permissions and run the script again."
  exit 1
fi

# Check if Termux:API is authorized for pkg command
if ! termux-vibrate -l 1 >/dev/null 2>&1; then
  echo >&2 "Termux:API permission denied for 'pkg' command. Grant the permission and run the script again."
  exit 1
fi

# Check if termux-tools package is installed
PKG_NAME="termux-tools"
if ! pkg show -s "$PKG_NAME" >/dev/null 2>&1; then
  echo "$PKG_NAME is not installed. Installing..."
  pkg install -y "$PKG_NAME"
fi

# Check if termux-tools package installation was successful
if ! pkg show -s "$PKG_NAME" >/dev/null 2>&1; then
  echo >&2 "Failed to install $PKG_NAME. Aborting."
  exit 1;
fi

# Check if the device is connected
termux-wifi-connectioninfo >/dev/null 2>&1 || { echo >&2 "No device found. Make sure your Android device is connected."; exit 1; }

# Prompt the user to enter the package name (APK name) of the app
PACKAGE_NAME=$(termux-dialog -t "Enter the package name of the app" -i)

# Check if the device is rooted
if [ "$(pm path "$PACKAGE_NAME" | cut -d: -f2 | head -1)" = "/system/app" ]; then
  echo >&2 "The app is rooted. You cannot extract the APK file."
  exit 1;
fi

# Check if the user has permission to extract the APK file
if [ ! -d /data/local/tmp ]; then
  mkdir -p /data/local/tmp
fi
if [ ! -w /data/local/tmp ]; then
  echo >&2 "You do not have permission to extract the APK file."
  exit 1;
fi

# Get the path of the APK file
APK_PATH=$(pm path "$PACKAGE_NAME" | cut -d: -f2)

# Remove the "file:" prefix from the path
APK_PATH=$(echo "$APK_PATH" | sed 's/^file://')

# Extract the APK file to the current directory
termux-clipboard-set "$APK_PATH"  # Save APK path to clipboard
termux-toast "Extracting APK file, please wait..."
termux-download "$APK_PATH"

if [ $? -eq 0 ]; then
  echo "APK file extracted successfully!"
else
  echo "Failed to extract the APK file."
fi
