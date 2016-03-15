#!/usr/bin/env bash
set -e

printf "${magenta}Installing recommended softwares...\n${NC}"

# Adding MongoDB keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Adding Jenkins keys
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

# Updating apt to refresh repos
sudo apt-get update

globals=(
	build-essential
  libssl-dev
  pkg-config
  lamp-server^
  default-jre
  default-jdk
  jenkins
  mongodb-org
  phpmyadmin
  npm
  php5-curl
  screen
)

# Install apt modules
function apt-install() {
  for global in "${globals[@]}"; do
		read -p "Would you like to install $global? [Y/N] " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sudo apt-get -y install $global
		fi;
  done
}

# Call the apt-install functions on the softwares list
apt-install



read -p "Would you like to install Node.js? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Instal NVM to install Node.js
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.27.1/install.sh | bash
	echo "source ~/.nvm/nvm.sh" >> "${HOME}/.bashrc"
	source ~/.profile
	nvm install stable
	source ~/.profile
	# Fix the node.js and node issue in Ubuntu
	ln -s /usr/bin/nodejs /bin/node
fi;
