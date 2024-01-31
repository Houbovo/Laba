#!/bin/bash

CONFIG_FILE="vsftpd.conf"

# Generate vsftpd configuration
echo "Generating vsftpd configuration..."
cat <<EOF > $CONFIG_FILE 2> /dev/null
# Default Options
# Run vsftpd in the background
background=YES

# Listen for incoming connections
listen=YES

# Allow writing files
write_enable=YES

# File creation mask for local users - not used, but part of the default config, so I've left it in
local_umask=022

# Do not check for a valid user shell
check_shell=NO

# Do not maintain session logins
session_support=NO

# Anonymous FTP server specific stuff
# Enable anonymous logins
anonymous_enable=YES

# Disable local user logins - they won't be used
local_enable=NO

# Set the root path for the FTP server files
# This must NOT be publicly writable - ensure it's set with chmod permissions 775 at least
anon_root=/var/ftp/pub

# Allow anonymous users to create directories
anon_mkdir_write_enable=YES

# Allow anoynmous users to upload files
anon_upload_enable=YES

# Allow anonymous users to rename and delete files
anon_other_write_enable=YES

# Do not ask for password for anonymous user
no_anon_password=YES

# Hide user/group info in directory listings
hide_ids=YES

# The name of the anonymous FTP user - this  fixes the 'cannot change directory' error
ftp_username=nobody

# Make newly uploaded files read/writable
anon_umask=000
EOF

# Create a dummy file
echo "Creating dummy file for vsftpd..."
echo "Hello from vsftpd!" > dummy.txt 2> /dev/null

# Check and enable required repositories (this is a placeholder - adjust as needed)
echo "Checking and enabling required repositories..."
sudo dnf config-manager --set-enabled ol8_appstream > /dev/null 2>&1

# Install FTP client
echo "Installing FTP client lftp"
sudo dnf install lftp -y > /dev/null 2>&1

# Run install.sh
echo "Running install.sh script..."
chmod +x install.sh > /dev/null 2>&1
./install.sh