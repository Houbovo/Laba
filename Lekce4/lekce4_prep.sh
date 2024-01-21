#!/bin/bash

sudo dnf install expect

mkdir /var/tmp/spousta_souboru
cd /var/tmp/spousta_souboru
for i in {1..9}
do
  touch file$i
done

mkdir dalsi_adresar
cd dalsi_adresar
for i in {1..9}
do
  touch soubor$i
done
