#!/usr/bin/bash

spatne="!  Neco je spatne"

echo "Kontroluji nastaveni site"
UKOL1=`nmcli connection show id Izolace 2> /dev/null | grep -E "ipv4.method|ipv4.addresses"`
if echo $UKOL1 | grep manual &> /dev/null && echo $UKOL1 | grep 10.0.5.5/25 &> /dev/null; then
        echo "  Spravne +40"
        let score=$score+40
else
        echo $spatne
fi

echo "Kontroluji makovou buchtu"
if grep makova.buchta /etc/hosts 2> /dev/null | grep 10.0.5.66 &> /dev/null; then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji name resolution roumingu"
NSL=$(cat rouming.txt | tr -d '\t' | tr -d ' ' | grep -E "Server:8.8.4.4|Address:77.78.107.185" | wc -l)
if grep "@8.8.4.4 www.rouming.cz" rouming.txt &> /dev/null || [ $NSL -eq 2 ] ; then
        echo "  Spravne +10"
        let score=$score+10
else
        echo $spatne
fi

echo "Kontroluji aktivni spojeni"
WC=0
WC=`cat 22.txt 2> /dev/null 2> /dev/null | wc -l`
if [[ $(grep ":22" 22.txt 2> /dev/null | grep ESTABLISHED | wc -l) -eq $WC ]] && [[ $WC -gt 0 ]]; then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji kontrolu dostupnosti ldap"
if [ $1 = "ano" ] && [ $2 = ne ]; then
        echo "  Spravne +10"
        let score=$score+10
else
        echo $spatne
fi


echo "--- Bonusova cast ---"
if [ -e .comicsdb ] && $(curl comicsdb.cz 2> /dev/null | grep comicsdb &> /dev/null); then
       echo "  Spravne +10"
       let score=$score+10
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"