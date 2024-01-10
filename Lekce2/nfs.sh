#!/bin/bash

dnf install -y nfs-utils

mkdir /mnt/myshareddir
chown nobody:nobody /mnt/myshareddir
chmod 777 /mnt/myshareddir

echo "/mnt/myshareddir *(rw,sync,no_subtree_check)" > /etc/exports
exportfs -a
systemctl restart nfs-server