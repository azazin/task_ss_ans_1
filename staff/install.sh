#!/bin/bash
USER="ansible"
rm /etc/hosts
cp /vagrant/hosts /etc/hosts
tar -xzvf /vagrant/yum.repos.d.tar.gz -C /etc/
yum install epel-release -y
yum update -y
yum install -y mc htop iftop iotop elinks wget vim mlocate  lsof git #python-setuptools
#easy_install pip
#pip install --upgrade pip
#pip install ansible
#mv /etc/localtime /etc/localtime_old
#ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
timedatectl set-timezone Europe/Kiev

    useradd -m -p $(openssl passwd $USER) $USER
    usermod -aG wheel $USER
    echo "$USER         ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
	
	install -d /home/$USER/.ssh -g $USER -o $USER -m 700 
	ssh-keygen  -f /home/$USER/.ssh/id_rsa -C $USER"@"$HOSTNAME
	chown -R $USER:  /home/$USER/.ssh/*
	
sed /etc/ssh/sshd_config -e 's/PasswordAuthentication no/PasswordAuthentication yes/' -i
systemctl  restart sshd
