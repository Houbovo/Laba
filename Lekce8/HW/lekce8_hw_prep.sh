#!/usr/bin/bash

sudo systemctl disable chronyd.service --now > /dev/null 2>&1
sudo systemctl disable vboxadd-service.service --now > /dev/null 2>&1
sudo systemctl mask chronyd.service > /dev/null 2>&1

sudo sed -i "s/^pool/gibberish/g" /etc/chrony.conf

sudo timedatectl set-time "2012-10-30 18:17:16" > /dev/null
sleep 5
sudo hwclock -s > /dev/null
