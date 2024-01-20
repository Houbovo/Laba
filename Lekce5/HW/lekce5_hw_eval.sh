#!/bin/bash

spatne="!  Neco je spatne"

echo "Kontroluji repozitar developer"
dnf repolist ol8_developer > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji repo virtualbox"
dnf repolist virtualbox > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji balicky Virtualbox"
pkgs=`egrep "virtualbox|ol8_developer" virtualbox.txt  | tr -s " " | cut -d " " -f 3 | sort -u | tr "\n" " "`
if [[ $pkgs = "ol8_developer virtualbox " ]]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji nainstalovany VirtualBox-7.0"
dnf list VirtualBox-7.0 --installed | grep virtualbox > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji libqrencode"
rpm -qa | grep qrencode-libs > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji pigz"
if [ `sha256sum pigz.txt | cut -d " " -f 1` = `rpm -ql pigz | sha256sum | cut -d " " -f 1` ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji zdrojovy balicek elinks"
if [ -e elinks* ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji vlastni balicek elinks"
if [[ `rpm -qi elinks | grep Host` = "Build Host  : oracle8.localdomain" ]]
then
  echo "  Spravne +30"
  let score=$score+30
else
  echo $spatne
fi

echo "--- Bonusova cast ---"
mplayer=`rpm -qa | egrep "mplayer|libcaca" | wc -l`
if [ $mplayer -eq 3 ]
then
  echo "  Spravne +10"
  let score=$score+10
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"