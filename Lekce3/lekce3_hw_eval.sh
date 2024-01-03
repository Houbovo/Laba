#!/bin/bash

slovo=$1
pocet=$2

spatne="!  Neco je spatne"

echo "- Kontroluji Big"
big=`cat soubor1.txt | grep Big | wc -l`
if [ $big -eq 8 ]
then
  echo "  Spravne +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji tecky"
tecky=`cat soubor1.txt | tail -n 1 | grep "....." | wc -l`
if [ $tecky -eq 1 ]
then
  echo "  Spravne +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji Big/big"
Big=`cat soubor2.txt | grep ^Big | wc -l`
bigBig=`cat soubor2.txt | grep -i big | wc -l`
if [ $Big -eq 0 ] && [ $bigBig -eq 7 ]
then
  echo "  Spravne +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji posledni slova"
posledni=`cat soubor3.txt | tr -d '\n'`
if [ "${posledni}" = "WanderlustWhisperWhisperZephyrZephyr" ]
then
  echo "  Spravne +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji unikatni slovo"
if [ "${slovo}" = "Resilience" ]
then
  echo "  Spravne +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji pocet slov"
if [ $pocet -eq 1185 ]
then
  echo "  Spravne +100"
  let score=$score+100
else
  echo $spatne
fi

echo "- Kontroluji /bin/bash"
binbash=`grep bash passwd.new | wc -l`
binksh=`grep ksh passwd.new | wc -l`
oldbinksh=`grep ksh passwd.txt | wc -l`
if [ $binbash -eq 30 ] && [ $binksh -eq 1 ] && [ $oldbinksh -eq 4 ]
then
  echo "  Spravne +200"
  let score=$score+200
else
  echo $spatne
fi

echo "- Kontroluji pisnicku"
song=`cat soubor4.txt`
if [ "${song}" = "never gonna give you up" ]
then
  echo "  Spravne +200"
  let score=$score+200
else
  echo $spatne
fi

echo "--- Bonusova cast ---"
bonus=`cat bonus.txt 2> /dev/null`
if [ -e bonus.txt ]
then
  if [[ ${bonus} = /moje_ext4,/data* ]]
  then
    echo "  Spravne +1"
    let score=$score+1
  else
    echo $spatne
  fi
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"
