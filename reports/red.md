# red

## Lab 00: Lab environment Guidelines

`This vm was only introduced in Lab 00`

## Lab 01: Lecture 1 Exercises

```code
PS C:\data\git\CA\red> cat .\Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "red" do |my_machine|
    config.vm.box = "generic-x64/debian12"
    config.vm.hostname = "red"
    config.vm.network "private_network", virtualbox_intnet: "VirtualBox Host-Only Ethernet Adapter #2", type: "static", ip: "192.168.100.166"
    config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.name = "red_vagrant"
      vb.memory = "1024"
      vb.cpus = "1"
      vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
    end
  end
end
PS C:\data\git\CA\red> vagrant status
Current machine states:

red                       not created (virtualbox)

The environment has not yet been created. Run `vagrant up` to
create the environment. If a machine is not created, only the
default provider will be shown. So if a provider is not listed,
then the machine is not created for that environment.
```
<!-- TODO -->

`Who else is here?`

```code
vagrant@red:~$ grep -vE 'false|nologin|sync|shutdown|halt' /etc/passwd
root:x:0:0:root:/root:/bin/bash
vagrant:x:1000:1000:vagrant,,,:/home/vagrant:/bin/bash
```

```code
┌──(kali㉿kali)-[~]
└─$ grep -vE 'false|nologin|sync|shutdown|halt' /etc/passwd
root:x:0:0:root:/root:/usr/bin/zsh
postgres:x:127:133:PostgreSQL administrator,,,:/var/lib/postgresql:/bin/bash
kali:x:1000:1000:,,,:/home/kali:/usr/bin/zsh
```

`Checking out the neighbourhood`

<!-- TODO -->




<!-- TODO -->




<!-- TODO -->




<!-- TODO -->




<!-- TODO -->





























vagrant@red:~$ cat ~/.bash_history
sudo ls
sudo localectl
sudo localectl set-keymap be
sudo localectl set-keymap be_BE
sudo localectl set-x11-keymap be
sudo localectl
reboot
shutdown -r
sudo reboot
exit
ip -4 a
ping 192.168.100.1
exit
ng
ping 172.30.255.254
ip r
ip -4 a
sudo ip route add 172.30.0.16/16 eth1
ip r
sudo ip route add 172.30.0.16/16 dev eth1
sudo ip route add 172.30.0.0/16 dev eth1
ip r
ping 172.30.255.254
ping www.google.be
ping 172.30.0.10
ping 172.30.10.101
ip r
ping 172.30.0.10
shutdown now
sudo shutdown now
ip r
sudo ip route add 172.30.0.0/16 via 192.168.100.253
ip r
ping 172.30.0.4
nmap
sudo apt install nmap
sudo apt install -y nmap
nmap -sn 172.30.0.0/16
nmap -sn 172.30.0.0/24
sudo nmap -sn 172.30.0.0/24
sudo nmap -sC 172.30.0.4
sudo nmap -A 172.30.0.4
dig
dig @172.30.0.4 dc.insecure.cyb
dig @172.30.0.4 w.insecure.cyb
dig @172.30.0.4 www.insecure.cyb
dig axfr @172.30.0.4 insecure.cyb
dig axfr @172.30.0.4 insecure.cyb > zonetransfer_insecure.cyb
cat zonetransfer_insecure.cyb
ping -c5 172.30.0.4
exit
traceroute
traceroute www.google.be
traceroute www.hln.be
ping www.hln.be
traceroute www.hln.be
traceroute www.google.be
exit
ip -4 a
ip r
cat /etc/resolv.conf
nslookup 4.2.2.1
nslookup 4.2.2.2
nslookup 208.67.220.220
resolvectl status
sudo resolvectl status
cat /etc/host
cat /etc/hosts
ip r
ping 172.30.255.254
sudo ip route add 172.30.0.0/16 dev eth1
cat /etc/passwd | grep -v nologin | grep -v false
cat /etc/passwd | grep -v nologin
cat /etc/passwd
ip r
ping 172.30.0.4
sudo ip route add 172.30.0.0/16 dev eth1
sudo ip route add 172.30.0.0/16 via 192.168.100.254
sudo ip route remove 172.30.0.0/16 via 192.168.100.254
sudo ip route del 172.30.0.0/16 via 192.168.100.254
ip r
sudo ip route del 172.30.0.0/16 dev eth1
sudo ip route add 172.30.0.0/16 via 192.168.100.254
ping 172.30.0.4
nmcli connection show
sudo nmcli connection show
sudo systemctl status NetworkManager
sudo cat /etc/network/interfaces
sudo shutdown now
ip r
grep -vE 'false|nologin|sync|shutdown|halt' /etc/passwd
exit
ip r
cat /etc/resolv
cat /etc/resolv.conf
cat /etc/hosts
sudo ip route add 172.30.0.0/16 via 192.168.100.253
ping 172.30.0.4
ip r
nmtui
sudo cat /etc/network/interfaces
sudo nano /etc/network/interfaces
sudoreboot
sudo reboot
ls
ip r
cat /etc/resolv.conf
sudo nano /etc/network/interfaces
sudo reboot
ip r
cat /etc/resolv.conf
sudo resolvctl status
sudo resolvectl status
resolvectl status
sudo nano /etc/network/interfaces
shutdown now
sudo shutdown now
ip r
cat /etc/resolv
cat /etc/resolv.conf
sudo nano /etc/network/interfaces
exit










during lab 04

vagrant@red:~$ sudo apt install -y default-mysql-client
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libconfig-inifiles-perl libdbd-mariadb-perl libdbi-perl libncurses6 libterm-readkey-perl mariadb-client mariadb-client-core
Suggested packages:
  libclone-perl libmldbm-perl libnet-daemon-perl libsql-statement-perl
The following NEW packages will be installed:
  default-mysql-client libconfig-inifiles-perl libdbd-mariadb-perl libdbi-perl libncurses6 libterm-readkey-perl mariadb-client mariadb-client-core
0 upgraded, 8 newly installed, 0 to remove and 3 not upgraded.
Need to get 4,843 kB of archives.
After this operation, 82.4 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main amd64 libconfig-inifiles-perl all 3.000003-2 [45.9 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 libncurses6 amd64 6.4-4 [103 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 mariadb-client-core amd64 1:10.11.4-1~deb12u1 [870 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 mariadb-client amd64 1:10.11.4-1~deb12u1 [2,931 kB]
Get:5 http://deb.debian.org/debian bookworm/main amd64 default-mysql-client all 1.1.0 [2,852 B]
Get:6 http://deb.debian.org/debian bookworm/main amd64 libdbi-perl amd64 1.643-4 [773 kB]
Get:7 http://deb.debian.org/debian bookworm/main amd64 libdbd-mariadb-perl amd64 1.22-1+b1 [93.8 kB]
Get:8 http://deb.debian.org/debian bookworm/main amd64 libterm-readkey-perl amd64 2.38-2+b1 [24.5 kB]
Fetched 4,843 kB in 0s (13.1 MB/s)
Selecting previously unselected package libconfig-inifiles-perl.
(Reading database ... 57892 files and directories currently installed.)
Preparing to unpack .../0-libconfig-inifiles-perl_3.000003-2_all.deb ...
Unpacking libconfig-inifiles-perl (3.000003-2) ...
Selecting previously unselected package libncurses6:amd64.
Preparing to unpack .../1-libncurses6_6.4-4_amd64.deb ...
Unpacking libncurses6:amd64 (6.4-4) ...
Selecting previously unselected package mariadb-client-core.
Preparing to unpack .../2-mariadb-client-core_1%3a10.11.4-1~deb12u1_amd64.deb ...
Unpacking mariadb-client-core (1:10.11.4-1~deb12u1) ...
Selecting previously unselected package mariadb-client.
Preparing to unpack .../3-mariadb-client_1%3a10.11.4-1~deb12u1_amd64.deb ...
Unpacking mariadb-client (1:10.11.4-1~deb12u1) ...
Selecting previously unselected package default-mysql-client.
Preparing to unpack .../4-default-mysql-client_1.1.0_all.deb ...
Unpacking default-mysql-client (1.1.0) ...
Selecting previously unselected package libdbi-perl:amd64.
Preparing to unpack .../5-libdbi-perl_1.643-4_amd64.deb ...
Unpacking libdbi-perl:amd64 (1.643-4) ...
Selecting previously unselected package libdbd-mariadb-perl.
Preparing to unpack .../6-libdbd-mariadb-perl_1.22-1+b1_amd64.deb ...
Unpacking libdbd-mariadb-perl (1.22-1+b1) ...
Selecting previously unselected package libterm-readkey-perl.
Preparing to unpack .../7-libterm-readkey-perl_2.38-2+b1_amd64.deb ...
Unpacking libterm-readkey-perl (2.38-2+b1) ...
Setting up libconfig-inifiles-perl (3.000003-2) ...
Setting up libncurses6:amd64 (6.4-4) ...
Setting up libterm-readkey-perl (2.38-2+b1) ...
Setting up libdbi-perl:amd64 (1.643-4) ...
Setting up mariadb-client-core (1:10.11.4-1~deb12u1) ...
Setting up libdbd-mariadb-perl (1.22-1+b1) ...
Setting up mariadb-client (1:10.11.4-1~deb12u1) ...
Setting up default-mysql-client (1.1.0) ...
Processing triggers for man-db (2.11.2-2) ...
Processing triggers for libc-bin (2.36-9+deb12u3) ...
vagrant@red:~$


vagrant@red:~$ mysql -utoor -psummer -h 172.30.0.15
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.32 Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> exit
Bye

