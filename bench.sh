#!/bin/bash

# static color
RED='\033[0;31m'
REDBOLD='\033[1;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
NC='\033[0m'

# static background color
WHITEONRED='\e[1;41m'
BGNC='\e[0m'

# checking apache2-utils packages
printf "\nChecking prerequisites first. Please wait...\n"
sleep 0.7
REQUIRED_PKG="apache2-utils"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
printf "Checking for $REQUIRED_PKG: ${GREEN}$PKG_OK${NC}\n"
if [ "" = "$PKG_OK" ]; then
  printf "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi

# delay 2 seconds
sleep 2
clear

# ok if apache2-utils already installed
printf "\nOK, $REQUIRED_PKG already installed in your system, now running the tools.\n"

# cancelling
printf "NOTE: press ${REDBOLD}CTRL + C${NC} at anytime to exit this tool.\n"

# loading the tools
printf "\nLoading tools...\n"
echo -ne '=>                      (4%)\r'
sleep 0.2
echo -ne '==>                     (11%)\r'
sleep 0.4
echo -ne '===>                    (17%)\r'
sleep 0.2
echo -ne '====>                   (28%)\r'
sleep 0.3
echo -ne '=====>                  (33%)\r'
sleep 0.2
echo -ne '=======>                (49%)\r'
sleep 0.7
echo -ne '=============>          (68%)\r'
sleep 0.5
echo -ne '===================>    (84%)\r'
sleep 0.7
echo -ne '=====================>  (96%)\r'
sleep 0.4
echo -ne '=======================>(100%)\r'
sleep 1
echo -ne '\n'

# welcome
printf "\nWelcome to Apache Bechmark Website!"

# disclaimer and warning
printf "\n\n${WHITEONRED}!!! PLESE READ CAREFULLY !!!${BGNC}"
printf "\n${RED}Please use this program for testing purposes only!"
printf "\nAny illegal activities (e.g. DDoS) will be processed by law. So, becareful!\n${NC}"

# agreement
read -p "Do you agree? (y/n): " yn
case $yn in 
    y|Y|yes|Yes|YEs|yEs|yES|YeS|YES ) printf "Great, I appreciate that!";;
    n|N|no|No|nO|NO ) printf "OK then don't use this tool please :)\n\n"; exit 1;;
    * ) printf "${RED}Invalid input!\n${NC}"; exit 1;;
esac

# ready to use
printf "\n\nOK. Enough intro, let's input your request for bechmarking your site now."
printf "\nBtw, this program is build by ${RED}@bydzen @ (https://github.com/bydzen)\n\n${NC}"

# number request
read -p "Please input your request number: " reqval
if ! [[ "$reqval" =~ ^[0-9]+$ ]] ; 
    then exec >&2; printf "${RED}error: Not a number!\n${NC}"; exit 1
fi
if [ $reqval -gt 9999999 ]
    then exec >&2; printf "${RED}error: Too much requests!\n${NC}"; exit 1
fi

# numnber of concurrent
read -p "Please input your concurrent number: " conval
if ! [[ "$conval" =~ ^[0-9]+$ ]] ; 
    then exec >&2; printf "${RED}error: Not a number!\n${NC}"; exit 1
fi
if [ $conval -gt 9999999 ]
    then exec >&2; printf "${RED}error: Too much concurrents!\n${NC}"; exit 1
fi

# is use http or https?
read -p "Is your website using https/ssl enabled? (y/n): " yn
case $yn in 
    y|Y|yes|Yes|YEs|yEs|yES|YeS|YES ) procval="https://";;
    n|N|no|No|nO|NO ) procval="http://";;
    * ) printf "${RED}Invalid input!\n${NC}"; exit 1;;
esac

# domain or ip address destination
read -p "Please input your ip/domain destination (e.g. yoursite.com): " siteval

# use log file (log-benchmark.txt)?
read -p "Output log file? (y/n): " yn
case $yn in 
    y|Y|yes|Yes|YEs|yEs|yES|YeS|YES) logfile=" -e log-benchmark.txt ";;
    n|N|no|No|nO|NO ) logfile=" ";;
    * ) printf "${RED}Invalid input!\n${NC}"; exit 1;;
esac

# information
printf "\nExecuting apache benchmark $reqval request(s) with $conval concurrent(s)to $siteval now.\n"
sleep 2

# summary of command to execute
printf "Command to execute: ${YELLOW}ab -n $reqval -c $conval$logfile$procval$siteval/${NC}\n\n"

# cancelling
printf "NOTE: press ${REDBOLD}CTRL + C${NC} for abort or cancel this request.\n\n"

# loading to execute
printf "Executing...\n"
echo -ne '=>                      (4%)\r'
sleep 0.2
echo -ne '==>                     (11%)\r'
sleep 0.4
echo -ne '===>                    (17%)\r'
sleep 0.2
echo -ne '====>                   (28%)\r'
sleep 0.3
echo -ne '=====>                  (33%)\r'
sleep 0.2
echo -ne '=======>                (49%)\r'
sleep 0.7
echo -ne '=============>          (68%)\r'
sleep 0.5
echo -ne '===================>    (84%)\r'
sleep 0.7
echo -ne '=====================>  (96%)\r'
sleep 0.4
echo -ne '=======================>(100%)\r'
echo -ne '\n\n'
sleep 2

# execute command ab for apache2 benchmark 
ab -n $reqval -c $conval$logfile$procval$siteval/
