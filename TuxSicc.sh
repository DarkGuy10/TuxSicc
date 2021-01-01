#!/bin/bash

# Basic data about script:
version="0.0 [Beta]"
author="DarkGuy10"
github_repo="https://github.com/DarkGuy10/TuxSicc"
req_count=`grep "" -c requirements.txt`
for (( i = 1; i <= req_count; i++ )); do
	requirements[$i-1]=`grep "" -m"$i" requirements.txt | tail -1`
done
cyan="\e[96m"
red="\e[32m"
yellow="\e[33m"
default="\e[0m"
green="\e[92m"
bold="\e[1m"
purple="\e[34m"

# ******************************** Basic ***************************************

success()
{
	box_print "S U C C E S S" "${default}"
}

error()
{
	box_print "E R R O R" "${default}${red}"
	exit 1
}

box_print()
{
	message="$1"
	length=${#message}
	allowance=33
	color="$2"
	left_spaces=$(((allowance - length) / 2))
	right_spaces=$((allowance - length - left_spaces))
	left=""
	right=""
	for (( i = 1; i <= left_spaces; i++ )); do
		left="${left} "
	done
	for (( i = 1; i <= right_spaces; i++ )); do
		right="${right} "
	done
	reprint_intro
	printf "${color}" 
	printf "\n"
	printf "                     ┌─────────────────────────────────┐\n"
    printf "                     │${left}${message}${right}│\n"
    printf "                     └─────────────────────────────────┘\n\n"
	sleep 0.75
}

print_intro_animated()
{
	clear
				  printf "${default}${red}"
				  printf "*********************************** Welcome ************************************\n"
				  printf "${default}${yellow}"
				  printf "\n"
	sleep 0.15 && printf "                    __                       .__            ${version}  	\n"
	sleep 0.15 && printf "                  _/  |_ __ _____  ___  _____|__| ____  ____  	\n"
	sleep 0.15 && printf "                  \   __\  |  \  \/  / /  ___/  |/ ___\/ ___\ 	\n"
	sleep 0.15 && printf "                   |  | |  |  />    <  \___ \|  \  \__\  \___ 	\n"
	sleep 0.15 && printf "                   |__| |____//__/\_ \/____  >__|\___  >___  >	\n"
	sleep 0.15 && printf "                                    \/     \/        \/    \/ 	\n"
				  printf "${default}${purple}\n"
				  printf "                            Developed by ${author}              \n"
	sleep 0.75 

}

reprint_intro()
{
	clear
	printf "${default}${red}"
	printf "*********************************** Welcome ************************************\n"
	printf "${default}${yellow}"
	printf "\n"
	printf "                    __                       .__            ${version}  	\n"
	printf "                  _/  |_ __ _____  ___  _____|__| ____  ____  	\n"
	printf "                  \   __\  |  \  \/  / /  ___/  |/ ___\/ ___\ 	\n"
	printf "                   |  | |  |  />    <  \___ \|  \  \__\  \___ 	\n"
	printf "                   |__| |____//__/\_ \/____  >__|\___  >___  >	\n"
	printf "                                    \/     \/        \/    \/ 	\n"
	printf "${default}${purple}\n"
	printf "                            Developed by ${author}              \n" 
}

# ******************************** Basic ***************************************

ok()
{
	printf "$yellow"
	printf "                               $1"
	printf "$green"
	for (( i = 0; i < 5; i++ )); do
		printf "."
		sleep 0.05
	done
	printf "OK\n"
	printf "$default"
}

not_ok()
{
	printf "$yellow"
	printf "                               $1"
	printf "$green"
	for (( i = 0; i < 5; i++ )); do
		printf "."
		sleep 0.05
	done
	printf "$red"
	printf "ERROR\n"
}

check_requirement()
{
	box_print "CHECKING REQUIREMENTS" "${default}${cyan}"
	for requirement in ${requirements[@]}; do
		dpkg -s "$requirement" >/dev/null 2>&1 && ok $requirement || not_ok $requirement
	done
	sleep 0.75
}

set_basic_themes()
{
	box_print "SETTING UP THEMES" "${cyan}"
	mkdir ~/.themes >/dev/null 2>&1
	mkdir ~/.icons >/dev/null 2>&1
	cp TreasureTrove/Papirus-Dark ~/.icons -r
	cp TreasureTrove/Orchis-dark ~/.themes -r
#	gsettings set org.gnome.shell.extensions.user-theme name "Orchis-Dark"
#	gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Dark"
	gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' && ok "Setting icon theme"
	sleep 0.75
}

configure_bootsplash()
{
	box_print "SETTING UP BOOT SPLASH" "${cyan}"
	sudo mdkir /usr/share/plymouth/theme >/dev/null 2>&1
	sudo cp TreasureTrove/TuxSiccSplash /usr/share/plymouth/themes -r && ok "Copying splash"
	sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/TuxSiccSplash/tuxx-sicc.plymouth 100 >/dev/null 2>&1
	sudo alternatives --set default.plymouth /usr/share/plymouth/themes/TuxSiccSplash/tuxx-sicc.plymouth >/dev/null 2>&1  && ok "Changing splash"
	sudo update-initramfs -u >/dev/null 2>&1 && ok "Updating initramfs"
	sleep 0.75
}


main()
{
	print_intro_animated
	check_requirement
	set_basic_themes || error
	configure_bootsplash || error
#	configure_grub
#	install_extentions
#	configure_extentions
}

main