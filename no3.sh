#! /bin/bash

getpass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

pass="password"
no=1
while test -e "$pass$no.txt"; 
  do  
    no=$((no+1))
 done
fname="$pass$no.txt"
echo "$getpass" > $fname
