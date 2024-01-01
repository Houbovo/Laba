#!/bin/bash

spatne="!  Neco je spatne"

echo "- Kontroluji muj_dir"
if [ -d muj_dir ]
then
  echo "  Adresar muj_dir +50"
  let score=$score+50
else
  echo $spatne
fi

echo "- Kontroluji MUJ.file"
if [ -e muj_dir/MUJ.file ]
then
  echo "  Soubor MUJ.file +50"
  let score=$score+50
else
  echo $spatne
fi

nejvetsi=`du -sk /usr/bin/grub2-* | sort -n | tail -n 1 | cut -d "/" -f 4`
usrbin=`ls /usr/bin/grub2-* | cut -d "/" -f 4`
for file in $usrbin
do
  if [ $file != $nejvetsi ]
  then
    usrbin_bez="$usrbin_bez $file"
  fi
done

echo "- Kontroluji zkopirovane soubory"
for file in $usrbin_bez
do
  ls /home/vagrant/muj_dir/$file > /dev/null
done
if [ $? -eq 0 ]
then
  echo "  Soubory zkopirovane +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji muj-mkimage"
if [ -e muj_dir/muj-mkimage ]
then
  echo "  Soubor muj-mkimage +50"
  let score=$score+50
else
  echo $spatne
fi

echo "- Kontroluji symling grub2-mkimage"
if [ -L muj_dir/grub2-mkimage ]
then
  echo "  Link grub2-mkimage +50"
  let score=$score+50
else
  echo $spatne
fi

echo "- Kontroluji nejvetsi soubor"
if [ ! -e muj_dir/$nejvetsi ]
then
  echo "  Nejvetsi neni +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji muj_dir.tar.gz"
if [ -e muj_dir.tar.gz ]
then
  echo "  Balik existuje +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji PV"
sudo pvs | grep sdb > /dev/null
if [ $? -eq 0 ]
then
  echo "  PV vytvoreny +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji VG"
sudo vgs | grep moje_vg > /dev/null
if [ $? -eq 0 ]
then
  echo "  VG vytvorena +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji LV"
sudo lvs | grep moje_lv > /dev/null
if [ $? -eq 0 ]
then
  echo "  LV vytvoreny +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji FS"
sudo blkid | grep moje_lv | grep ext4 > /dev/null
if [ $? -eq 0 ]
then
  echo "  FS vytvoreny +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji mount FS"
mount | grep moje_lv | grep "on /moje" > /dev/null
if [ $? -eq 0 ]
then
  echo "  FS namountovany +100"
  let score=$score+100
else
  echo $spatne
fi

echo "--- Bonusova cast ---"
df -h /moje_xfs | egrep 1[0-9]{2}M > /dev/null
if [ $? -eq 0 ]
then
  touch .bonus
  echo "Bonusovy mezikrok zaznamenan"
fi

df -h /moje_xfs | egrep 3[0-9]{2}M > /dev/null
if [ $? -eq 0 ] && [ -e .bonus ]
then
  echo "  Bonusova cast hotova!"
  let score=$score+1
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"