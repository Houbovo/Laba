#!/bin/bash

sudo dnf install python3-dnf-plugin-versionlock -y > /dev/null 2>&1
sudo sh -c "echo 'libcaca-0:0.09-*' >> /etc/dnf/plugins/versionlock.list"