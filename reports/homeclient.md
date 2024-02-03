PS C:\data\git\ca\homeclient> cat .\Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "homeclient" do |my_machine|
    config.vm.box = "ubuntu/focal64"
    config.vm.hostname = "homeclient"
    config.vm.network "private_network", virtualbox_intnet: "VirtualBox Host-Only Ethernet Adapter #2", type: "static", ip: "192.168.100.167"
    config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.name = "ca_c_homeclient"
      vb.memory = "512"
      vb.cpus = "1"
      vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
    end
  end
end




PS C:\data\git\ca\homeclient> vagrant ssh
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jan  9 12:15:09 UTC 2024

  System load:  0.1               Processes:               107
  Usage of /:   3.7% of 38.70GB   Users logged in:         0
  Memory usage: 39%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 192.168.100.167


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@homeclient:~$

vagrant@homeclient:~$ echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFI4Qm7YeH2CZQlKcmlpj2U0zpIYT74nRpiVfWnYy9p+vjChA0lF4lZ9XSGevq+ZVHWV3RBzpmcBS5i0XrZSGbEfh6zwsYpAy7K8ErIbSepdNJkBm1jMslGO3E5gabU2tP/+TUpyfrHuuV377IrwQ3XxPOjuCPj0WOwlcFgZovtLc0ZH39ns6O8K3SVYLkho2NdgMXi4gJAlQCOj99kjA+ZT5xhOJ832w2rJn7t8XfS+fgOwoNhErv9Mq6r8c7zyE3eYKkMfk0S24jFyC66fZSu7/LERC/F4ipGGc4MyB9ODu47CAE9knRA358nuB9x4lnklVYP7twPP0iOPrgqLEcYt6fakNaniHCJxmyokINys2NqtjZNDJEBkPBWvOPoRoM555GNIsVpnsJparVmFVoCtMGCUNnvyClRBI90To1t39LMhiN8oTshU0zbuErdkln2iHX4E8czQyfcYkSNtZ0x8FPWBQxzsc/t5UR6NDLHorZTBqbXS0gHH0oxJvVL58= benny.clemmens@student.hogent.be" >> ~/.ssh/authorized_keys
vagrant@homeclient:~$ exit
logout
Connection to 127.0.0.1 closed.
PS C:\data\git\ca\homeclient>


PS C:\data\git\ca\homeclient> ssh homeclientD
The authenticity of host 'homeclient (192.168.100.167)' can't be established.
ECDSA key fingerprint is SHA256:RkApM+Xw6YFKDcv9+liEAzFfabia9AR9s4hiAOfn0Z8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'homeclient,192.168.100.167' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jan  9 12:23:08 UTC 2024

  System load:  0.02              Processes:               104
  Usage of /:   3.7% of 38.70GB   Users logged in:         0
  Memory usage: 39%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 192.168.100.167


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Tue Jan  9 12:15:09 2024 from 10.0.2.2
vagrant@homeclient:~$


PS C:\data\git\ca\homeclient> ssh homeclientD sudo poweroff
Connection to homeclient closed by remote host.

PS C:\data\git\ca\homeclient>




PS C:\data\git\ca\homeclient> VBoxManage modifyvm "ca_c_homeclient" --cable-connected1=off
PS C:\data\git\ca\homeclient> VBoxManage startvm "ca_c_homeclient" --type headless
Waiting for VM "ca_c_homeclient" to power on...
VM "ca_c_homeclient" has been successfully started.


vagrant@homeclient:/etc/netplan$ cat /etc/netplan/50-vagrant.yaml
---
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      dhcp4: false
      addresses:
      - 192.168.100.167/24
      gateway4: 192.168.100.254
      nameservers:
        addresses [8.8.8.8,172.30.0.4]


