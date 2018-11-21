#!/bin/bash
yum update -y
rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/6/x86_64/zabbix-release-3.2-1.el6.noarch.rpm
#yum update -y --enablerepo epel
yum install epel-release -y
yum install -y zabbix-agent
yum update -y
yum install -y mc htop bash-completion mlocate elinks telnet tcpdump jq
service  zabbix-agent start
chkconfig zabbix-agent on
service zabbix-agent restart
mv /etc/localtime /etc/localtime_old && ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
echo "HostMetadata=BpM0H4FpnuTK0SttnJydet5+d+6vXI0PbmQXOJHYoSnNeo+0/c" >> /etc/zabbix/zabbix_agentd.conf
sed -i 's/Hostname=Zabbix server/#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf
#echo Hostname="$HOSTNAME" >> /etc/zabbix/zabbix_agentd.conf
#echo Hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname) >> /etc/zabbix/zabbix_agentd.conf
#echo Hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname) >> /etc/zabbix/zabbix_agentd.conf
sed -i 's/Server=127.0.0.1/Server=46.200.137.179/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive=46.200.137.179/g' /etc/zabbix/zabbix_agentd.conf
#sh -c "openssl rand -hex 32 > /etc/zabbix/AWS_zabbix_agentd.psk"
#echo 'TLSConnect=psk' >> /etc/zabbix/zabbix_agentd.conf
#echo 'TLSAccept=psk' >> /etc/zabbix/zabbix_agentd.conf
#echo 'TLSPSKIdentity=PSKAWS' >> /etc/zabbix/zabbix_agentd.conf
#echo 'TLSPSKFile=/etc/zabbix/AWS_zabbix_agentd.psk' >> /etc/zabbix/zabbix_agentd.conf
mkdir /data
service zabbix-agent restart
updatedb
