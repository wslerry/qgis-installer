#!/usr/bin/bash
sudo apt update
sudo apt install -y gnupg software-properties-common
sudo wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
# Get the codename of the current distribution
codename=$(lsb_release -cs)

# Create the source list content
source_list="
Types: deb deb-src
URIs: https://qgis.org/debian
Suites: $codename
Architectures: amd64
Components: main
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg
"

# Save the source list to the file
sudo sh -c "echo '$source_list' > /etc/apt/sources.list.d/qgis.sources"

sudo apt update

sudo apt install -y qgis qgis-plugin-grass
