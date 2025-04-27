#!/usr/bin/bash

# Function to display menu and get user choice (for interactive mode)
get_user_choice_interactive() {
    echo "Select QGIS version to install:"
    echo "1) Latest Release (https://qgis.org/debian)"
    echo "2) Upcoming Release (https://qgis.org/debian-nightly-release)"
    echo "3) Long Term Release (https://qgis.org/debian-ltr)"
    echo "4) Upcoming Long Term Release (https://qgis.org/debian-nightly-ltr)"
    echo "5) Development Version (https://qgis.org/debian-nightly)"
    read -p "Enter your choice (1-5): " choice
    
    case $choice in
        1) repo_url="https://qgis.org/debian";;
        2) repo_url="https://qgis.org/debian-nightly-release";;
        3) repo_url="https://qgis.org/debian-ltr";;
        4) repo_url="https://qgis.org/debian-nightly-ltr";;
        5) repo_url="https://qgis.org/debian-nightly";;
        *) echo "Invalid choice. Exiting."; exit 1;;
    esac
}

# Function to set repo_url based on command-line argument
get_user_choice_non_interactive() {
    choice=$1
    case $choice in
        1) repo_url="https://qgis.org/debian";;
        2) repo_url="https://qgis.org/debian-nightly-release";;
        3) repo_url="https://qgis.org/debian-ltr";;
        4) repo_url="https://qgis.org/debian-nightly-ltr";;
        5) repo_url="https://qgis.org/debian-nightly";;
        *) echo "Invalid choice '$choice'. Use 1-5. Exiting."; exit 1;;
    esac
}

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root (use sudo)"
    exit 1
fi

# Determine if running interactively or with argument
if [ -t 0 ] && [ -z "$1" ]; then
    # Interactive mode (terminal is available, no arguments provided)
    get_user_choice_interactive
else
    # Non-interactive mode (piped or argument provided)
    if [ -z "$1" ]; then
        echo "No version choice provided. Please specify a version (1-5) as an argument."
        echo "Example: curl -sSL <URL> | sudo bash -s 1"
        exit 1
    fi
    get_user_choice_non_interactive "$1"
fi

# Update package lists
apt update

# Install prerequisites
apt install -y gnupg software-properties-common

# Download and install QGIS archive keyring
wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg

# Get the codename of the current distribution
codename=$(lsb_release -cs)

# Create the source list content
source_list="
Types: deb deb-src
URIs: ${repo_url}
Suites: ${codename}
Architectures: amd64
Components: main
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg
"

# Save the source list to the file
echo "${source_list}" > /etc/apt/sources.list.d/qgis.sources

# Update package lists again
apt update

# Install QGIS and related packages
apt install -y qgis qgis-plugin-grass python3-pip

echo "QGIS installation completed successfully!"
