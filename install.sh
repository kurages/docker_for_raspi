#!/bin/bash

#Update the apt package
apt update -y

#install packages to allow apt to use a repository over HTTPS
apt install -y curl \
	apt-transport-https \
	ca-certificates \
	software-properties-common \
	linux-modules-extra-raspi

#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor \
	-o /usr/share/keyrings/docker-archive-keyring.gpg

#set up the stable repository
add-apt-repository "deb \
	[arch=$(dpkg --print-architecture) \
	signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
	https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"

#docker install
apt install -y docker-ce docker-ce-cli containerd.io

usermod -aG docker ${USER}
chmod 666 /var/run/docker.sock

read -n1 -p "Do you want to reboot now? [Y/n]" yn;
if [[ $yn = [yY] ]]; then
	reboot
else
	echo "Reboot required."
fi
