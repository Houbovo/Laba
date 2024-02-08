#!/usr/bin/bash

sudo dnf install httpd -y &> /dev/null

mkdir moje_data &> /dev/null
for i in {1..3}; do touch moje_data/file$i.txt; done &> /dev/null
chcon -Rt tmp_t moje_data &> /dev/null
