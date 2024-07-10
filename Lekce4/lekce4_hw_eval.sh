#!/bin/bash

mail=$1

spatne="!  Neco je spatne"

echo "Kontroluji defaultni maximalni trvani hesla"
grep PASS_MAX_DAYS /etc/login.defs | grep "90" > /dev/null
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji read.me"
if [ -e /etc/skel/read.me ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji skupinu kancelar"
grep kancelar:x:1111 /etc/group > /dev/null
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji uzivatele alena"
egrep "alena:x:[0-9]+:[0-9]+:Alena Novakova:/home/alena:/bin/sh" /etc/passwd > /dev/null
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji heslo uzivatele alena"
expect -c '
log_user 0
spawn su - alena
expect "*: "
send "MojeSuperTajneHeslo123!\n"
expect "\$"
send "whoami\r"
expect "\$"
send "exit\r"
interact
' > test.out
if [[ `grep ^alena test.out` ]]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji nastaveni prav /home/vagrant"
perms=`stat -c "%a" /home/vagrant/ | cut -c 2`
if [ $perms -eq 5 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontoluji ACL na /home/vagrant/facl"
getfacl /home/vagrant/facl 2> /dev/null | grep group:kancelar:rwx > /dev/null
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji vlastnika ve /var/tmp/spousta_souboru/"
find /var/tmp/spousta_souboru/ -maxdepth 2 -exec stat -c "%U %G" {} \; | grep -v "alena alena"
if [ $? -eq 1 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji prava na /data"
stat -c "%a" /data | grep 1777 > /dev/null
if [ $? -eq 0 ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "Kontroluji mail z LDAPu"
if [ $mail = "helpdesk@demo1.freeipa.org" ]
then
  echo "  Spravne +10"
  let score=$score+10
else
  echo $spatne
fi

echo "--- Bonusova cast ---"
grep bob /etc/passwd > /dev/null 2>&1
if [ $? -eq 0 ] && [  -e .bonus ]
then
  echo "  Spravne +10"
  let score=$score+10
fi

echo "--------------------------
Celkovy pocet bodu: $score
--------------------------"
