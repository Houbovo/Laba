#!/usr/bin/bash

spatne="!  Neco je spatne"

echo "Kontroluji povolenou sluzbu"
if $(sudo firewall-cmd --list-services | grep http &> /dev/null ) || $(sudo firewall-cmd --list-ports | grep 80/tcp &> /dev/null); then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji nastaveni contextu"
if ! $(ls -lZa moje_data/ | grep tmp_t &> /dev/null); then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji selinux mod"
if [ $(getenforce) = "Permissive" ] && [ $(cat /etc/selinux/config | grep "^SELINUX=") = "SELINUX=enforcing" ]; then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji sudoers"
sudo cat /etc/sudoers.d/10-webserver | tr -d ' ' | grep "User_AliasADMINS=alice,bob" &> /dev/null
USERS=$?
sudo cat /etc/sudoers.d/10-webserver | tr -d ' ' | grep "Cmnd_AliasCOMMANDS=/usr/bin/cat,/usr/bin/systemctl" &> /dev/null
COMMANDS=$?
sudo cat /etc/sudoers.d/10-webserver | tr -d ' ' | grep ADMINSALL | grep COMMAND &> /dev/null
RULE=$?
if [ $USERS -eq 0 ] && [ $COMMANDS -eq 0 ] && [ $RULE -eq 0 ]; then
        echo "  Spravne +40"
        let score=$score+40
else
        echo $spatne
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"