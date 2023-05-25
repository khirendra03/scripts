#!/bin/env bash
## storage info
## some devices might be different, specify on your own

# Internal and external storage paths
internal=/storage/emulated/0/Android/data
external=/storage/D639-79B5 # your external card's name

# Temporary file to store output
ftmp=$HOME/.scripts/util_data/data.tmp

# Gather storage information using 'df -h' command and redirect output to $ftmp file
df -h 2>/dev/null > $ftmp

# Function to extract specific columns from the internal storage information
scrp(){
  grep $internal $ftmp | awk "{print \$$1}"
}

# Function to extract specific columns from the external storage information
scrpX(){
  grep $external $ftmp | awk "{print \$$1}"
}

## internal info
# Obtain internal storage information using the 'scrp' function and assign to variables
Fsys=$(scrp 1)    # Filesystem
Size=$(scrp 2)    # Total size
Used=$(scrp 3)    # Used space
Avai=$(scrp 4)    # Available space
Perc=$(scrp 5)    # Usage percentage
Moun=$(scrp 6)    # Mount point

# external info
# Obtain external storage information using the 'scrpX' function and assign to variables
FsysX=$(scrpX 1)  # Filesystem
SizeX=$(scrpX 2)  # Total size
UsedX=$(scrpX 3)  # Used space
AvaiX=$(scrpX 4)  # Available space
PercX=$(scrpX 5)  # Usage percentage
MounX=$(scrpX 6)  # Mount point

# Formatted string containing internal storage information
InAll="
Internal Storage
================
Device     : $Fsys
Size       : ${Size}B
Used       : ${Used}B ($Perc)
Available  : ${Avai}B
Mounted on : $Moun
"

# Formatted string containing external storage information
ExAll="
External Storage
================
Device     : $FsysX
Size       : ${SizeX}B
Used       : ${UsedX}B ($PercX)
Available  : ${AvaiX}B
Mounted on : $MounX
"

# Function to generate a formatted string for displaying storage usage information
fetch_info(){
  echo -e "${1}B / ${2}B ($3)"
}

# Store the storage usage information for internal and external storage into $ftmp file
data="
inter $(fetch_info $Used $Size $Perc)
exter $(fetch_info $UsedX $SizeX $PercX)
" &> $ftmp

# Check the value of the first command-line argument to determine the desired output
if [[ "$1" == "-a" ]]; then
  echo "$data"   # Print both internal and external storage usage information
elif [[ "$1" == "-i" ]]; then
  fetch_info $Used $Size $Perc    # Print internal storage usage information
elif [[ "$1" == "-e" ]]; then
  fetch_info $UsedX $SizeX $PercX  # Print external storage usage information
elif [[ "$1" == "-I" ]]; then
  echo -e "$InAll"   # Print full internal storage information
elif [[ "$1" == "-E" ]]; then
  echo -e "$ExAll"   # Print full external storage information
else
  {
    echo -e "USAGE: ./storage.sh -[i|e|I|E]";
    echo -e "e.g: ./storage.sh -I";
    exit 1;
  }
fi
