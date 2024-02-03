# isprouter

## Lab 00: Lab environment Guidelines

`Can all virtual machines be reached?`

```console
isprouter:~$ ping -c 5 -q 192.168.100.253 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
isprouter:~$ ping -c 5 -q 172.130.255.254 | grep trans
5 packets transmitted, 0 packets received, 100% packet loss
isprouter:~$ ping -c 5 -q 172.130.0.4 | grep trans
5 packets transmitted, 0 packets received, 100% packet loss
isprouter:~$ ping -c 5 -q 172.130.0.10 | grep trans
5 packets transmitted, 0 packets received, 100% packet loss
isprouter:~$ ping -c 5 -q 172.130.0.15 | grep trans
5 packets transmitted, 0 packets received, 100% packet loss
```

`isprouter doesn't know 172.30.0.0/16, so this route has to be added`

```console
isprouter:~$ sudo ip route add 172.30.0.0/16 via 192.168.100.253
isprouter:~$ ip route
default via 10.0.2.2 dev eth0  metric 202
10.0.2.0/24 dev eth0 scope link  src 10.0.2.15
172.30.0.0/16 via 192.168.100.253 dev eth1
192.168.100.0/24 dev eth1 scope link  src 192.168.100.254
isprouter:~$ ping -c 5 -q 172.30.255.254 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
isprouter:~$ ping -c 5 -q 172.30.0.4 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
isprouter:~$ ping -c 5 -q 172.30.0.10 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
isprouter:~$ ping -c 5 -q 172.30.0.15 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
isprouter:~$ ping -c 5 -q 172.30.10.100 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
isprouter:~$ ping -c 5 -q 172.30.10.101 | grep trans
5 packets transmitted, 5 packets received, 0% packet loss
```

`To make this route persistent:`

```code
isprouter:~$ cat /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    hostname alpine38.localdomain
auto eth1
iface eth1 inet static
  address 192.168.100.254
  netmask 255.255.255.0
  up route add -net 172.30.0.0 netmask 255.255.0.0 gw 192.168.100.253
  down route del -net 172.30.0.0 netmask 255.255.0.0 gw 192.168.100.253
```

```code
isprouter:~$ ping -c 5 8.8.8.8
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=42 time=26.972 ms
64 bytes from 8.8.8.8: seq=1 ttl=42 time=51.328 ms
64 bytes from 8.8.8.8: seq=2 ttl=42 time=26.330 ms
64 bytes from 8.8.8.8: seq=3 ttl=42 time=46.345 ms
64 bytes from 8.8.8.8: seq=4 ttl=42 time=19.156 ms

--- 8.8.8.8 ping statistics ---
5 packets transmitted, 5 packets received, 0% packet loss
round-trip min/avg/max = 19.156/34.026/51.328 ms
isprouter:~$ ping -c 5 www.hln.be
PING www.hln.be (2.17.196.144): 56 data bytes
64 bytes from 2.17.196.144: seq=0 ttl=42 time=32.012 ms
64 bytes from 2.17.196.144: seq=1 ttl=42 time=49.618 ms
64 bytes from 2.17.196.144: seq=2 ttl=42 time=11.873 ms
64 bytes from 2.17.196.144: seq=3 ttl=42 time=38.013 ms
64 bytes from 2.17.196.144: seq=4 ttl=42 time=24.793 ms

--- www.hln.be ping statistics ---
5 packets transmitted, 5 packets received, 0% packet loss
round-trip min/avg/max = 11.873/31.261/49.618 ms
```

## Lab 01: Lecture 1 Exercises

`Connecting via ssh, host is on the same internal network`

```code
PS C:\data\git\CA> ssh vagrant@192.168.100.254
vagrant@192.168.100.254's password:
isprouter:~$
```

`What are we running ...`

```code
isprouter:~$ cat /etc/os-release
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.8.5
PRETTY_NAME="Alpine Linux v3.8"
HOME_URL="http://alpinelinux.org"
BUG_REPORT_URL="http://bugs.alpinelinux.org"
isprouter:~$ uname -a
Linux isprouter 4.14.167-0-virt #1-Alpine SMP Thu Jan 23 10:58:18 UTC 2020 x86_64 Linux
```

`Who else is here?`

```code
isprouter:~$ grep -vE 'false|nologin|sync|shutdown|halt' /etc/passwd
root:x:0:0:root:/root:/bin/bash
operator:x:11:0:operator:/root:/bin/sh
postgres:x:70:70::/var/lib/postgresql:/bin/sh
vagrant:x:1000:1000:Linux User,,,:/home/vagrant:/bin/bash
```

`Checking out the neighbourhood`

```code
isprouter:~$ ip -4 addr show | awk '/inet / {print $5, $2}' | grep -v '127.0.0.1'
eth0 10.0.2.15/24
eth1 192.168.100.254/24
isprouter:~$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    inet 10.0.2.15/24 scope global eth0
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    inet 192.168.100.254/24 scope global eth1
       valid_lft forever preferred_lft forever
isprouter:~$ ip r
default via 10.0.2.2 dev eth0  metric 202
10.0.2.0/24 dev eth0 scope link  src 10.0.2.15
192.168.100.0/24 dev eth1 scope link  src 192.168.100.254
isprouter:~$ cat /etc/resolv.conf
search home
nameserver 10.0.2.3
isprouter:~$ ip neigh
192.168.100.1 dev eth1 lladdr 0a:00:27:00:00:1a ref 1 used 0/0/0 probes 1 REACHABLE
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 used 0/0/0 probes 1 STALE
192.168.100.253 dev eth1 lladdr 08:00:27:2e:6b:e6 used 0/0/0 probes 1 STALE
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 used 0/0/0 probes 1 STALE
```

`Connectivity for isprouter was allready checked and made persistent in Lab 00`

`Investigating the history to learn what was installed...`

```code
isprouter:~$ cat ~/.bash_history
ip a
ip r
cat /etc/resolv.conf
sudo apk update
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
sudo apk add iptables
sudo rc-update add iptables
sudo iptables -A FORWARD -i eth1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo /etc/init.d/iptables save
sudo apk add dhcp
sudo ip route add 172.30.0.0/16 via 192.168.100.253
sudo rc-update add dhcpd
sudo vi /etc/dhcp/dhcpd.conf
sudo rc-service dhcpd start
exit
sudo poweroff
```

- `Alpine uses apk (Alpine Package Keeper) as package manager`
- `net.ipv4.ip_forward=1 allows the kernel to forward`
- `iptables (here) configures the system as router with nat enabled, rc-update sets it 'enabled'`
- `sudo /etc/init.d/iptables save persistently saves current iptables config to /etc/iptables/rules-save`
- `adding a route is not persistent over reboots`

```code
isprouter:~$ sudo cat /etc/iptables/rules-save
# Generated by iptables-save v1.6.2 on Fri Nov 24 11:54:26 2023
*filter
:INPUT ACCEPT [15179:2605017]
:FORWARD ACCEPT [155035:723823557]
:OUTPUT ACCEPT [11287:1058400]
[114986:11508334] -A FORWARD -i eth1 -j ACCEPT
COMMIT
# Completed on Fri Nov 24 11:54:26 2023
# Generated by iptables-save v1.6.2 on Fri Nov 24 11:54:26 2023
*nat
:PREROUTING ACCEPT [6020:446769]
:INPUT ACCEPT [659:55954]
:OUTPUT ACCEPT [295:21797]
:POSTROUTING ACCEPT [133:9401]
[4340:316887] -A POSTROUTING -o eth0 -j MASQUERADE
COMMIT
# Completed on Fri Nov 24 11:54:26 2023
```

`isprouter also serves as dhcp-server for the internal network #2`

```code
isprouter:~$ sudo rc-service dhcpd status
 * status: started
isprouter:~$ sudo cat /etc/dhcp/dhcpd.conf
subnet 192.168.100.0 netmask 255.255.255.0 {
  range 192.168.100.100 192.168.100.200;
  option domain-name-servers 10.0.2.3;
  option routers 192.168.100.254;
}
isprouter:~$ cat /var/lib/dhcp/dhcpd.leases
# The format of this file is documented in the dhcpd.leases(5) manual page.
# This lease file was written by isc-dhcp-4.4.1

# authoring-byte-order entry is generated, DO NOT DELETE
authoring-byte-order little-endian;

lease 192.168.100.101 {
  starts 3 2023/09/20 14:28:19;
  ends 3 2023/09/20 15:11:25;
  tstp 3 2023/09/20 15:11:25;
  cltt 3 2023/09/20 14:28:19;
  binding state free;
  hardware ethernet 08:00:27:24:fa:fa;
  uid "\377'$\372\372\000\001\000\001+\266\254\371\010\000'$\372\372";
}
lease 192.168.100.100 {
  starts 3 2023/09/20 10:54:32;
  ends 3 2023/09/20 22:54:32;
  tstp 3 2023/09/20 22:54:32;
  cltt 3 2023/09/20 10:54:32;
  binding state free;
  hardware ethernet 08:00:27:a8:ae:b5;
  uid "\001\010\000'\250\256\265";
}
lease 192.168.100.102 {
  starts 5 2023/11/24 09:14:12;
  ends 5 2023/11/24 21:14:12;
  tstp 5 2023/11/24 21:14:12;
  cltt 5 2023/11/24 09:14:12;
  binding state free;
  hardware ethernet 08:00:27:f4:2f:a2;
  uid "\001\010\000'\364/\242";
}
server-duid "\000\001\000\001,\367\201u\010\000'\346`\234";
```

`Some packages I like`

```code
sudo apk add iproute2 bind-tools nano
```

`Usefull commands`

```code
isprouter:~$ echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
isprouter:~$ sudo sysctl -p

isprouter:~$ sudo apk update
isprouter:~$ sudo apk add iproute2 bind-tools nano
isprouter:~$ sudo apk add iptables
isprouter:~$ sudo apk add dhcp

isprouter:~$ sudo rc-update add dhcpd
isprouter:~$ sudo rc-update add iptables

isprouter:~$ sudo rc-service iptables start
isprouter:~$ sudo rc-service iptables status

isprouter:~$ sudo rc-service dhcp status
```

`Lab 01 states that http://www.insecure.cyb should be available from isprouter. Following adjustments are necessary to make this happen (since the company network is not known by the NAT dns from VirtualBox which isprouter is using)`

```code
isprouter:~$ echo "172.30.0.10 www.insecure.cyb" | sudo tee -a /etc/hosts
172.30.0.10 www.insecure.cyb
isprouter:~$ cat /etc/hosts
127.0.0.1       localhost.my.domain localhost localhost.localdomain localhost
::1             localhost localhost.localdomain

127.0.0.1    alpine38 alpine38.localdomain
127.0.1.1 isprouter isprouter

172.30.0.10 www.insecure.cyb
```

## Lab 02: Lecture 2 Exercises







## Lab 03: Lecture 3 Exercises

## Lab 04: Lecture 4 Exercises

PS C:\data\git\ca> ssh -p22 vagrant@isprouter 'mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
vagrant@isprouter's password:
PS C:\data\git\ca> ssh -p22 vagrant@isprouter 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFI4Qm7YeH2CZQlKcmlpj2U0zpIYT74nRpiVfWnYy9p+vjChA0lF4lZ9XSGevq+ZVHWV3RBzpmcBS5i0XrZSGbEfh6zwsYpAy7K8ErIbSepdNJkBm1jMslGO3E5gabU2tP/+TUpyfrHuuV377IrwQ3XxPOjuCPj0WOwlcFgZovtLc0ZH39ns6O8K3SVYLkho2NdgMXi4gJAlQCOj99kjA+ZT5xhOJ832w2rJn7t8XfS+fgOwoNhErv9Mq6r8c7zyE3eYKkMfk0S24jFyC66fZSu7/LERC/F4ipGGc4MyB9ODu47CAE9knRA358nuB9x4lnklVYP7twPP0iOPrgqLEcYt6fakNaniHCJxmyokINys2NqtjZNDJEBkPBWvOPoRoM555GNIsVpnsJparVmFVoCtMGCUNnvyClRBI90To1t39LMhiN8oTshU0zbuErdkln2iHX4E8czQyfcYkSNtZ0x8FPWBQxzsc/t5UR6NDLHorZTBqbXS0gHH0oxJvVL58= benny.clemmens@student.hogent.be" >> ~/.ssh/authorized_keys'
vagrant@isprouter's password:
PS C:\data\git\ca> ssh isprouter
isprouter:~$


## Lab 05: Lecture 5 Exercises

## Lab 06: Lecture 6 No class - Catch-up

`Nothing to do`

## Lab 07: Lecture 7 BorgBackup

## Lab 08: Lecture 8 No class - Catch-up

`Nothing to do`

## Lab 09: Lecture 9 Wazuh

## Lab 10: Lecture 10 IPsec

## Lab 11: Lecture 11 - OpenVPN

## Lab 12: Lecture 12 - Hunting and hardening with ansible
