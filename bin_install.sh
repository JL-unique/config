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
		exit 0	
	fi
	
	if [ $1 = "apt" ]; then
		while read LINE; do
			if ! [[ $(apt list --installed $LINE 2> /dev/null) ]]; then
				apt install $LINE -y
			else
				echo $LINE installed
			fi
		done < ./programs.txt	
		exit 0
	fi

	exit 1
}

if [ $(which dnf 2> /dev/null) ]; then
	echo "Using DNF package system"
	install_bin "dnf"
fi

if [ $(which apt 2> /dev/null) ]; then
	echo "Using APT package system"
	install_bin "apt"
fi

#Start TMUX on shell creation
#Move to separate file for bash profiles..
if [[ -z $(grep '[ -z "$TMUX"  ] && { tmux attach || tmux new-session;}' ~/.bashrc) ]]; then
	echo '[ -z "$TMUX"  ] && { tmux attach || tmux new-session;}' >> ~/.bashrc	
fi
