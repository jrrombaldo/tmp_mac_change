#!/bin/bash
set +x

color=`tput setaf 2`
h_color=`tput setaf 6`
reset=`tput sgr0`


# functions
function usage() { echo "usage: $0 <NIC>  [<NEW MAC>]"; exit 1; }
function pause(){ read -p "$*"; }
function get_mac(){ echo "$(ifconfig en0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')"; }
function print_mac() { echo -e "\tCurrent MAC: $color$(get_mac)$reset \n"; }
# $0-NIC $1-MAC
function change_mac() { 
	sudo ifconfig $1 ether $2;
	sudo ifconfig $1 down;
	sudo ifconfig $1 up;
	sleep 1;
	print_mac
}


# exit if not root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"; 
   exit 1
fi

# exit if NIC not specified
if ! [ -n "$1" ]; then usage; fi


#checking if specified a mac, otherwise generate a random one
if [ -n "$2" ]; then NEW=$2;
#else NEW=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//');
else NEW=00-60-2f$(hexdump -n3 -e '/1 "-%02X"' /dev/random);
fi


#variables
OLD=$(get_mac)
NIC=en0


# going to work
clear; echo -e "\n $h_color CHANGE MAC ADDRESS FOR A WHILE $reset\n"


# confirming before change
echo -e "\t$color $NIC  $OLD$reset -> $color$NEW$reset \n\n[Enter] to change ..."; pause;
change_mac $NIC $NEW

# reverting the mac
echo -e "[Enter] to revert ..."; pause;
change_mac $NIC $OLD




