#!/bin/bash

# Prompt user for font or emoji name
read -p "Enter the font or emoji name: " search_query

# Function to search for files within a website
search_website() {
  local website=$1
  local pattern=$2

  # Retrieve the website's HTML content
  html=$(curl -s "$website")

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

# Function to search for repositories on GitHub
search_github() {
  local query=$1

  # Query GitHub API for repositories
  results=$(curl -s "https://api.github.com/search/repositories?q=$query")

  # Extract repository URLs
  repo_urls=$(echo "$results" | grep -E -o "https://github.com/[^\"]+")

  # Output repository URLs
  if [[ -n $repo_urls ]]; then
    echo "Repositories found on GitHub:"
    echo "$repo_urls"
  else
    echo "No repositories found on GitHub."
  fi
}

# Function to search for repositories on GitLab
search_gitlab() {
  local query=$1

  # Query GitLab API for repositories
  results=$(curl -s "https://gitlab.com/api/v4/projects?search=$query")

  # Extract repository URLs
  repo_urls=$(echo "$results" | grep -E -o "https://gitlab.com/[^\"]+")

  # Output repository URLs
  if [[ -n $repo_urls ]]; then
    echo "Repositories found on GitLab:"
    echo "$repo_urls"
  else
    echo "No repositories found on GitLab."
  fi
}

# List of websites to search from
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

# Search font files on websites
for site in "${websites[@]}"; do
  echo "Searching files from: $site"
  search_website "$site" "$search_query"
  echo
done

# Search GitHub for font repositories
echo "Searching GitHub for font repositories..."
search_github "$search_query"
echo

# Search GitLab for font repositories
echo "Searching GitLab for font repositories..."
search_gitlab "$search_query"
