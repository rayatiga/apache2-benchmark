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

# clear the screen
printf "Clearing the terminal screen..."
sleep 1
clear

# checking apache2-utils packages
printf "\nChecking prerequisites first. Please wait...\n"
sleep 0.7
REQUIRED_PKG="apache2-utils"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
printf "Checking for $REQUIRED_PKG: ${GREEN}$PKG_OK${NC}\n"
if [ "" = "$PKG_OK" ]; then
    printf "No $REQUIRED_PKG. Setting up $REQUIRED_PKG. This sometime required a password.\n"
    sleep 1
    sudo apt-get --yes install $REQUIRED_PKG 
    # clear the screen
    printf "\nClearing the terminal screen..."
    sleep 1
    clear
fi

# double check the packages
REQUIRED_PKG="apache2-utils"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
if [ "" = "$PKG_OK" ]; then
    printf "${REDBOLD}Can't find/install $REQUIRED_PKG package(s). Please install manually.${NC}"
    exit 1;
fi

# delay 1 second
sleep 1

# ok if apache2-utils already installed
printf "\nOK, $REQUIRED_PKG already installed in your system, now running the tools.\n"

# cancelling
printf "NOTE: press ${REDBOLD}CTRL + C${NC} at anytime to exit this tool.\n"
sleep 1

# loading the tools
printf "\nLoading tools...\n"
echo -ne '=>                      (4%)\r'
sleep 0.1
echo -ne '==>                     (11%)\r'
sleep 0.1
echo -ne '===>                    (17%)\r'
sleep 0.1
echo -ne '====>                   (28%)\r'
sleep 0.1
echo -ne '=====>                  (33%)\r'
sleep 0.1
echo -ne '=======>                (49%)\r'
sleep 0.1
echo -ne '=============>          (68%)\r'
sleep 0.1
echo -ne '===================>    (84%)\r'
sleep 0.2
echo -ne '=====================>  (96%)\r'
sleep 0.2
echo -ne '=======================>(100%)\r'
sleep 0.2
echo -ne 'completed.                    \r'
sleep 0.5
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
    * ) printf "${RED}Invalid input, abort.\n${NC}"; exit 1;;
esac
sleep 0.5

# ready to use
printf "\n\nOK. Enough intro, let's input your request for bechmarking your site now."
printf "\nThis program is build by ${RED}@bydzen @ (https://github.com/bydzen)\n\n${NC}"
sleep 0.5

# number request
read -p "Please input your request number: " reqval
if ! [[ "$reqval" =~ ^[0-9]+$ ]] ; 
    then exec >&2; printf "${RED}error: Not a number!\n${NC}"; exit 1
fi
if [ $reqval -gt 9999999 ]
    then exec >&2; printf "${RED}error: Too much requests!\n${NC}"; exit 1
fi
sleep 0.5
printf "Input: ${GREEN}$reqval request(s)${NC} saved.\n"
sleep 0.5

# numnber of concurrent
read -p "Please input your concurrent number: " conval
if ! [[ "$conval" =~ ^[0-9]+$ ]] ; 
    then exec >&2; printf "${RED}error: Not a number!\n${NC}"; exit 1
fi
if [ $conval -gt 9999999 ]
    then exec >&2; printf "${RED}error: Too much concurrents!\n${NC}"; exit 1
fi
sleep 0.5
printf "Input: ${GREEN}$conval concurrent(s)${NC} saved.\n"
sleep 0.5

# is use http or https?
read -p "Is your website using https/ssl enabled? (y/n): " yn
case $yn in 
    y|Y|yes|Yes|YEs|yEs|yES|YeS|YES ) procval="https://";;
    n|N|no|No|nO|NO ) procval="http://";;
    * ) printf "${RED}Invalid input, abort.\n${NC}"; exit 1;;
esac
sleep 0.5
printf "Protocol: ${GREEN}$procval${NC} saved.\n"
sleep 0.5

# domain or ip address destination
read -p "Please input your ip/domain destination (e.g. yoursite.com): " siteval
sleep 0.5
printf "Destination: ${GREEN}$procval$siteval/${NC} saved.\n"
sleep 0.5

# use log file (log-benchmark.txt)?
read -p "Output log file? (y/n): " yn
case $yn in 
    y|Y|yes|Yes|YEs|yEs|yES|YeS|YES) sleep 0.5; logval="Yes"; printf "Using log: ${GREEN}Yes.${NC}\n"; logfile=" -e log-benchmark.txt ";;
    n|N|no|No|nO|NO ) sleep 0.5; logval="No"; printf "Using log: ${RED}No.${NC}\n"; logfile=" ";;
    * ) printf "${RED}Invalid input, abort\n${NC}"; exit 1;;
esac
sleep 0.5

# information
printf "\nExecuting apache benchmark as shown:\n"
sleep 0.1
printf "Number of request(s)    : $reqval\n"
sleep 0.1
printf "Number of concurrent(s) : $conval\n"
sleep 0.1
printf "Protocol                : $procval\n"
sleep 0.1
printf "Destination             : $siteval\n"
sleep 0.1
printf "Save log                : $logval\n"
sleep 0.1
printf "Result CLI              : ab -n $reqval -c $conval$logfile$procval$siteval/\n\n"
sleep 0.1
read -p "If the information is correct, confirm to perform benchmank execution. (y/n): " yn
case $yn in 
    y|Y|yes|Yes|YEs|yEs|yES|YeS|YES) ;;
    n|N|no|No|nO|NO ) printf "Abort."; exit 1;;
    * ) printf "${RED}Invalid input, abort.\n${NC}"; exit 1;;
esac

# delay 1 second
sleep 1

# cancelling
printf "NOTE: press ${REDBOLD}CTRL + C${NC} for abort or cancel this request.\n\n"
sleep 2

# loading to execute
printf "Executing...\n"
echo -ne '=>                      (4%)\r'
sleep 0.1
echo -ne '==>                     (11%)\r'
sleep 0.1
echo -ne '===>                    (17%)\r'
sleep 0.1
echo -ne '====>                   (28%)\r'
sleep 0.1
echo -ne '=====>                  (33%)\r'
sleep 0.1
echo -ne '=======>                (49%)\r'
sleep 0.1
echo -ne '=============>          (68%)\r'
sleep 0.1
echo -ne '===================>    (84%)\r'
sleep 0.2
echo -ne '=====================>  (96%)\r'
sleep 0.2
echo -ne '=======================>(100%)\r'
sleep 0.5
echo -ne '                              \r'
echo -ne '\n'

# execute command ab for apache2 benchmark 
sleep 1
ab -n $reqval -c $conval$logfile$procval$siteval/
