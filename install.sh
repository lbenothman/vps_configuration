#!/usr/bin/env bash
set -e

printf "\n ===========================================================
            ${magenta}Installing Server Configurations${NC}
 =========================================================== \n"

# Colors and visual Configurations
export magenta='\e[0;35m'
export red='\e[0;31m'
export NC='\e[0m'

# Find the location of the script, this brings out the location of the current directory
export SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories | Contains the files and directories I want to work with.
export SOURCE_LOCATION="$SCRIPT_DIRECTORY"


# Run the SSH configurations
bash "${SOURCE_LOCATION}/configure-ssh.sh"

read -p "Can you confirm that you added the public key to Github? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

	printf "${magenta}Cloning Required repositories...\n${NC}"

	if [[ ! -d ${HOME}/.bash_it ]]; then
		git clone --depth=1 git@github.com:Bash-it/bash-it.git ~/.bash_it

		# run the bash-it install script
		bash "${HOME}/.bash_it/install.sh"
	fi

	# install MiniVim
	mkdir "${SOURCE_LOCATION}/Software-Repositories"
	git clone https://github.com/sd65/MiniVim.git ~/${SOURCE_LOCATION}/MiniVim
	bash "${SOURCE_LOCATION}/Software-Repositories/MiniVim/install.sh"
fi;


read -p "Would you like to install the software packaged? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	bash "${SOURCE_LOCATION}/software-install.sh"
fi;

printf "${red}To configure SSH login without password please do that on your local machine:\ncat ~/.ssh/id_rsa.pub | ssh root@[IP_ADDRESS] \"mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys\"\n\n${NC}"
