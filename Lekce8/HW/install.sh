#!/bin/bash

# Install vsftpd
echo "Installing vsftpd..."
sudo dnf -y install vsftpd > /dev/null 2>&1

# Copy the configuration file
echo "Copying configuration file..."
sudo cp $CONFIG_FILE /etc/vsftpd/vsftpd.conf > /dev/null 2>&1

# Copy the dummy file to a location accessible by vsftpd
echo "Copying dummy file..."
sudo mkdir -p /var/ftp/pub > /dev/null 2>&1
sudo cp dummy.txt /var/ftp/pub/dummyfile.txt > /dev/null 2>&1

# Create user list file for vsftpd
echo "Creating userlist file..."
echo "ftpuser" | sudo tee /etc/vsftpd.userlist > /dev/null 2>&1

# Start and enable the vsftpd service
echo "Starting vsftpd service..."
sudo systemctl start vsftpd > /dev/null 2>&1
sudo systemctl enable vsftpd > /dev/null 2>&1

echo "Installation and configuration complete."