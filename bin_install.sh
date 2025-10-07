#!/usr/bin/bash

install_bin() {
	if [ $1 = "dnf" ]; then
		while read LINE; do
			if ! [[ $(dnf list installed $LINE 2> /dev/null) ]]; then
				dnf install $LINE -y
			else
				echo $LINE installed
			fi
		done < ./programs.txt	
	fi
	
	if [ $1 = "apt" ]; then
		while read LINE; do
			if ! [[ $(apt list --installed $LINE 2> /dev/null) ]]; then
				apt install $LINE -y
			else
				echo $LINE installed
			fi
		done < ./programs.txt	

	fi
}

if [ $(which dnf 2> /dev/null) ]; then
	install_bin "dnf"
fi

if [ $(which apt 2> /dev/null) ]; then
	install_bin "apt"
fi


