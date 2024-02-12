#!/usr/bin/bash

spatne="!  Neco je spatne"

PORT=22
ssh 10.0.11.12 -o PasswordAuthentication=no -p 2222 "hostname" &> /dev/null
if [ $? -eq 0 ]; then PORT=2222; fi

echo "Kontroluji ssh klic"
if [ $(ssh 10.0.11.12 -o PasswordAuthentication=no -p $PORT "hostname") = "server2" ]; then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji GPG klice"
gpg --list-secret-keys | grep tomas.marny@example.org &> /dev/null && SECRETKEY=0
ssh 10.0.11.12 -o PasswordAuthentication=no -p $PORT "gpg --list-public-keys | grep tomas.marny@example.org &> /dev/null" &> /dev/null && PUBLICKEY=0
if [ $SECRETKEY -eq 0 ] && [ $PUBLICKEY -eq 0 ]; then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji zasifrovany soubor"
scp -o PasswordAuthentication=no -p $PORT 10.0.11.12:/home/vagrant/tajny_dokument.txt.gpg . &> /dev/null
if [[ $(gpg -d tajny_dokument.txt.gpg 2> /dev/null) = "Toto je tajna zprava" ]]; then
        echo "  Spravne +20"
        let score=$score+20
else
        echo $spatne
fi

echo "Kontroluji sshd na 2222 a root login"
ssh 10.0.11.12 -o PasswordAuthentication=no -p 2222 "sudo mkdir /root/.ssh; sudo cp .ssh/authorized_keys /root/.ssh/; sudo chmod -R 600 /root/.ssh/" &> /dev/null
if [ $? -eq 0 ] && [ ! $(ssh -o PasswordAuthentication=no -p 2222 root@10.0.11.12 "hostname" &> /dev/null) ]; then
        echo "  Spravne +40"
        let score=$score+40
else
        echo $spatne
fi

echo "--- Bonusova cast ---"
if [ $(grep Skoromensa tomas-marny-vysledky-iq.txt) = "Skoromensa" ]; then
        echo "  Spravne +10"
        let score=$score+10
else
        echo $spatne
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"