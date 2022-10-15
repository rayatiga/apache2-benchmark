#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

printf "\nLoading tools...\n"
echo -ne '==>                     (11%)\r'
sleep 1
echo -ne '===>                    (22%)\r'
sleep 1
echo -ne '=====>                  (33%)\r'
sleep 2
echo -ne '=============>          (68%)\r'
sleep 1
echo -ne '===================>    (84%)\r'
sleep 1
echo -ne '=====================>  (96%)\r'
sleep 1
echo -ne '=======================>(100%)\r'
sleep 1
echo -ne '\n'

printf "\nWelcome to Apache Bechmark Website!"
printf "\n\n${RED}!!! PLESE READ CAREFULLY !!!${NC}"
printf "\n${RED}Please use this program for testing purposes only!"
printf "\nAny illegal activities (e.g. DDoS) will be processed by law. So, becareful!\n${NC}"

read -p "Are you agree with that!? (y/n): " yn
case $yn in 
  y|Y ) printf "Great, I appreciate that!";;
  n|N ) printf "OK then don't use this tool please :)\n"; exit 1;;
  * ) printf "${RED}Invalid input!\n${NC}"; exit 1;;
esac

printf "\n\nOK. Enough intro, let's input your request for bechmarking your site now."
printf "\nBtw, this program is build by ${RED}@bydzen @ (https://github.com/bydzen)\n\n${NC}"

read -p "Please input your request number: " reqval
if ! [[ "$reqval" =~ ^[0-9]+$ ]] ; 
 then exec >&2; printf "${RED}error: Not a number!\n${NC}"; exit 1
fi

read -p "Please input your concurrent number: " conval
if ! [[ "$conval" =~ ^[0-9]+$ ]] ; 
 then exec >&2; printf "${RED}error: Not a number!\n${NC}"; exit 1
fi

read -p "Is your website using https/ssl enabled? (y/n): " yn
case $yn in 
  y|Y ) procval="https://";;
  n|N ) procval="http://";;
  * ) printf "${RED}Invalid input!\n${NC}"; exit 1;;
esac

read -p "Please input your ip/domain destination (e.g. yoursite.com): " siteval

read -p "Output log file? (y/n): " yn
case $yn in 
  y|Y ) logfile=" -e log-apache-benchmark.txt ";;
  n|N ) logfile=" ";;
  * ) printf "${RED}Invalid input!\n${NC}"; exit 1;;
esac

printf "\nExecuting apache benchmark $reqval request(s) with $conval concurrent(s)to $siteval now.\n"

sleep 2

printf "Command to execute: ab -n $reqval -c $conval$logfile$procval$siteval/\n\n"

sleep 2

ab -n $reqval -c $conval$logfile$procval$siteval/