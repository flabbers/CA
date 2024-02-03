PS C:\data\git\ca\wazzuh> cat .\Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "wazzuh" do |my_machine|
    config.vm.box = "ubuntu/focal64"
    #config.vm.box = "bento/ubuntu-20.04"
    config.vm.hostname = "wazzuh"
    config.vm.network "private_network", virtualbox__intnet: "servers", type: "static", ip: "172.30.0.66"
    config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.name = "ca_d_wazzuh"
      vb.memory = "2048"
      vb.cpus = "1"
      vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
    end
  end
end
PS C:\data\git\ca\wazzuh> vagrant status
Current machine states:

wazzuh                    not created (virtualbox)

The environment has not yet been created. Run `vagrant up` to
create the environment. If a machine is not created, only the
default provider will be shown. So if a provider is not listed,
then the machine is not created for that environment.




PS C:\data\git\ca\wazzuh> vagrant status
Current machine states:

wazzuh                    not created (virtualbox)

The environment has not yet been created. Run `vagrant up` to
create the environment. If a machine is not created, only the
default provider will be shown. So if a provider is not listed,
then the machine is not created for that environment.
PS C:\data\git\CA\wazzuh> vagrant up
Bringing machine 'wazzuh' up with 'virtualbox' provider...
==> wazzuh: Box 'ubuntu/focal64' could not be found. Attempting to find and install...
    wazzuh: Box Provider: virtualbox
    wazzuh: Box Version: >= 0
==> wazzuh: Loading metadata for box 'ubuntu/focal64'
    wazzuh: URL: https://vagrantcloud.com/ubuntu/focal64
==> wazzuh: Adding box 'ubuntu/focal64' (v20231207.0.0) for provider: virtualbox
    wazzuh: Downloading: https://vagrantcloud.com/ubuntu/boxes/focal64/versions/20231207.0.0/providers/virtualbox/unknown/vagrant.box
Download redirected to host: cloud-images.ubuntu.com
    wazzuh:
==> wazzuh: Successfully added box 'ubuntu/focal64' (v20231207.0.0) for 'virtualbox'!
==> wazzuh: Importing base box 'ubuntu/focal64'...
==> wazzuh: Matching MAC address for NAT networking...
==> wazzuh: Checking if box 'ubuntu/focal64' version '20231207.0.0' is up to date...
==> wazzuh: Setting the name of the VM: ca_d_wazzuh
==> wazzuh: Fixed port collision for 22 => 2222. Now on port 2200.
==> wazzuh: Clearing any previously set network interfaces...
==> wazzuh: Preparing network interfaces based on configuration...
    wazzuh: Adapter 1: nat
    wazzuh: Adapter 2: intnet
==> wazzuh: Forwarding ports...
    wazzuh: 22 (guest) => 2200 (host) (adapter 1)
==> wazzuh: Running 'pre-boot' VM customizations...
==> wazzuh: Booting VM...
==> wazzuh: Waiting for machine to boot. This may take a few minutes...
    wazzuh: SSH address: 127.0.0.1:2200
    wazzuh: SSH username: vagrant
    wazzuh: SSH auth method: private key
    wazzuh:
    wazzuh: Vagrant insecure key detected. Vagrant will automatically replace
    wazzuh: this with a newly generated keypair for better security.
    wazzuh:
    wazzuh: Inserting generated public key within guest...
    wazzuh: Removing insecure key from the guest if it's present...
    wazzuh: Key inserted! Disconnecting and reconnecting using new SSH key...
==> wazzuh: Machine booted and ready!
==> wazzuh: Checking for guest additions in VM...
    wazzuh: The guest additions on this VM do not match the installed version of
    wazzuh: VirtualBox! In most cases this is fine, but in rare cases it can
    wazzuh: prevent things such as shared folders from working properly. If you see
    wazzuh: shared folder errors, please make sure the guest additions within the
    wazzuh: virtual machine match the version of VirtualBox you have installed on
    wazzuh: your host and reload your VM.
    wazzuh:
    wazzuh: Guest Additions Version: 6.1.38
    wazzuh: VirtualBox Version: 7.0
==> wazzuh: Setting hostname...
==> wazzuh: Configuring and enabling network interfaces...
==> wazzuh: Mounting shared folders...
    wazzuh: /vagrant => C:/DATA/GIT/CA/wazzuh
PS C:\data\git\ca\wazzuh> vagrant ssh
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Jan  6 22:15:41 UTC 2024

  System load:  0.34              Processes:               115
  Usage of /:   3.7% of 38.70GB   Users logged in:         0
  Memory usage: 10%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 172.30.0.66


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@wazzuh:~$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86376sec preferred_lft 86376sec
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 172.30.0.66/24 brd 172.30.0.255 scope global enp0s8
       valid_lft forever preferred_lft forever
vagrant@wazzuh:~$





vagrant@wazzuh:~$ sudo grep 'PasswordAuthentication ' /etc/ssh/sshd_config
#BENNY PasswordAuthentication no
PasswordAuthentication yes


vagrant@wazzuh:~$ sudo systemctl restart sshd



[walt@companyrouter etc]$ ssh vagrant@172.30.0.66
The authenticity of host '172.30.0.66 (172.30.0.66)' can't be established.
ED25519 key fingerprint is SHA256:XQbgj7BRuqD2pgCSGqz5FpLsmcFRtkERVanLp/YIPJI.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.30.0.66' (ED25519) to the list of known hosts.



vagrant@172.30.0.66's password:
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Jan  6 22:26:23 UTC 2024

  System load:  0.01              Processes:               113
  Usage of /:   3.7% of 38.70GB   Users logged in:         1
  Memory usage: 10%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 172.30.0.66


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Sat Jan  6 22:15:42 2024 from 10.0.2.2
vagrant@wazzuh:~$ sudo poweroff
vagrant@wazzuh:~$ Connection to 172.30.0.66 closed by remote host.
Connection to 172.30.0.66 closed.
[walt@companyrouter etc]$


PS C:\data\git\ca\wazzuh> VBoxManage modifyvm ca_d_wazzuh --cable-connected1=off



PS C:\data\git\ca\wazzuh> VBoxManage startvm ca_d_wazzuh
Waiting for VM "ca_d_wazzuh" to power on...
VM "ca_d_wazzuh" has been successfully started.




vagrant@wazzuh:/etc/netplan$ cat 50-vagrant.yaml
---
network:
  version: 2
#  renderer: networkd
  ethernets:
    enp0s8:
      dhcp4: false
      addresses:
      - 172.30.0.66/24
      gateway4: 172.30.0.254
      nameservers:
        addresses: [172.30.0.4,8.8.8.8]



vagrant@wazzuh:~$ sudo systemctl status systemd-resolved
● systemd-resolved.service - Network Name Resolution
     Loaded: loaded (/lib/systemd/system/systemd-resolved.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: man:systemd-resolved.service(8)
             https://www.freedesktop.org/wiki/Software/systemd/resolved
             https://www.freedesktop.org/wiki/Software/systemd/writing-network-configuration-managers
             https://www.freedesktop.org/wiki/Software/systemd/writing-resolver-clients


vagrant@wazzuh:~$ cat /etc/resolv.conf
nameserver 172.30.0.4
nameserver 8.8.8.8
search insecure.cyb




vagrant@wazzuh:~$ sudo useradd -m -s /bin/bash -p "$(openssl passwd -1 'Friday13th!')" walt
vagrant@wazzuh:~$ sudo cp /etc/sudoers.d/vagrant /etc/sudoers.d/walt
vagrant@wazzuh:~$ sudo sed -i 's/vagrant/walt/g' /etc/sudoers.d/walt
vagrant@wazzuh:~$ sudo cat /etc/sudoers.d/walt
walt ALL=(ALL) NOPASSWD:ALL
vagrant@wazzuh:~$ whoami
vagrant
vagrant@wazzuh:~$ sudo su - walt
walt@wazzuh:~$ whoami
walt
walt@wazzuh:~$ sudo whoami
root


PS C:\data\git\ca\wazzuh> ssh -p22 walt@wazzuh 'mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
The authenticity of host 'wazzuh (172.30.0.66)' can't be established.
ECDSA key fingerprint is SHA256:yBNrDEOPpIVBp1tEjLo1JiJGNJfB+ESKA4TdF8+BFYQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'wazzuh,172.30.0.66' (ECDSA) to the list of known hosts.
walt@wazzuh's password:
PS C:\data\git\ca\wazzuh> ssh -p22 walt@wazzuh 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFI4Qm7YeH2CZQlKcmlpj2U0zpIYT74nRpiVfWnYy9p+vjChA0lF4lZ9XSGevq+ZVHWV3RBzpmcBS5i0XrZSGbEfh6zwsYpAy7K8ErIbSepdNJkBm1jMslGO3E5gabU2tP/+TUpyfrHuuV377IrwQ3XxPOjuCPj0WOwlcFgZovtLc0ZH39ns6O8K3SVYLkho2NdgMXi4gJAlQCOj99kjA+ZT5xhOJ832w2rJn7t8XfS+fgOwoNhErv9Mq6r8c7zyE3eYKkMfk0S24jFyC66fZSu7/LERC/F4ipGGc4MyB9ODu47CAE9knRA358nuB9x4lnklVYP7twPP0iOPrgqLEcYt6fakNaniHCJxmyokINys2NqtjZNDJEBkPBWvOPoRoM555GNIsVpnsJparVmFVoCtMGCUNnvyClRBI90To1t39LMhiN8oTshU0zbuErdkln2iHX4E8czQyfcYkSNtZ0x8FPWBQxzsc/t5UR6NDLHorZTBqbXS0gHH0oxJvVL58= benny.clemmens@student.hogent.be" >> ~/.ssh/authorized_keys'
walt@wazzuh's password:
PS C:\data\git\ca\wazzuh> ssh walt@wazzuh whoami
walt





PS C:\data\git\ca\wazzuh> ssh wazzuhD
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Jan  6 23:16:12 UTC 2024

  System load:  0.37              Processes:               114
  Usage of /:   3.8% of 38.70GB   Users logged in:         0
  Memory usage: 8%                IPv4 address for enp0s8: 172.30.0.66
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


walt@wazzuh:~$





walt@wazzuh:~$ sudo apt update
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease
Get:3 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/universe amd64 Packages [8628 kB]
Get:6 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [2641 kB]
Get:8 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [2451 kB]
Get:9 http://security.ubuntu.com/ubuntu focal-security/restricted Translation-en [342 kB]
Get:10 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [916 kB]
Get:11 http://security.ubuntu.com/ubuntu focal-security/universe Translation-en [192 kB]
Get:12 http://security.ubuntu.com/ubuntu focal-security/universe amd64 c-n-f Metadata [19.2 kB]
Get:13 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [23.6 kB]
Get:14 http://security.ubuntu.com/ubuntu focal-security/multiverse Translation-en [5504 B]
Get:15 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 c-n-f Metadata [548 B]
Get:16 http://archive.ubuntu.com/ubuntu focal/universe Translation-en [5124 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal/universe amd64 c-n-f Metadata [265 kB]
Get:18 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 Packages [144 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal/multiverse Translation-en [104 kB]
Get:20 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 c-n-f Metadata [9136 B]
Get:21 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [3021 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal-updates/main Translation-en [488 kB]
Get:23 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [2569 kB]
Get:24 http://archive.ubuntu.com/ubuntu focal-updates/restricted Translation-en [359 kB]
Get:25 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [1142 kB]
Get:26 http://archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [274 kB]
Get:27 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 c-n-f Metadata [25.7 kB]
Get:28 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [25.8 kB]
Get:29 http://archive.ubuntu.com/ubuntu focal-updates/multiverse Translation-en [7484 B]
Get:30 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 c-n-f Metadata [620 B]
Get:31 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [45.7 kB]
Get:32 http://archive.ubuntu.com/ubuntu focal-backports/main Translation-en [16.3 kB]
Get:33 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 c-n-f Metadata [1420 B]
Get:34 http://archive.ubuntu.com/ubuntu focal-backports/restricted amd64 c-n-f Metadata [116 B]
Get:35 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [25.0 kB]
Get:36 http://archive.ubuntu.com/ubuntu focal-backports/universe Translation-en [16.3 kB]
Get:37 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 c-n-f Metadata [880 B]
Get:38 http://archive.ubuntu.com/ubuntu focal-backports/multiverse amd64 c-n-f Metadata [116 B]
Fetched 29.6 MB in 9s (3290 kB/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
18 packages can be upgraded. Run 'apt list --upgradable' to see them.
walt@wazzuh:~$ sudo apt update
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Get:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Hit:3 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu focal-security InRelease
Get:5 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [1142 kB]
Fetched 1256 kB in 1s (1139 kB/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
3 packages can be upgraded. Run 'apt list --upgradable' to see them.
walt@wazzuh:~$ sudo poweroff





walt@wazzuh:~$ mkdir wazzuh
walt@wazzuh:~$ cd wazzuh/
walt@wazzuh:~/wazzuh$ curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh
walt@wazzuh:~/wazzuh$ curl -sO https://packages.wazuh.com/4.7/config.yml
walt@wazzuh:~/wazzuh$ nano config.yml

walt@wazzuh:~/wazzuh$ grep -v '#' config.yml
nodes:
  indexer:
    - name: wazzuh_i
      ip: "172.30.0.66"

  server:
    - name: wazzuh_s
      ip: "172.30.0.66"

  dashboard:
    - name: wazzuh_d
      ip: "172.30.0.66"


walt@wazzuh:~/wazzuh$ grep -v '#' config.yml
nodes:
  indexer:
    - name: node-1
      ip: "172.30.0.66"

  server:
    - name: wazuh-1
      ip: "172.30.0.66"

  dashboard:
    - name: dashboard
      ip: "172.30.0.66"


walt@wazzuh:~/wazzuh$ sudo bash wazuh-install.sh --generate-config-files
07/01/2024 06:21:52 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 06:21:52 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 06:21:58 INFO: --- Configuration files ---
07/01/2024 06:21:58 INFO: Generating configuration files.
07/01/2024 06:21:58 INFO: Created wazuh-install-files.tar. It contains the Wazuh cluster key, certificates, and passwords necessary for installation.


walt@wazzuh:~/wazzuh$ sudo tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep -P "\'admin\'" -A 1
  indexer_username: 'admin'
  indexer_password: '6*LnR?X8CxtFO0oQ+CFkhO0gJBwtYr7H'

walt@wazzuh:~/wazzuh$ sudo tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep -P "\'admin\'" -A 1
  indexer_username: 'admin'
  indexer_password: '.zMv6oHzfIhZ?irX+I5qjl6yQMYVhRhF'
walt@wazzuh:~/wazzuh



walt@wazzuh:~/wazzuh$ sudo bash ./wazuh-install.sh -a
07/01/2024 06:28:25 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 06:28:25 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 06:28:29 ERROR: Your system does not meet the recommended minimum hardware requirements of 4Gb of RAM and 2 CPU cores. If you want to proceed with the installation use the -i option to ignore these requirements.



walt@wazzuh:~/wazzuh$ sudo bash ./wazuh-install.sh -a -i
07/01/2024 06:32:39 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 06:32:39 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 06:32:44 WARNING: Hardware and system checks ignored.
07/01/2024 06:32:44 INFO: Wazuh web interface port will be 443.
07/01/2024 06:32:46 INFO: --- Dependencies ----
07/01/2024 06:32:46 INFO: Installing apt-transport-https.
07/01/2024 06:32:50 INFO: Wazuh repository added.
07/01/2024 06:32:50 INFO: --- Configuration files ---
07/01/2024 06:32:50 INFO: Generating configuration files.
07/01/2024 06:32:51 INFO: Created wazuh-install-files.tar. It contains the Wazuh cluster key, certificates, and passwords necessary for installation.
07/01/2024 06:32:51 INFO: --- Wazuh indexer ---
07/01/2024 06:32:51 INFO: Starting Wazuh indexer installation.
07/01/2024 06:34:10 INFO: Wazuh indexer installation finished.
07/01/2024 06:34:10 INFO: Wazuh indexer post-install configuration finished.
07/01/2024 06:34:10 INFO: Starting service wazuh-indexer.
07/01/2024 06:34:24 INFO: wazuh-indexer service started.
07/01/2024 06:34:24 INFO: Initializing Wazuh indexer cluster security settings.
07/01/2024 06:34:35 INFO: Wazuh indexer cluster initialized.
07/01/2024 06:34:35 INFO: --- Wazuh server ---
07/01/2024 06:34:35 INFO: Starting the Wazuh manager installation.
07/01/2024 06:35:37 INFO: Wazuh manager installation finished.
07/01/2024 06:35:37 INFO: Starting service wazuh-manager.
07/01/2024 06:35:54 INFO: wazuh-manager service started.
07/01/2024 06:35:54 INFO: Starting Filebeat installation.
07/01/2024 06:36:04 INFO: Filebeat installation finished.
07/01/2024 06:36:04 INFO: Filebeat post-install configuration finished.
07/01/2024 06:36:04 INFO: Starting service filebeat.
07/01/2024 06:36:05 INFO: filebeat service started.
07/01/2024 06:36:05 INFO: --- Wazuh dashboard ---
07/01/2024 06:36:05 INFO: Starting Wazuh dashboard installation.
07/01/2024 06:37:22 INFO: Wazuh dashboard installation finished.
07/01/2024 06:37:22 INFO: Wazuh dashboard post-install configuration finished.
07/01/2024 06:37:22 INFO: Starting service wazuh-dashboard.
07/01/2024 06:37:23 INFO: wazuh-dashboard service started.
07/01/2024 06:41:22 ERROR: The backup could not be created









walt@wazzuh:~/wazzuh$ sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
wazuh-install-files/wazuh-passwords.txt
# Admin user for the web user interface and Wazuh indexer. Use this user to log in to Wazuh dashboard
  indexer_username: 'admin'
  indexer_password: '.zMv6oHzfIhZ?irX+I5qjl6yQMYVhRhF'

# Wazuh dashboard user for establishing the connection with Wazuh indexer
  indexer_username: 'kibanaserver'
  indexer_password: 'JdpyC+so*4L6A42VPgE7iylWC6SFdC2I'

# Regular Dashboard user, only has read permissions to all indices and all permissions on the .kibana index
  indexer_username: 'kibanaro'
  indexer_password: '72gA7D4B8wC+cYNfh2VOIlV+MaciWxjM'

# Filebeat user for CRUD operations on Wazuh indices
  indexer_username: 'logstash'
  indexer_password: 'Y9NTInfPCnWl7?SmQph.daez?XEfChMq'

# User with READ access to all indices
  indexer_username: 'readall'
  indexer_password: 'BfMOJUhL++tyDRLEHg*6X5a2BzpTksfG'

# User with permissions to perform snapshot and restore operations
  indexer_username: 'snapshotrestore'
  indexer_password: 'n4JPp0BqT2g2lXcdU0Sm1EMWhB01k*yC'

# Password for wazuh API user
  api_username: 'wazuh'
  api_password: 'dW*T?30WaI86NvrwM?*IJ6fMM2R?D9QG'

# Password for wazuh-wui API user
  api_username: 'wazuh-wui'
  api_password: 'vtB+26EFZoNzmafk6+JDk0ACK8sCOm8D'









walt@wazzuh:~/wazzuh$ ls -al
total 172
drwxrwxr-x 2 walt walt   4096 Jan  7 07:27 .
drwxr-xr-x 7 walt walt   4096 Jan  7 07:26 ..
-rw-rw-r-- 1 walt walt    616 Jan  7 07:27 config.yml
-rw-rw-r-- 1 walt walt 163475 Jan  7 07:26 wazuh-install.sh
walt@wazzuh:~/wazzuh$ sudo bash wazuh-install.sh --generate-config-files
07/01/2024 07:28:00 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 07:28:00 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 07:28:07 INFO: --- Configuration files ---
07/01/2024 07:28:07 INFO: Generating configuration files.
07/01/2024 07:28:08 INFO: Created wazuh-install-files.tar. It contains the Wazuh cluster key, certificates, and passwords necessary for installation.
walt@wazzuh:~/wazzuh$ ls -al
total 180
drwxrwxr-x 2 walt walt   4096 Jan  7 07:28 .
drwxr-xr-x 7 walt walt   4096 Jan  7 07:26 ..
-rw------- 1 root root  10944 Jan  7 07:28 wazuh-install-files.tar
-rw-rw-r-- 1 walt walt 163475 Jan  7 07:26 wazuh-install.sh
walt@wazzuh:~/wazzuh$ sudo cat /var/log/wazuh-install.log
07/01/2024 07:28:00 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 07:28:00 INFO: Verbose logging redirected to /var/log/wazuh-install.log
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://security.ubuntu.com/ubuntu focal-security InRelease
Get:3 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Hit:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Fetched 114 kB in 1s (131 kB/s)
Reading package lists...
07/01/2024 07:28:07 INFO: --- Configuration files ---
07/01/2024 07:28:07 INFO: Generating configuration files.
Generating a RSA private key
....................................................+++++
.........+++++
writing new private key to '/tmp/wazuh-certificates//root-ca.key'
-----
Generating RSA private key, 2048 bit long modulus (2 primes)
...............................+++++
....................................................+++++
e is 65537 (0x010001)
Signature ok
subject=C = US, L = California, O = Wazuh, OU = Wazuh, CN = admin
Getting CA Private Key
Ignoring -days; not generating a certificate
Generating a RSA private key
....................................+++++
...........................+++++
writing new private key to '/tmp/wazuh-certificates//node-1-key.pem'
-----
Signature ok
subject=C = US, L = California, O = Wazuh, OU = Wazuh, CN = node-1
Getting CA Private Key
Ignoring -days; not generating a certificate
Generating a RSA private key
.............................................................................................................................................+++++
...............................+++++
writing new private key to '/tmp/wazuh-certificates//wazuh-1-key.pem'
-----
Signature ok
subject=C = US, L = California, O = Wazuh, OU = Wazuh, CN = wazuh-1
Getting CA Private Key
Ignoring -days; not generating a certificate
Generating a RSA private key
....................................+++++
.......................+++++
writing new private key to '/tmp/wazuh-certificates//dashboard-key.pem'
-----
Signature ok
subject=C = US, L = California, O = Wazuh, OU = Wazuh, CN = dashboard
Getting CA Private Key
07/01/2024 07:28:08 INFO: Created wazuh-install-files.tar. It contains the Wazuh cluster key, certificates, and passwords necessary for installation.




walt@wazzuh:~/wazzuh$ sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
wazuh-install-files/wazuh-passwords.txt
# Admin user for the web user interface and Wazuh indexer. Use this user to log in to Wazuh dashboard
  indexer_username: 'admin'
  indexer_password: '**Unax25e3F?Ob5TGJZlVKo8m5YrcStV'

# Wazuh dashboard user for establishing the connection with Wazuh indexer
  indexer_username: 'kibanaserver'
  indexer_password: 'f5BIfRueqGAfJQLW7vBBFifNH.gJ?z5S'

# Regular Dashboard user, only has read permissions to all indices and all permissions on the .kibana index
  indexer_username: 'kibanaro'
  indexer_password: 'XXa4abSH8*MJ264n6LySmMqQ0OAoMpZR'

# Filebeat user for CRUD operations on Wazuh indices
  indexer_username: 'logstash'
  indexer_password: 'qbsxG?L.fwHkZtka47PAjkN+7XBseqNb'

# User with READ access to all indices
  indexer_username: 'readall'
  indexer_password: '8he5KUYfns3n.4DjzVa1W0NPTpNP+aqT'

# User with permissions to perform snapshot and restore operations
  indexer_username: 'snapshotrestore'
  indexer_password: 'M.GyoD1fCX.KhS*0SkiG*WLSVdT*nj4g'

# Password for wazuh API user
  api_username: 'wazuh'
  api_password: 'grmxDPUwnB16vo+QN.Y+FQeu?WC0Eg0t'

# Password for wazuh-wui API user
  api_username: 'wazuh-wui'
  api_password: 'FexpeTsFDV0Up86?r*ush6S8OfxjeQn3'


walt@wazzuh:~/wazzuh$ sudo bash wazuh-install.sh --wazuh-indexer node-1
07/01/2024 07:30:52 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 07:30:52 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 07:30:58 INFO: --- Dependencies ----
07/01/2024 07:30:58 INFO: Installing apt-transport-https.
07/01/2024 07:31:01 INFO: Wazuh repository added.
07/01/2024 07:31:02 INFO: --- Wazuh indexer ---
07/01/2024 07:31:02 INFO: Starting Wazuh indexer installation.
07/01/2024 07:32:09 INFO: Wazuh indexer installation finished.
07/01/2024 07:32:09 INFO: Wazuh indexer post-install configuration finished.
07/01/2024 07:32:09 INFO: Starting service wazuh-indexer.
07/01/2024 07:32:27 INFO: wazuh-indexer service started.
07/01/2024 07:32:27 INFO: Initializing Wazuh indexer cluster security settings.
07/01/2024 07:32:28 INFO: Wazuh indexer cluster initialized.
07/01/2024 07:32:28 INFO: Installation finished.
walt@wazzuh:~/wazzuh$ sudo ss -tlnp
State                Recv-Q               Send-Q                                    Local Address:Port                             Peer Address:Port              Process
LISTEN               0                    128                                             0.0.0.0:22                                    0.0.0.0:*                  users:(("sshd",pid=671,fd=3))
LISTEN               0                    4096                               [::ffff:172.30.0.66]:9200                                        *:*                  users:(("java",pid=4200,fd=553))
LISTEN               0                    4096                               [::ffff:172.30.0.66]:9300                                        *:*                  users:(("java",pid=4200,fd=551))
LISTEN               0                    128                                                [::]:22                                       [::]:*                  users:(("sshd",pid=671,fd=4))
walt@wazzuh:~/wazzuh$ sudo bash wazuh-install.sh --start-cluster
07/01/2024 07:33:08 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 07:33:08 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 07:33:31 INFO: Wazuh indexer cluster security configuration initialized.
07/01/2024 07:34:04 INFO: Wazuh indexer cluster started.


walt@wazzuh:~/wazzuh$ curl -k -u admin:'**Unax25e3F?Ob5TGJZlVKo8m5YrcStV' https://172.30.0.66:9200
{
  "name" : "node-1",
  "cluster_name" : "wazuh-indexer-cluster",
  "cluster_uuid" : "jUKnET91TVq2tvdNISQ1-g",
  "version" : {
    "number" : "7.10.2",
    "build_type" : "rpm",
    "build_hash" : "db90a415ff2fd428b4f7b3f800a51dc229287cb4",
    "build_date" : "2023-06-03T06:24:25.112415503Z",
    "build_snapshot" : false,
    "lucene_version" : "9.6.0",
    "minimum_wire_compatibility_version" : "7.10.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "The OpenSearch Project: https://opensearch.org/"
}



walt@wazzuh:~/wazzuh$ curl -k -u admin:'**Unax25e3F?Ob5TGJZlVKo8m5YrcStV' https://172.30.0.66:9200/_cat/nodes?v
ip          heap.percent ram.percent cpu load_1m load_5m load_15m node.role node.roles                               cluster_manager name
172.30.0.66           14          97   7    0.28    0.44     0.25 dimr      data,ingest,master,remote_cluster_client *               node-1



walt@wazzuh:~/wazzuh$ sudo bash wazuh-install.sh --wazuh-server wazuh-1
07/01/2024 07:37:34 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 07:37:34 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 07:37:42 INFO: Wazuh repository added.
07/01/2024 07:37:42 INFO: --- Wazuh server ---
07/01/2024 07:37:42 INFO: Starting the Wazuh manager installation.
07/01/2024 07:38:28 INFO: Wazuh manager installation finished.
07/01/2024 07:38:28 INFO: Starting service wazuh-manager.
07/01/2024 07:38:43 INFO: wazuh-manager service started.
07/01/2024 07:38:43 INFO: Starting Filebeat installation.
07/01/2024 07:38:48 INFO: Filebeat installation finished.
07/01/2024 07:38:49 INFO: Filebeat post-install configuration finished.
07/01/2024 07:38:53 INFO: Starting service filebeat.
07/01/2024 07:38:54 INFO: filebeat service started.
07/01/2024 07:38:54 INFO: Installation finished.


walt@wazzuh:~/wazzuh$ sudo bash wazuh-install.sh --wazuh-dashboard dashboard
07/01/2024 07:39:49 INFO: Starting Wazuh installation assistant. Wazuh version: 4.7.1
07/01/2024 07:39:49 INFO: Verbose logging redirected to /var/log/wazuh-install.log
07/01/2024 07:39:53 INFO: Wazuh web interface port will be 443.
07/01/2024 07:39:55 INFO: Wazuh repository added.
07/01/2024 07:39:56 INFO: --- Wazuh dashboard ----
07/01/2024 07:39:56 INFO: Starting Wazuh dashboard installation.
07/01/2024 07:40:54 INFO: Wazuh dashboard installation finished.
07/01/2024 07:40:59 INFO: Wazuh dashboard post-install configuration finished.
07/01/2024 07:40:59 INFO: Starting service wazuh-dashboard.
07/01/2024 07:41:01 INFO: wazuh-dashboard service started.
07/01/2024 07:41:16 INFO: Initializing Wazuh dashboard web application.
07/01/2024 07:41:17 INFO: Wazuh dashboard web application initialized.
07/01/2024 07:41:17 INFO: --- Summary ---
07/01/2024 07:41:17 INFO: You can access the web interface https://172.30.0.66:443
    User: admin
    Password: **Unax25e3F?Ob5TGJZlVKo8m5YrcStV
07/01/2024 07:41:17 INFO: Installation finished.

NOT CHANGED TO admin/admin



[walt@companyrouter ~]$ sudo rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH

[walt@companyrouter ~]$ sudo cat /etc/yum.repos.d/wazuh.repo
[wazuh]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=EL-\$releasever - Wazuh
baseurl=https://packages.wazuh.com/4.x/yum/
protect=1







[root@companyrouter ~]# WAZUH_MANAGER="172.30.0.66" yum -y install wazuh-agent


[root@companyrouter ~]# systemctl status wazuh-agent
● wazuh-agent.service - Wazuh agent
     Loaded: loaded (/usr/lib/systemd/system/wazuh-agent.service; enabled; preset: disabled)
     Active: active (running) since Sun 2024-01-07 08:01:49 UTC; 1min 12s ago
      Tasks: 14 (limit: 10691)
     Memory: 730.0M
        CPU: 10.447s
     CGroup: /system.slice/wazuh-agent.service
             ├─5479 /var/ossec/bin/wazuh-execd
             ├─5491 /var/ossec/bin/wazuh-agentd
             ├─5505 /var/ossec/bin/wazuh-syscheckd
             ├─5566 /bin/sh active-response/bin/restart.sh agent
             ├─5570 /bin/sh /var/ossec/bin/wazuh-control restart
             └─7154 sleep 0.1

Jan 07 08:01:42 companyrouter systemd[1]: Starting Wazuh agent...
Jan 07 08:01:42 companyrouter env[5451]: Starting Wazuh v4.7.1...
Jan 07 08:01:43 companyrouter env[5451]: Started wazuh-execd...
Jan 07 08:01:44 companyrouter env[5451]: Started wazuh-agentd...
Jan 07 08:01:45 companyrouter env[5451]: Started wazuh-syscheckd...
Jan 07 08:01:46 companyrouter env[5451]: Started wazuh-logcollector...
Jan 07 08:01:47 companyrouter env[5451]: Started wazuh-modulesd...
Jan 07 08:01:49 companyrouter env[5451]: Completed.
Jan 07 08:01:49 companyrouter systemd[1]: Started Wazuh agent







PS C:\Users\Benny> VBoxManage startvm "ca_d_database" --type headless
Waiting for VM "ca_d_database" to power on...
VM "ca_d_database" has been successfully started.
PS C:\Users\Benny> ssh databaseD
Last login: Sat Jan  6 22:04:11 2024 from 192.168.100.1
[walt@database ~]$ sudo su -
[root@database ~]# rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH
[root@database ~]# cat > /etc/yum.repos.d/wazuh.repo << EOF
[wazuh]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=EL-\$releasever - Wazuh
baseurl=https://packages.wazuh.com/4.x/yum/
protect=1
EOF
[root@database ~]# WAZUH_MANAGER="172.30.0.66" yum -yq install wazuh-agent

Installed:
  wazuh-agent-4.7.1-1.x86_64

[root@database ~]# systemctl daemon-reload
[root@database ~]# systemctl enable wazuh-agent
Created symlink /etc/systemd/system/multi-user.target.wants/wazuh-agent.service → /usr/lib/systemd/system/wazuh-agent.service.
[root@database ~]# systemctl start wazuh-agent
[root@database ~]# systemctl status wazuh-agent
● wazuh-agent.service - Wazuh agent
     Loaded: loaded (/usr/lib/systemd/system/wazuh-agent.service; enabled; preset: disabled)
     Active: active (running) since Sun 2024-01-07 08:56:51 UTC; 4s ago
    Process: 2210 ExecStart=/usr/bin/env /var/ossec/bin/wazuh-control start (code=exited, status=0/SUCCESS)
      Tasks: 28 (limit: 5483)
     Memory: 52.6M
        CPU: 623ms
     CGroup: /system.slice/wazuh-agent.service
             ├─2238 /var/ossec/bin/wazuh-execd
             ├─2250 /var/ossec/bin/wazuh-agentd
             ├─2264 /var/ossec/bin/wazuh-syscheckd
             ├─2278 /var/ossec/bin/wazuh-logcollector
             └─2296 /var/ossec/bin/wazuh-modulesd

Jan 07 08:56:43 database systemd[1]: Starting Wazuh agent...
Jan 07 08:56:44 database env[2210]: Starting Wazuh v4.7.1...
Jan 07 08:56:45 database env[2210]: Started wazuh-execd...
Jan 07 08:56:46 database env[2210]: Started wazuh-agentd...
Jan 07 08:56:47 database env[2210]: Started wazuh-syscheckd...
Jan 07 08:56:48 database env[2210]: Started wazuh-logcollector...
Jan 07 08:56:49 database env[2210]: Started wazuh-modulesd...
Jan 07 08:56:51 database env[2210]: Completed.
Jan 07 08:56:51 database systemd[1]: Started Wazuh agent.





PS C:\TMP> $url = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.1-1.msi"
PS C:\TMP> $savefile = "C:\TMP\wazuh-agent-4.7.1-1.msi"
PS C:\TMP> Invoke-WebRequest -Uri $url -OutFile $savefile

PS C:\TMP> .\wazuh-agent-4.7.1-1.msi /q WAZUH_MANAGER="172.30.0.66"
PS C:\TMP> net start wazuh
The Wazuh service is starting.
The Wazuh service was started successfully.

PS C:\TMP>





PS C:\data\git\ca> ssh bastionR
Last login: Wed Jan  3 14:49:44 2024 from 172.30.20.254
[walt@bastion ~]$ sudo su -
[root@bastion ~]# sudo rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH
[root@bastion ~]# cat > /etc/yum.repos.d/wazuh.repo << EOF
[wazuh]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=EL-\$releasever - Wazuh
baseurl=https://packages.wazuh.com/4.x/yum/
protect=1
EOF
[root@bastion ~]# WAZUH_MANAGER="172.30.0.66" yum -yq install wazuh-agent

Installed:
  wazuh-agent-4.7.1-1.x86_64

[root@bastion ~]# systemctl daemon-reload
[root@bastion ~]# systemctl enable wazuh-agent
Created symlink /etc/systemd/system/multi-user.target.wants/wazuh-agent.service → /usr/lib/systemd/system/wazuh-agent.service.
[root@bastion ~]# systemctl start wazuh-agent
[root@bastion ~]# systemctl status wazuh-agent
● wazuh-agent.service - Wazuh agent
     Loaded: loaded (/usr/lib/systemd/system/wazuh-agent.service; enabled; preset: disabled)
     Active: active (running) since Sun 2024-01-07 13:40:30 UTC; 6s ago
    Process: 3905 ExecStart=/usr/bin/env /var/ossec/bin/wazuh-control start (code=exited, status=0/SUCCESS)
      Tasks: 28 (limit: 2260)
     Memory: 46.9M
        CPU: 696ms
     CGroup: /system.slice/wazuh-agent.service
             ├─3933 /var/ossec/bin/wazuh-execd
             ├─3945 /var/ossec/bin/wazuh-agentd
             ├─3959 /var/ossec/bin/wazuh-syscheckd
             ├─3973 /var/ossec/bin/wazuh-logcollector
             └─3991 /var/ossec/bin/wazuh-modulesd

Jan 07 13:40:23 bastion systemd[1]: Starting Wazuh agent...
Jan 07 13:40:23 bastion env[3905]: Starting Wazuh v4.7.1...
Jan 07 13:40:24 bastion env[3905]: Started wazuh-execd...
Jan 07 13:40:25 bastion env[3905]: Started wazuh-agentd...
Jan 07 13:40:26 bastion env[3905]: Started wazuh-syscheckd...
Jan 07 13:40:27 bastion env[3905]: Started wazuh-logcollector...
Jan 07 13:40:28 bastion env[3905]: Started wazuh-modulesd...
Jan 07 13:40:30 bastion env[3905]: Completed.
Jan 07 13:40:30 bastion systemd[1]: Started Wazuh agent.



WIN10:
PS C:\> cd TMP
PS C:\TMP> $url = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.1-1.msi"
PS C:\TMP> $savefile = "C:\TMP\wazuh-agent-4.7.1-1.msi"
PS C:\TMP> Invoke-WebRequest -Uri $url -OutFile $savefile
PS C:\TMP> .\wazuh-agent-4.7.1-1.msi /q WAZUH_MANAGER="172.30.0.66"
PS C:\TMP> net start wazuh
The Wazuh service is starting.
The Wazuh service was started successfully.

PS C:\TMP>








<!-- File integrity monitoring -->
  <syscheck>
    <disabled>no</disabled>

    <!-- Frequency that syscheck is executed default every 12 hours -->
    <frequency>43200</frequency>

    <scan_on_start>yes</scan_on_start>

    <!-- Directories to check  (perform all possible verifications) -->
    <directories>/etc,/usr/bin,/usr/sbin</directories>
    <directories>/bin,/sbin,/boot</directories>

    <!-- Files/directories to ignore -->
    <ignore>/etc/mtab</ignore>
    <ignore>/etc/hosts.deny</ignore>
    <ignore>/etc/mail/statistics</ignore>
    <ignore>/etc/random-seed</ignore>
    <ignore>/etc/random.seed</ignore>
    <ignore>/etc/adjtime</ignore>
    <ignore>/etc/httpd/logs</ignore>
    <ignore>/etc/utmpx</ignore>
    <ignore>/etc/wtmpx</ignore>
    <ignore>/etc/cups/certs</ignore>
    <ignore>/etc/dumpdates</ignore>
    <ignore>/etc/svc/volatile</ignore>

    <!-- File types to ignore -->
    <ignore type="sregex">.log$|.swp$</ignore>

    <!-- Check the file, but never compute the diff -->
    <nodiff>/etc/ssl/private.key</nodiff>

    <skip_nfs>yes</skip_nfs>
    <skip_dev>yes</skip_dev>
    <skip_proc>yes</skip_proc>
    <skip_sys>yes</skip_sys>

    <!-- Nice value for Syscheck process -->
    <process_priority>10</process_priority>

    <!-- Maximum output throughput -->
    <max_eps>50</max_eps>

    <!-- Database synchronization settings -->
    <synchronization>
    <enabled>yes</enabled>
    <interval>5m</interval>
    <max_eps>10</max_eps>
  </synchronization>
</syscheck>



[walt@companyrouter ~]$ sudo useradd -m -s /bin/bash h4ck3r
[walt@companyrouter ~]$ sudo passwd h4ck3r
Changing password for user h4ck3r.
New password:
BAD PASSWORD: The password is shorter than 8 characters
Retype new password:
passwd: all authentication tokens updated successfully.
[walt@companyrouter ~]$ grep h4ck3r /etc/passwd
h4ck3r:x:1007:1007::/home/h4ck3r:/bin/bash



DEMO FILE INTEGRITY

[walt@companyrouter ~]$ mkdir donotchange
[walt@companyrouter ~]$ cd donotchange/
[walt@companyrouter donotchange]$ curl -L --remote-name-all https://video.blender.org/download/videos/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4 https://www.gutenberg.org/ebooks/100.txt.utf-8 https://www.gutenberg.org/ebooks/996.txt.utf-8 https://upload.wikimedia.org/wikipedia/commons/4/40/Toreador_song_cleaned.ogg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  105M  100  105M    0     0  4638k      0  0:00:23  0:00:23 --:--:-- 4785k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0    733      0 --:--:-- --:--:-- --:--:--   733
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 5506k  100 5506k    0     0  3043k      0  0:00:01  0:00:01 --:--:-- 5410k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0   2479      0 --:--:-- --:--:-- --:--:--  2479
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 2335k  100 2335k    0     0  2070k      0  0:00:01  0:00:01 --:--:-- 1893k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1662k  100 1662k    0     0  6249k      0 --:--:-- --:--:-- --:--:-- 6249k


[walt@companyrouter donotchange]$ ls
100.txt.utf-8  996.txt.utf-8  Toreador_song_cleaned.ogg  bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4
[walt@companyrouter donotchange]$ nano test
[walt@companyrouter donotchange]$ rm 100.txt.utf-8
[walt@companyrouter donotchange]$


walt@wazzuh:~/wazzuh$ sudo grep directories /var/ossec/etc/ossec.conf
    <directories>/etc,/usr/bin,/usr/sbin</directories>
    <directories>/bin,/sbin,/boot</directories>
    <directories>/home/walt/donotchange</directories>
    <!-- Files/directories to ignore -->



walt@wazzuh:~/wazzuh$ sudo grep COMMAND /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 15:17:14 companyrouter sudo[2662]:    walt : TTY=pts/0 ; PWD=/home/walt/donotchange ; USER=root ; COMMAND=/bin/cat /var/ossec/queue/fim/db
Jan  7 15:17:20 companyrouter sudo[2665]:    walt : TTY=pts/0 ; PWD=/home/walt/donotchange ; USER=root ; COMMAND=/bin/ls /var/ossec/queue/fim/db
Jan  7 15:17:25 companyrouter sudo[2668]:    walt : TTY=pts/0 ; PWD=/home/walt/donotchange ; USER=root ; COMMAND=/bin/ls -al /var/ossec/queue/fim/db
Jan  7 15:47:19 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/bash wazuh-install.sh --wazuh-dashboard dashboard -o
Jan  7 15:49:01 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ss -tnlp
Jan  7 15:49:33 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/journalctl -xe
Jan  7 15:49:43 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/journalctl -xe
Jan  7 15:49:59 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/systemctl wazuh-manager
Jan  7 15:50:07 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/systemctl status wazuh-manager
Jan  7 15:58:10 bastion sudo[1930]:    walt : TTY=pts/0 ; PWD=/home/walt ; USER=root ; COMMAND=/sbin/ss -tnp
Jan  7 15:58:22 bastion sudo[1940]:    walt : PWD=/home/walt ; USER=root ; COMMAND=/sbin/poweroff
Jan  7 16:05:05 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep irector /var/ossec/etc/ossec.conf
Jan  7 16:05:15 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep directories /var/ossec/etc/ossec.conf
Jan  7 16:11:02 companyrouter sudo[2773]:    walt : TTY=pts/0 ; PWD=/etc ; USER=root ; COMMAND=/bin/nano HACKED
Jan  7 16:24:21 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/tail -f /var/ossec/logs/alerts/wazuh-alerts.log
Jan  7 16:24:43 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/
Jan  7 16:24:53 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs
Jan  7 16:24:57 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts
Jan  7 16:25:07 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/2024
Jan  7 16:25:12 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/2024/Jan
Jan  7 16:25:27 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:25:33 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/less /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:26:07 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/tail -f /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:26:40 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep checksum /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:27:02 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep Integrity /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:27:13 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep HACKED /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log


walt@wazzuh:~/wazzuh$ sudo grep COMMAND /var/ossec/logs/alerts/alerts.log
Jan  7 15:17:14 companyrouter sudo[2662]:    walt : TTY=pts/0 ; PWD=/home/walt/donotchange ; USER=root ; COMMAND=/bin/cat /var/ossec/queue/fim/db
Jan  7 15:17:20 companyrouter sudo[2665]:    walt : TTY=pts/0 ; PWD=/home/walt/donotchange ; USER=root ; COMMAND=/bin/ls /var/ossec/queue/fim/db
Jan  7 15:17:25 companyrouter sudo[2668]:    walt : TTY=pts/0 ; PWD=/home/walt/donotchange ; USER=root ; COMMAND=/bin/ls -al /var/ossec/queue/fim/db
Jan  7 15:47:19 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/bash wazuh-install.sh --wazuh-dashboard dashboard -o
Jan  7 15:49:01 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ss -tnlp
Jan  7 15:49:33 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/journalctl -xe
Jan  7 15:49:43 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/journalctl -xe
Jan  7 15:49:59 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/systemctl wazuh-manager
Jan  7 15:50:07 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/systemctl status wazuh-manager
Jan  7 15:58:10 bastion sudo[1930]:    walt : TTY=pts/0 ; PWD=/home/walt ; USER=root ; COMMAND=/sbin/ss -tnp
Jan  7 15:58:22 bastion sudo[1940]:    walt : PWD=/home/walt ; USER=root ; COMMAND=/sbin/poweroff
Jan  7 16:05:05 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep irector /var/ossec/etc/ossec.conf
Jan  7 16:05:15 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep directories /var/ossec/etc/ossec.conf
Jan  7 16:11:02 companyrouter sudo[2773]:    walt : TTY=pts/0 ; PWD=/etc ; USER=root ; COMMAND=/bin/nano HACKED
Jan  7 16:24:21 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/tail -f /var/ossec/logs/alerts/wazuh-alerts.log
Jan  7 16:24:43 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/
Jan  7 16:24:53 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs
Jan  7 16:24:57 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts
Jan  7 16:25:07 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/2024
Jan  7 16:25:12 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/2024/Jan
Jan  7 16:25:27 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:25:33 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/less /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:26:07 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/tail -f /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:26:40 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep checksum /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:27:02 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep Integrity /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:27:13 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep HACKED /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:27:43 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep COMMAND /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
command: /usr/bin/grep COMMAND /var/ossec/logs/alerts/2024/Jan/ossec-alerts-07.log
Jan  7 16:29:04 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/
Jan  7 16:29:11 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/ls /var/ossec/logs/alerts/alerts.log
Jan  7 16:29:17 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/cat /var/ossec/logs/alerts/alerts.log
Jan  7 16:29:29 wazzuh sudo:     walt : TTY=pts/0 ; PWD=/home/walt/wazzuh ; USER=root ; COMMAND=/usr/bin/grep HACKED /var/ossec/logs/alerts/alerts.log



[walt@companyrouter etc]$ sudo nano /var/ossec/etc/ossec.conf
[walt@companyrouter etc]$ sudo systemctl restart wazuh-agent


[walt@companyrouter ~]$ cd donotchange/
[walt@companyrouter donotchange]$ ls
996.txt.utf-8  Toreador_song_cleaned.ogg  bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4  test
[walt@companyrouter donotchange]$ rm Toreador_song_cleaned.ogg
[walt@companyrouter donotchange]$ curl -L --remote-name-all https://www.gutenberg.org/ebooks/100.txt.utf-8
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0    135      0  0:00:02  0:00:02 --:--:--   135
  0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0
100 5506k  100 5506k    0     0   948k      0  0:00:05  0:00:05 --:--:-- 1901k
[walt@companyrouter donotchange]$



PS C:\Users\vagrant.insecure\Desktop> New-AdUser -samAccountName benny -AccountPassword (ConvertTo-SecureString -AsPlainText "Friday13th!" -Force) -Path "cn=users,dc=insecure,dc=cyb" -GivenName "benny" -surnam
e "Benny" -DisplayName "benny Benny" -Enabled $true -Name "benny Benny"
PS C:\Users\vagrant.insecure\Desktop> Get-ADUser benny


DistinguishedName : CN=benny Benny,CN=Users,DC=insecure,DC=cyb
Enabled           : True
GivenName         : benny
Name              : benny Benny
ObjectClass       : user
ObjectGUID        : 4d14668d-e28a-4946-9981-4adbbbe68dce
SamAccountName    : benny
SID               : S-1-5-21-2681222979-3123228727-1689025860-1132
Surname           : Benny
UserPrincipalName :




[walt@bastion ~]$ sudo dnf install snapd
Last metadata expiration check: 0:02:03 ago on Sun Jan  7 18:09:59 2024.
Dependencies resolved.
=================================================================================================================================================================================================================
 Package                                                Architecture                                  Version                                                Repository                                     Size
=================================================================================================================================================================================================================
Installing:
 snapd                                                  x86_64                                        2.58.3-1.el9                                           epel                                           15 M
Installing dependencies:
 bash-completion                                        noarch                                        1:2.11-4.el9                                           baseos                                        291 k
 snap-confine                                           x86_64                                        2.58.3-1.el9                                           epel                                          2.5 M
 snapd-selinux                                          noarch                                        2.58.3-1.el9                                           epel                                          192 k

Transaction Summary
=================================================================================================================================================================================================================
Install  4 Packages

Total download size: 18 M
Installed size: 59 M
Is this ok [y/N]: y
Downloading Packages:
(1/4): bash-completion-2.11-4.el9.noarch.rpm                                                                                                                                     495 kB/s | 291 kB     00:00
(2/4): snap-confine-2.58.3-1.el9.x86_64.rpm                                                                                                                                      2.5 MB/s | 2.5 MB     00:01
(3/4): snapd-selinux-2.58.3-1.el9.noarch.rpm                                                                                                                                     451 kB/s | 192 kB     00:00
(4/4): snapd-2.58.3-1.el9.x86_64.rpm                                                                                                                                             8.1 MB/s |  15 MB     00:01
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                            6.8 MB/s |  18 MB     00:02
Extra Packages for Enterprise Linux 9 - x86_64                                                                                                                                   1.6 MB/s | 1.6 kB     00:00
Importing GPG key 0x3228467C:
 Userid     : "Fedora (epel9) <epel@fedoraproject.org>"
 Fingerprint: FF8A D134 4597 106E CE81 3B91 8A38 72BF 3228 467C
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9
Is this ok [y/N]: y
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                                         1/1
  Running scriptlet: snapd-selinux-2.58.3-1.el9.noarch                                                                                                                                                       1/4
  Installing       : snapd-selinux-2.58.3-1.el9.noarch                                                                                                                                                       1/4
  Running scriptlet: snapd-selinux-2.58.3-1.el9.noarch                                                                                                                                                       1/4
  Installing       : snap-confine-2.58.3-1.el9.x86_64                                                                                                                                                        2/4
  Installing       : bash-completion-1:2.11-4.el9.noarch                                                                                                                                                     3/4
  Installing       : snapd-2.58.3-1.el9.x86_64                                                                                                                                                               4/4
  Running scriptlet: snapd-2.58.3-1.el9.x86_64                                                                                                                                                               4/4
  Running scriptlet: snapd-selinux-2.58.3-1.el9.noarch                                                                                                                                                       4/4
  Running scriptlet: snapd-2.58.3-1.el9.x86_64                                                                                                                                                               4/4
  Verifying        : bash-completion-1:2.11-4.el9.noarch                                                                                                                                                     1/4
  Verifying        : snap-confine-2.58.3-1.el9.x86_64                                                                                                                                                        2/4
  Verifying        : snapd-2.58.3-1.el9.x86_64                                                                                                                                                               3/4
  Verifying        : snapd-selinux-2.58.3-1.el9.noarch                                                                                                                                                       4/4

Installed:
  bash-completion-1:2.11-4.el9.noarch                    snap-confine-2.58.3-1.el9.x86_64                    snapd-2.58.3-1.el9.x86_64                    snapd-selinux-2.58.3-1.el9.noarch

Complete!
[walt@bastion ~]$ sudo nap -v
sudo: nap: command not found
[walt@bastion ~]$ sudo snap -v
error: unknown flag `v'
[walt@bastion ~]$ sudo snap
The snap command lets you install, configure, refresh and remove snaps.
Snaps are packages that work across many different Linux distributions,
enabling secure delivery and operation of the latest apps and utilities.

Usage: snap <command> [<options>...]

Commonly used commands can be classified as follows:

         Basics: find, info, install, remove, list
        ...more: refresh, revert, switch, disable, enable, create-cohort
        History: changes, tasks, abort, watch
        Daemons: services, start, stop, restart, logs
    Permissions: connections, interface, connect, disconnect
  Configuration: get, set, unset, wait
    App Aliases: alias, aliases, unalias, prefer
        Account: login, logout, whoami
      Snapshots: saved, save, check-snapshot, restore, forget
         Device: model, reboot, recovery
      ... Other: warnings, okay, known, ack, version
    Development: download, pack, run, try

For more information about a command, run 'snap help <command>'.
^C
[walt@bastion ~]$ sudo snap whoami
email: -
[walt@bastion ~]$ sudo snap find powershell
^C
[walt@bastion ~]$ sudo snap install powershell --classic
error: cannot communicate with server: Post "http://localhost/v2/snaps/powershell": dial unix /run/snapd.socket: connect: no such file or directory
[walt@bastion ~]$ sudo systemctl status snapd
○ snapd.service - Snap Daemon
     Loaded: loaded (/usr/lib/systemd/system/snapd.service; disabled; preset: disabled)
     Active: inactive (dead)
TriggeredBy: ○ snapd.socket
[walt@bastion ~]$ sudo systemctl start snapd
[walt@bastion ~]$ sudo systemctl status snapd
● snapd.service - Snap Daemon
     Loaded: loaded (/usr/lib/systemd/system/snapd.service; disabled; preset: disabled)
     Active: active (running) since Sun 2024-01-07 18:16:32 UTC; 1s ago
TriggeredBy: ● snapd.socket
   Main PID: 7163 (snapd)
      Tasks: 7 (limit: 10693)
     Memory: 29.2M
        CPU: 157ms
     CGroup: /system.slice/snapd.service
             └─7163 /usr/libexec/snapd/snapd

Jan 07 18:16:32 bastion systemd[1]: Starting Snap Daemon...
Jan 07 18:16:32 bastion snapd[7163]: overlord.go:268: Acquiring state lock file
Jan 07 18:16:32 bastion snapd[7163]: overlord.go:273: Acquired state lock file
Jan 07 18:16:32 bastion snapd[7163]: daemon.go:247: started snapd/2.58.3-1.el9 (series 16; classic; devmode) almalinux/9.3 (amd64) linux/5.14.0-362.13.1.el9_3.x86.
Jan 07 18:16:32 bastion snapd[7163]: daemon.go:340: adjusting startup timeout by 30s (pessimistic estimate of 30s plus 5s per snap)
Jan 07 18:16:32 bastion snapd[7163]: backends.go:58: AppArmor status: apparmor not enabled
Jan 07 18:16:32 bastion snapd[7163]: helpers.go:146: error trying to compare the snap system key: system-key missing on disk
Jan 07 18:16:32 bastion systemd[1]: snapd.service: Got notification message from PID 7196, but reception only permitted for main PID 7163
Jan 07 18:16:32 bastion systemd[1]: Started Snap Daemon.
[walt@bastion ~]$ sudo snap find powershell
Name                Version     Publisher              Notes    Summary
powershell          7.4.0       microsoft-powershell✓  classic  PowerShell for every system!
powershell-preview  7.4.0-rc.1  microsoft-powershell✓  classic  PowerShell for every system!
portal              1.2.3       zinokader              -        Quick and easy command-line file transfer utility from any computer to another.
v2rayx              0.4.0       shaonhuang             -        ✨✨V2ray GUI client with cross-platform desktop support powered by Electron⚛️, made especially for Linux / Windows / MacOS users.
ctfreak             1.13.1      ctfreak                -        IT task scheduler with concurrent and remote executions
[walt@bastion ~]$ sudo snap install powershell --classic
error: cannot install "powershell": classic confinement requires snaps under /snap or symlink from
       /snap to /var/lib/snapd/snap
[walt@bastion ~]$ sudo systemctl enable snapd
Created symlink /etc/systemd/system/multi-user.target.wants/snapd.service → /usr/lib/systemd/system/snapd.service.
[walt@bastion ~]$ exit
logout
Connection to bastion closed.
PS C:\data\git\ca> ssh bastionR sudo reboot
PS C:\data\git\ca> ssh bastionR
Last login: Sun Jan  7 18:11:32 2024 from 172.30.20.254
[walt@bastion ~]$ sudo ln -s /var/lib/snapd/snap /snap
[walt@bastion ~]$ sudo snap install hello-world
2024-01-07T18:19:12Z INFO Waiting for automatic snapd restart...
hello-world 6.4 from Canonical✓ installed
[walt@bastion ~]$ sudo snap install powershell --classic
powershell 7.4.0 from Microsoft PowerShell✓ installed


[walt@bastion ~]$ pwsh
PowerShell 7.4.0
PS /home/walt> IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicredteam.ps1' -UseBasicParsing);
PS /home/walt> Install-AtomicRedTeam -getAtomics
Installation of Invoke-AtomicRedTeam is complete. You can now use the Invoke-AtomicTest function
See Wiki at https://github.com/redcanaryco/invoke-atomicredteam/wiki for complete details



PS /home/walt> Invoke-AtomicTest

cmdlet Invoke-AtomicTest at command pipeline position 1
Supply values for the following parameters:
AtomicTechnique[0]: T1003.008
AtomicTechnique[1]:
PathToAtomicsFolder = /home/walt/AtomicRedTeam/atomics

Executing test: T1003.008-1 Access /etc/shadow (Local)
root:$6$A9.6aOD8CpxwRGZz$yx5HPYZeGPiZeQXfYiKA6dkAKLc9fCXq6Hyo4W0SIdnEaPG6NOWNlgH82/tcZJhfIWeNKFZjQP5Ta6gVsSR8O/::0:99999:7:::
bin:*:19453:0:99999:7:::
daemon:*:19453:0:99999:7:::
adm:*:19453:0:99999:7:::
lp:*:19453:0:99999:7:::
sync:*:19453:0:99999:7:::
shutdown:*:19453:0:99999:7:::
halt:*:19453:0:99999:7:::
mail:*:19453:0:99999:7:::
operator:*:19453:0:99999:7:::
games:*:19453:0:99999:7:::
ftp:*:19453:0:99999:7:::
nobody:*:19453:0:99999:7:::
systemd-coredump:!!:19492::::::
dbus:!!:19492::::::
tss:!!:19492::::::
sssd:!!:19492::::::
chrony:!!:19492::::::
sshd:!!:19492::::::
systemd-oom:!*:19492::::::
vagrant:$6$gcafwRftOxv7fY5m$azbqlCRfAuQJ0K2w8I983gAd4ZLVfRNGk7OTjXo..ggqtREWauFk7PFfNjlAWGq.VLbCCP3moScfs2MU74xDT.::0:99999:7:::
vboxadd:!!:19492::::::
rpc:!!:19492:0:99999:7:::
rpcuser:!!:19492::::::
walt:$1$1tjin294$OvflhO8DhJ5Pjb183NUkN.:19720:0:99999:7:::
jump:$1$T6N2Q8Sl$.hMobw8MLOPHkw2Cs0jGE0:19721:0:99999:7:::
windc:$1$DHc..iHJ$Fh.Y6/cRJzgaAQhvc7rOI0:19721:0:99999:7:::
jumpdatabase:$1$rFmf8BjP$Yn6t4MYuPumXOPVW0G.ic.:19723:0:99999:7:::
wazuh:!!:19729::::::
Exit code: 0
Done executing test: T1003.008-1 Access /etc/shadow (Local)
Executing test: T1003.008-2 Access /etc/master.passwd (Local)
cat: /etc/master.passwd: No such file or directory
Exit code: 0
Done executing test: T1003.008-2 Access /etc/master.passwd (Local)
Executing test: T1003.008-3 Access /etc/passwd (Local)
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:65534:65534:Kernel Overflow User:/:/sbin/nologin
systemd-coredump:x:999:997:systemd Core Dumper:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
tss:x:59:59:Account used for TPM access:/dev/null:/sbin/nologin
sssd:x:998:995:User for sssd:/:/sbin/nologin
chrony:x:997:994:chrony system user:/var/lib/chrony:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/usr/share/empty.sshd:/sbin/nologin
systemd-oom:x:992:992:systemd Userspace OOM Killer:/:/usr/sbin/nologin
vagrant:x:1000:1000::/home/vagrant:/bin/bash
vboxadd:x:991:1::/var/run/vboxadd:/bin/false
rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
walt:x:1001:1001::/home/walt:/bin/bash
jump:x:1002:1002::/home/jump:/bin/bash
windc:x:1003:1003::/home/windc:/bin/bash
jumpdatabase:x:1004:1004::/home/jumpdatabase:/bin/bash
wazuh:x:990:989::/var/ossec:/sbin/nologin
Exit code: 0
Done executing test: T1003.008-3 Access /etc/passwd (Local)
Executing test: T1003.008-4 Access /etc/{shadow,passwd,master.passwd} with a standard bin that's not cat
sh: line 1: ${output_file}: ambiguous redirect
Exit code: 1
Done executing test: T1003.008-4 Access /etc/{shadow,passwd,master.passwd} with a standard bin that's not cat
Executing test: T1003.008-5 Access /etc/{shadow,passwd,master.passwd} with shell builtins
environment: line 1: /etc/shadow: Permission denied
Exit code: 1
Done executing test: T1003.008-5 Access /etc/{shadow,passwd,master.passwd} with shell builtins
PS /home/walt>

PS /home/walt> Invoke-AtomicTest

cmdlet Invoke-AtomicTest at command pipeline position 1
Supply values for the following parameters:
AtomicTechnique[0]: T1552.003
AtomicTechnique[1]:
PathToAtomicsFolder = /home/walt/AtomicRedTeam/atomics

Executing test: T1552.003-1 Search Through Bash History
Exit code: 0
Done executing test: T1552.003-1 Search Through Bash History
Executing test: T1552.003-2 Search Through sh History
cat: /home/walt/.history: No such file or directory
Exit code: 1
Done executing test: T1552.003-2 Search Through sh History
PS /home/walt>





PS /home/walt> Invoke-AtomicTest

cmdlet Invoke-AtomicTest at command pipeline position 1
Supply values for the following parameters:
AtomicTechnique[0]: T1003.007
AtomicTechnique[1]:
PathToAtomicsFolder = /home/walt/AtomicRedTeam/atomics

Executing test: T1003.007-1 Dump individual process memory with sh (Local)
sh: /tmp/T1003.007.sh: No such file or directory
dd: /proc/3015/mem: cannot skip to specified offset
dd: error reading '/proc/3015/mem': Input/output error
135168+0 records in
264+0 records out
135168 bytes (135 kB, 132 KiB) copied, 0.0560833 s, 2.4 MB/s
Exit code: 0
Done executing test: T1003.007-1 Dump individual process memory with sh (Local)
Executing test: T1003.007-2 Dump individual process memory with sh on FreeBSD (Local)
sh /tmp/T1003.007.sh; PID=$(pgrep -n -f "T1003.007"); HEAP_MEM=$(grep -E "^[0-9a-f-]* r" /proc/"$PID"/maps | grep heap | cut -d' ' -f 1); MEM_START=$(echo $((0x$(echo "$HEAP_MEM" | cut -d"-" -f1)))); MEM_STOP=$(echo $((0x$(echo "$HEAP_MEM" | cut -d"-" -f2)))); MEM_SIZE=$(echo $((0x$MEM_STOP-0x$MEM_START))); dd if=/proc/"${PID}"/mem of="/tmp/T1003.007.bin" ibs=1 skip="$MEM_START" count="$MEM_SIZE"; grep -i "PASS" "/tmp/T1003.007.bin"
sh /tmp/T1003.007.sh; PID=$(pgrep -n -f "T1003.007"); HEAP_MEM=$(grep -E "^[0-9a-f-]* r" /proc/"$PID"/maps | grep heap | cut -d' ' -f 1); MEM_START=$(echo $((0x$(echo "$HEAP_MEM" | cut -d"-" -f1)))); MEM_STOP=$(echo $((0x$(echo "$HEAP_MEM" | cut -d"-" -f2)))); MEM_SIZE=$(echo $((0x$MEM_STOP-0x$MEM_START))); dd if=/proc/"${PID}"/mem of="/tmp/T1003.007.bin" ibs=1 skip="$MEM_START" count="$MEM_SIZE"; grep -i "PASS" "/tmp/T1003.007.bin"
sh /tmp/T1003.007.sh; PID=$(pgrep -n -f "T1003.007"); HEAP_MEM=$(grep -E "^[0-9a-f-]* r" /proc/"$PID"/maps | grep heap | cut -d' ' -f 1); MEM_START=$(echo $((0x$(echo "$HEAP_MEM" | cut -d"-" -f1)))); MEM_STOP=$(echo $((0x$(echo "$HEAP_MEM" | cut -d"-" -f2)))); MEM_SIZE=$(echo $((0x$MEM_STOP-0x$MEM_START))); dd if=/proc/"${PID}"/mem of="/tmp/T1003.007.bin" ibs=1 skip="$MEM_START" count="$MEM_SIZE"; grep -i "PASS" "/tmp/T1003.007.bin"
"PASS"
sh: /tmp/T1003.007.sh: No such file or directory
head: cannot open '/proc/3037/map' for reading: No such file or directory
head: cannot open '/proc/3037/map' for reading: No such file or directory
sh: line 1: -: syntax error: operand expected (error token is "-")
dd: invalid number: ‘’
Exit code: 0
Done executing test: T1003.007-2 Dump individual process memory with sh on FreeBSD (Local)
Executing test: T1003.007-3 Dump individual process memory with Python (Local)
sh: /tmp/T1003.007.sh: No such file or directory
grep: /tmp/T1003.007.bin: binary file matches
Exit code: 0
Done executing test: T1003.007-3 Dump individual process memory with Python (Local)
Executing test: T1003.007-4 Capture Passwords with MimiPenguin
sudo: /tmp/mimipenguin/mimipenguin_2.0-release/mimipenguin.sh: command not found
Exit code: 0
Done executing test: T1003.007-4 Capture Passwords with MimiPenguin
PS /home/walt>




[walt@companyrouter donotchange]$ sudo cat /var/ossec/active-response/bin/remove-threat.sh
#!/bin/bash

LOCAL=`dirname $0`;
cd $LOCAL
cd ../

PWD=`pwd`

read INPUT_JSON
FILENAME=$(echo $INPUT_JSON | jq -r .parameters.alert.data.virustotal.source.file)
COMMAND=$(echo $INPUT_JSON | jq -r .command)
LOG_FILE="${PWD}/../logs/active-responses.log"

#------------------------ Analyze command -------------------------#
if [ ${COMMAND} = "add" ]
then
 # Send control message to execd
 printf '{"version":1,"origin":{"name":"remove-threat","module":"active-response"},"command":"check_keys", "parameters":{"keys":[]}}\n'

 read RESPONSE
 COMMAND2=$(echo $RESPONSE | jq -r .command)
 if [ ${COMMAND2} != "continue" ]
 then
  echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Remove threat active response aborted" >> ${LOG_FILE}
  exit 0;
 fi
fi

# Removing file
rm -f $FILENAME
if [ $? -eq 0 ]; then
 echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Successfully removed threat" >> ${LOG_FILE}
else
 echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Error removing threat" >> ${LOG_FILE}
fi

exit 0;





[walt@companyrouter donotchange]$ sudo grep directories /var/ossec/etc/ossec.conf
    <directories>/etc,/usr/bin,/usr/sbin</directories>
    <directories>/bin,/sbin,/boot</directories>
    <directories realtime="yes">/home/walt/donotchange</directories>
    <directories realtime="yes">/home/walt/virus</directories>
    <!-- Files/directories to ignore -->

    [walt@companyrouter donotchange]$ sudo grep directories /var/ossec/etc/ossec.conf
    <directories>/etc,/usr/bin,/usr/sbin</directories>
    <directories>/bin,/sbin,/boot</directories>
    <directories realtime="yes">/home/walt/donotchange</directories>
    <directories realtime="yes">/home/walt/virus</directories>
    <!-- Files/directories to ignore -->
[walt@companyrouter donotchange]$ sudo chmod 750 /var/ossec/active-response/bin/remove-threat.sh
[walt@companyrouter donotchange]$ sudo chown root:wazuh /var/ossec/active-response/bin/remove-threat.sh
[walt@companyrouter donotchange]$ sudo systemctl restart wazuh-agent





6f7da2cc986ba6199aeb5b587143dc32ee7cd9502effb1e972a35c953742b3e1








Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/Sysmon.zip' -OutFile 'C:\TMP\Sysmon.zip'
Expand-Archive -Path 'C:\TMP\Sysmon.zip' -DestinationPath 'C:\TMP'
Start-Process -FilePath 'C:\TMP\Sysmon.exe' -ArgumentList '/accepteula /i /h'

Invoke-WebRequest -Uri 'https://wazuh.com/resources/blog/emulation-of-attack-techniques-and-detection-with-wazuh/sysmonconfig.xml' -OutFile 'C:\TMP\sysmonconfig.xml'


> .\Sysmon64.exe -accepteula -i .\sysmonconfig.xml





Start-Process -FilePath 'C:\TMP\Sysmon.exe' -ArgumentList '/accepteula /i /h /c C:\TMP\sysmonconfig.xml'





PS C:\TMP> Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/Sysmon.zip' -OutFile 'C:\TMP\Sysmon.zip'
PS C:\TMP> Expand-Archive -Path 'C:\TMP\Sysmon.zip' -DestinationPath 'C:\TMP'
PS C:\TMP> Invoke-WebRequest -Uri 'https://wazuh.com/resources/blog/emulation-of-attack-techniques-and-detection-with-wazuh/sysmonconfig.xml' -OutFile 'C:\TMP\sysmonconfig.xml'
PS C:\TMP> .\Sysmon64.exe -accepteula -i .\sysmonconfig.xml




https://download.sysinternals.com/files/PSTools.zip
Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/PSTools.zip' -OutFile 'C:\TMP\PSTools.zip'
Expand-Archive -Path 'C:\TMP\PSTools.zip' -DestinationPath 'C:\TMP'
./psexec -i -s powershell /accepteula









Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Try the new cross-platform PowerShell https://aka.ms/pscore6

PS C:\Windows\system32> whoami
nt authority\system
PS C:\Windows\system32>


PS C:\> cd TMP2
PS C:\TMP2> Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/PSTools.zip' -OutFile 'C:\TMP2\PSTools.zip'
PS C:\TMP2> Expand-Archive -Path 'C:\TMP2\PSTools.zip' -DestinationPath 'C:\TMP2'
PS C:\TMP2> ./psexec -i -s powershell /accepteula

PsExec v2.43 - Execute processes remotely
Copyright (C) 2001-2023 Mark Russinovich
Sysinternals - www.sysinternals.com


powershell exited on WIN10 with error code 0.
PS C:\TMP2>

