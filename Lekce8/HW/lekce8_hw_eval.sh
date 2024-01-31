#!/usr/bin/bash

spatne="!  Neco je spatne"

echo "Kontroluji errory"
ERR1=`grep -viE "warn|fail|err" err.txt | wc -l`
ERR2=`cat err.txt | wc -l`
if [ $ERR1 -eq 1 ] && [ $ERR2 -gt 1 ]; then
        echo "  Spravne +10"
        let score=$score+10
else
        echo $spatne
fi

echo "Kontroluji chronyd"
CHRONYD1=`grep -vi chrony chronyd.txt | wc -l`
CHRONYD2=`cat chronyd.txt | wc -l`
if [ $CHRONYD1 -eq 0 ] && [ $CHRONYD2 -gt 0 ]; then
        echo "  Spravne +10"
        let score=$score+10
else
        echo $spatne
fi

echo "Kontroluji cas"
systemctl status chronyd.service > /dev/null 2>&1
if [ $? -eq 0 ]; then
        echo "  Spravne +40"
        let score=$score+40
else
        echo $spatne
fi

echo "Kontroluji FTP"
if [ -s dummyfile.txt ]; then
        echo "  Spravne +40"
        let score=$score+40
else
        echo $spatne
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"