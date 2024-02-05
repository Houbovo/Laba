#!/usr/bin/bash
host www.comicsdb.cz | awk -F " " '{print $4}' > .comicsdb

sudo sh -c 'echo "66.64.21.186 comicsdb.cz www.comicsdb.cz" >> /etc/hosts'

sudo sed -i "s/^hosts.*/hosts:      files myhostname/g" /etc/nsswitch.conf