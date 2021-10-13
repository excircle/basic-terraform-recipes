#! /bin/bash
sudo yum update -y
#set hostname
sudo hostnamectl set-hostname ${k_hostname}
# install ntpd & wget
echo -e "===Installing NTPD + Aux Packages===\n"
sudo yum -y install ntp ntpdate wget vim
# set ntpd host
echo -e "===Updating ntpd server===\n"
sudo ntpdate 0.centos.pool.ntp.org
#start ntpd and enable
echo -e "===starting ntpd.===\n"
sudo systemctl start ntpd
sudo systemctl enable ntpd
sudo systemctl status ntpd
sleep 3
echo -e "===Managing firewall===\n"
# stop firewalld
sudo systemctl stop firewalld
# disable firewalld
sudo systemctl disable firewalld
sudo systemctl status firewalld
echo -e "===request for firewall shutdown complete===\n"
sleep 3
# provision tables.sh
echo -e "===opening access ports===\n"
sudo rm -f /root/tables.sh
echo -e "==='tables.sh' REMOVED===\n"
sudo wget https://raw.githubusercontent.com/akalaj/bash/master/tables.sh -O /root/tables.sh
# bash tables.sh
echo -e "===Executing 'tables.sh'===\n"
sudo bash /root/tables.sh
#disable SELINUX
echo -e "===Updating SELinux config==="
sudo setenforce 0
sudo sed -i "s|SELINUX=enforcing|SELINUX=disabled|g" /etc/sysconfig/selinux

#install puppet repo
sudo rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
echo -e "===Puppet repo has been added!\nInstalling Puppet.===\n"
# install puppet agent
sudo yum install -y puppet-agent
# update puppet config
# activate agent
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet