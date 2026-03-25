#!/bin/bash

declare -a ports=( $(seq 1 65535) )

function checkPort(){
  (exec 3<>/dev/tcp/$1/$2) 2>/dev/null

  if [ $? -eq 0 ]; then
    echo -e "[+] El host $1 - Port $2 (OPEN)"
  fi

  exec 3<&-
  exec 3>&-
}

if [ $1 ]; then
  for port in ${ports[@]}; do
    checkPort $1 $port &
  done
else
  echo -e "\n[!] Uso: $0 <ip-address>\n"
fi

wait
