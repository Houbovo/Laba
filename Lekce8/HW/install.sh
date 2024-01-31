#!/bin/bash

# Install vsftpd
echo "Installing vsftpd..."
sudo dnf -y install vsftpd

# Copy the configuration file
echo "Copying configuration file..."
sudo cp $CONFIG_FILE /etc/vsftpd.conf

# Copy the dummy file to a location accessible by vsftpd
echo "Copying dummy file..."
sudo mkdir -p /var/ftp/pub
sudo cp dummy.txt /var/ftp/pub/

# Create user list file for vsftpd
echo "Creating userlist file..."
echo "ftpuser" | sudo tee /etc/vsftpd.userlist

# Start and enable the vsftpd service
echo "Starting vsftpd service..."
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

echo "Installation and configuration complete."