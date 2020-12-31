#!/bin/bash

# Basic data about script:
version="0.0 [Beta]"
author="@DarkGuy10"
github_repo="https://github.com/DarkGuy10/TuxSicc"
req_count=`grep "" -c requirements.txt`
for (( i = 1; i <= req_count; i++ )); do
	requirements[$i-1]=`grep "" -m"$i" requirements.txt | tail -1`
done
cyan="\e[96m"
red="\e[32m"
brown="\e[33m"
default="\e[39m"
green="\e[92m"
bold="\e[1m"


exists()
{
	printf "$brown"
	printf "$1"
	printf "$green"
	for (( i = 0; i < 5; i++ )); do
		printf "."
		sleep 0.05
	done
	printf "OK\n"
	printf "$default"
}

not_exists()
{
	printf "$brown"
	printf "$1"
	printf "$green"
	for (( i = 0; i < 5; i++ )); do
		printf "."
		sleep 0.05
	done
	printf "$red"
	printf "ERROR : UNMET DEPENDENCIES\n"
	printf "INSTALL $1 AND RERUN THE SCRIPT" 
	printf "$default"
	exit 1
}

check_requirement()
{
	clear
	printf "$cyan"
	printf "\n\n"
	printf "\t┌─────────────────────────────────┐\n"
    printf "\t│      CHECKING REQUIREMENTS      │\n"
    printf "\t└─────────────────────────────────┘\n\n\n"

	for requirement in ${requirements[@]}; do
		dpkg -s "$requirement" >/dev/null 2>&1 || not_exists $requirement
		exists $requirement
	done
}


main()
{
	check_requirement
	cd
	mkdir ~/.themes
	mkdir ~/.icons
	cp TreasureTrove/Papirus-Dark ~/.icons
	cp TreasureTrove/Orchis-dark ~/.themes
#	gsettings set org.gnome.shell.extensions.user-theme name "Orchis-Dark"
	gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Dark"
	gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
}

main