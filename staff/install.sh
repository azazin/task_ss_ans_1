#!/bin/bash
NEWUSER=ansible
NEWUSERPASS=ansible

rm /etc/hosts
cp /vagrant/hosts /etc/hosts
#tar -xzvf /vagrant/yum.repos.d.tar.gz -C /etc/
yum install epel-release -y
yum update -y
yum install -y mc htop iftop iotop elinks wget vim mlocate   lsof git #python-setuptools
timedatectl set-timezone Europe/Kiev

    useradd -m -p $(openssl passwd  $NEWUSERPASS) $NEWUSER
    usermod -aG wheel $NEWUSER
    echo "$NEWUSER         ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
	install -d /home/$NEWUSER/.ssh -g $NEWUSER -o $NEWUSER -m 700 
	ssh-keygen  -f /home/$NEWUSER/.ssh/id_rsa -C $NEWUSER"@"$HOSTNAME
	chown -R $NEWUSER:  /home/$NEWUSER/.ssh/*
sed /etc/ssh/sshd_config -e 's/PasswordAuthentication no/PasswordAuthentication yes/' -i
systemctl  restart sshd
updatedb
