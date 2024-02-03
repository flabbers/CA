# CSA - Lecture 2

## Preparation

### Firewall (zones & network segmentation)

- https://documentation.axsguard.com/firewall/#essential-terminology


- https://documentation.axsguard.com/firewall/#firewall-zones
- Firewall zones - https://www.youtube.com/watch?v=dBKC6Q0dpdk
- DMZ (recap) - https://www.youtube.com/watch?v=8SY4bU7AQwE
- Firewalld cheatsheet - multi zone configurations - https://www.linuxjournal.com/content/understanding-firewalld-multi-zone-configurations
- Network segmentation (starting from minute 27) - https://www.youtube.com/watch?v=ExcQ25WRCH0&t=1620s
- Nmap recap - https://www.youtube.com/watch?v=T8ktppSHGww
  - Difference IP/ARP scan
  - Banner grab
  - Different type of port scans
- Nmap port results (open/filtered/closed) - https://nmap.org/book/man-port-scanning-basics.html

Capturing Traffic
Tcpdump tutorial - https://www.youtube.com/watch?v=KTvuyN1QGqs & https://www.youtube.com/watch?v=hWc-ddF5g1I
https://www.redhat.com/sysadmin/tcpdump-part-one 





### DNS Zone transfer

- Tijdens Lecture 1 Exercises: [Wikipedia: DNS zone transfer](https://en.wikipedia.org/wiki/DNS_zone_transfer)
- Tijdens Lecture 1 Exercises: [ZoneTransfer.me] https://digi.ninja/projects/zonetransferme.php


Capturing Traffic Tcpdump tutorial





dig axfr @nsztm1.digi.ninja zonetransfer.me


- <https://www.youtube.com/watch?v=kdYnSfzb3UA> 12'55"
  - zone transfer : copy dns database (zone file) from primary to secondary dns server
  - axfr record
  - zone file contains all defined dns names for that server
  - many misconfigured, zonefile can be transfered to unauthorized, secondary dns server (with host, nslookup, dig)
  - dns-recon
  - <zonetransfer.me>
- other source

```code
host -t ns zonetransfer.me
nost -l zonetransfer.me nsztm1.digi.ninja
```

```code
dig zonetransfer.me -t ns
dig axfr zonetransfer.me @nsztm1.digi.ninja
```

```code
nslookup
set type=ns
zonetransfer.me
server = nsztm1.digi.ninja
set type=any
ls -d zonetransfer.me
```

```code
dnsrecon -d zonetransfer.me -t axfr
```

### sth else


## Capturing Traffic

### Tcpdump tutorial

- <https://www.youtube.com/watch?v=KTvuyN1QGqs> 16'52"
- preinstalled on caine, kali, parrot or available at tcpdump.org
- sudo tcpdump
- sudo tcpdump -c 5
- ip -a | grep mtu
- sudo tcpdump -D > what ethernet devices tcpdump sees
- sudo tcpdump -i eth0
- filter by hostname, network, port number, range of ports, soirce, dest, ...
- sudo tcpdump -i eth0 host caine
- sudo tcpdump -i eth0 src host caine
- sudo tcpdump -i eth0 dst host 10.0.2.12
- sudo tcpdump -i eth0 ether host 00:00:00:00:00:00
- sudo tcpdump -i eth0 net 10.0.2.4 mask 255.255.255.252
- sudo tcpdump -i eth0 net 10.0.2.4 mask 255.255.255.252 -n
- sudo tcpdump -i eth0 port 22 -n
- sudo tcpdump -i eth0 src host 10.0.2.12 and port 22 -n
- sudo tcpdump -i eth0 src host 10.0.2.12 or port 22 -n
- sudo tcpdump -i eth0 src host 10.0.2.12 and not port 22 -n
- sudo tcpdump -i eth0 arp
- sudo tcpdump -i eth0 not icmp
- .... -w /tmp/demo.pcap -c 25
- tcpdump -r /tmp/demo.pcap
- tcpdump -r /tmp/demo.pcap -e (mac ipv ip)
- tcpdump -r /tmp/demo.pcap -c 1 -XX (hex/ascii)
- tcpdump -r /tmp/demo.pcap -c 3 -t (no timestamp)
- tcpdump -r /tmp/demo.pcap -c 3 -tt (linux timestamp)
- tcpdump -r /tmp/demo.pcap -c 3 -ttt (delta between timestamps)
- tcpdump -r /tmp/demo.pcap -c 3 -tttt (date and timestamp)
- also possible with wireshark :p
  - caine forensics videoseries: <https://www.youtube.com/watch?v=5S-oCypcyxc&list=PLSbhiuoC0XgUWuLUZ-hWOhcWFdthyugt->
  - caine basic network commands: <https://www.youtube.com/watch?v=xSEdv1S-A4E&list=PLSbhiuoC0XgXXJpFBzFvPd3AjPWmHTOPA>

- <https://www.youtube.com/watch?v=hWc-ddF5g1I> 18'47"
- 








# titel

TODO

## labo

TODO

## Cheatsheet

- \# apt install openssh-client
- $ ssh remoteuser@remoteip
- \# useradd -m -s /bin/bash localuser
- \# passwd localuser
- PermitRootLogin no in /etc/ssh/sshd_config
  - \# systemctl restart ssh
- $ ssh-keygen -t rsa
- $ cat ~/.ssh/
- $ ssh-copy-id remoteuser@remoteip
- PasswordAuthentication no in /etc/ssh/sshd_config
  - \# systemctl restart ssh
- \# visodu
  - \# nano /etc/sudoers
- \# usermod -aG sudo localuser
- \# passwd --lock root
  - \# passwd -l root
  - \# passwd -u root
- \# chsh root
  - \#nano /etc/passwd

## Resources

| wat | van | bron | tijd |
| :-  | :-  | :-   | :-   |
| Linux Security - SSH Security Essentials                      | Hackersploit | [youtube](https://www.youtube.com/watch?v=Ryu3SDPYNb8) | 00:25:05 |
| Linux Security - Configuring SUDO Access                      | Hackersploit | [youtube](https://www.youtube.com/watch?v=FGRtNvKdtbk) | 00:19:09 |
| Linux Security - Securing Apache2                             | Hackersploit | [youtube](https://www.youtube.com/watch?v=M1GpRWWRdC8) | 00:23:42 |
| Linux Security - Securing Nginx                               | Hackersploit | [youtube](https://www.youtube.com/watch?v=-lrSPJTeGhQ) | 00:20:59 |
| Linux Security - UFW Complete Guide (Uncomplicated Firewall)  | Hackersploit | [youtube](https://www.youtube.com/watch?v=-CzvPjZ9hp8) | 00:27:50 |
| Linux Security - SSH Brute Force Protection With Fail2Ban     | Hackersploit | [youtube](https://www.youtube.com/watch?v=Z0cDqF6HAxs) | 00:24:22 |
| iptables Complete Guide | HackerSploit Linux Security         | Hackersploit | [youtube](https://www.youtube.com/watch?v=6Ra17Qpj68c) | 00:31:01 |


Linux Monitoring and Logging | HackerSploit Linux Security https://www.youtube.com/watch?v=kZ5LhS6fThM&list=PLTnRtjQN5ieb3ljl02823yOnUax7sF1DD&index=3
