#!/bin/bash

touch do_not_delete.me
sudo chattr +i do_not_delete.me

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