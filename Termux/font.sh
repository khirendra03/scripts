#!/bin/bash

# Error handling function
handle_error() {
  echo "An error occurred. Exiting."
  exit 1
}

# Prompt user for font or emoji name
read -p "Enter the font or emoji name: " search_query

# Validate input
if [[ -z $search_query ]]; then
  echo "Invalid input. Font or emoji name is required."
  exit 1
fi

# Function to search for files within a website
search_website() {
  local website=$1
  local pattern=$2

  # Retrieve the website's HTML content
  html=$(curl -s "$website") || handle_error

  # Search for files matching the pattern
  files=$(echo "$html" | grep -E -o "$pattern" | awk '{print $0}')

  # Output website and matching files
  if [[ -n $files ]]; then
    echo "Files found on $website:"
    echo "$files"
  else
    echo "No files found on $website."
  fi
}

# Function to search for repositories on a platform
search_platform() {
  local platform=$1
  local url=$2
  local query=$3

  # Query platform API for repositories
  results=$(curl -s "$url") || handle_error

  # Extract repository URLs
  repo_urls=$(echo "$results" | grep -E -o "https://$platform.com/[^\"]+")

  # Output repository URLs
  if [[ -n $repo_urls ]]; then
    echo "Repositories found on $platform:"
    echo "$repo_urls"
  else
    echo "No repositories found on $platform."
  fi
}

# Function to search for font files on the internet
search_internet() {
  local query=$1

  # Perform a web search on Google
  search_results=$(curl -s "https://www.google.com/search?q=$query+filetype:ttf") || handle_error

  # Extract URLs from search results
  urls=$(echo "$search_results" | grep -E -o "https?://[^\"]+")

  # Output search results
  if [[ -n $urls ]]; then
    echo "Font files found on the internet:"
    echo "$urls"
  else
    echo "No font files found on the internet."
  fi
}

# List of platforms to search from
platforms=(
  "GitHub,https://api.github.com/search/repositories?q=$search_query"
  "GitLab,https://gitlab.com/api/v4/projects?search=$search_query"
)

# Search font files on websites
websites=(
  "https://fonts.google.com"
  "https://www.dafont.com"
  "https://www.fontsquirrel.com"
  "https://www.1001fonts.com"
  "https://www.fontspace.com"
  "https://www.myfonts.com"
  "https://www.fontfabric.com"
  "https://fonts.adobe.com"
  "https://www.fontspring.com"
  "https://www.urbanfonts.com"
)

for site in "${websites[@]}"; do
  echo "Searching files from: $site"
  search_website "$site" "$search_query"
  echo
done

# Search repositories on platforms
for platform in "${platforms[@]}"; do
  platform_name=$(echo "$platform" | cut -d',' -f1)
  platform_url=$(echo "$platform" | cut -d',' -f2)
  echo "Searching $platform_name for repositories..."
  search_platform "$platform_name" "$platform_url" "$search_query"
  echo
done

# Search font files on the internet
echo "Searching the internet for font files..."
search_internet "$search_query"
echo
