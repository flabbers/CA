# CSA - Lecture 1

## Preparation

### Network attacks

- Playlist: 5 videos about DNS - https://www.youtube.com/watch?v=r2VGOIXEsF8&list=PLEGgkEr0ifYuHzA5wJnAmAvFVZvoIXrj4
- Playlist: 5 videos about DDoS - https://www.youtube.com/watch?v=5_IDLpFqyUc&list=PLEGgkEr0ifYtTCTTly-_eMr6QwWLL0JDu

### DNS

- Learning dig - https://www.youtube.com/watch?v=iESSCDnC74k
- Learning nslookup - https://www.youtube.com/watch?v=jf-x76XYY2o
- DNS Zone transfer - https://www.youtube.com/watch?v=kdYnSfzb3UA & https://www.youtube.com/watch?v=6BJSqJtDq2Y
- Written blog: https://beaglesecurity.com/blog/vulnerability/dns-zone-transfer.html

### Capturing Traffic

- [packet capture tutorial using tcpdump](https://www.youtube.com/watch?v=KTvuyN1QGqs) BlueMonkey 4n6, 16'52"
- [Introduction to TCPDUMP](https://www.youtube.com/watch?v=hWc-ddF5g1I) David Mahler, 18'47"
- https://www.redhat.com/sysadmin/tcpdump-part-one

### Wireshark

- Intro wireshark (see course cybersecurity & virtualisation)
- Chris Greer has a nice collection of YouTube videos about wireshark - https://www.youtube.com/@ChrisGreer 
- Analyzing conversations - https://www.youtube.com/watch?v=IDaJZk_-muI
- Statistics - https://www.youtube.com/watch?v=ZNS115MPsO0 
- Protocol Hierarchy - https://www.youtube.com/watch?v=g5HKG5ihNTg

## During Lecture 1 Exercises

### DNS Zone transfer

- [Wikipedia: DNS zone transfer](https://en.wikipedia.org/wiki/DNS_zone_transfer)
- [ZoneTransfer.me](https://digi.ninja/projects/zonetransferme.php)

### Captures

- A collection of [sample captures](https://wiki.wireshark.org/SampleCaptures), sorted per protocol
- A collection of [sample captures](https://packetlife.net/captures/) on all kinds of protocols

## Cheat sheet

| command                                                  |    |
| :-                                                       | :- |
| $ tcpdump --version                                      | of tcpdump, libpcap, OpenSSL          |
| $ tcpdump                                                | Operation not permitted (sudo needed) |
| # tcpdump                                                | capture ALL traffic                   |
| # tcpdump -s 64                                          | capture first 64 bytes per frame      |
| # tcpdump -c 5                                           | capture 5 frames                      |
| # tcpdump -D                                             | numbered/names list of interfaces     |
| # tcpdump -i eth1                                        | capture only interface eth1           |
| # tcpdump -i eth1 -n                                     | don't lookup ptr records              |
| # tcpdump -i eth1 -vvv                                   | verbose (more per v)                  |
| # tcpdump -i eth1 -q                                     | minimum output                        |
| # tcpdump -i eth1 -K                                     | ignore TCP checksum errors            |
| # tcpdump -i eth1 host dc                                | filter on host (known in /etc/hosts)  |
| # tcpdump -i eth1 src host dc                            | filter by source host                 |
| # tcpdump -i eth1 dst host 172.30.0.4                    | filter by destination ip              |
| # tcpdump -i eth1 host 172.30.0.4 host 172.30.0.10       | between hosts                         |
| # tcpdump -i eth1 ether host 08:00:27:cc:a9:66           | filter by known mac-address           |
| # tcpdump -i eth1 net 10.0.2.4 mask 255.255.255.0        | filter range of ip's                  |
| # tcpdump -i eth1 dst net "10.0.2.0/24"                  | filter range with prefix between ""   |
| # tcpdump -i eth1 port 22                                | only show ssh traffic                 |
| # tcpdump -i eth1 src host 172.30.0.4 and port 22 -n     |   |
| # tcpdump -i eth1 src host 172.30.0.4 or port 22         |   |
| # tcpdump -i eth1 src host 172.30.0.4 and not port 22    |   |
| # tcpdump -i eth1 arp                                    |   |
| # tcpdump -i eth1 not icmp                               |   |
| # tcpdump -w /tmp/demo.pcap -c 5                         | write (binary) to file                |
| # tcpdump -w /tmp/demo.pcap -v                           | verbose show # of captures            |
| $ tcpdump -r /tmp/demo.pcap                              | read a capture file                   |
| $ tcpdump -r /tmp/demo.pcap -e                           | print mac-addresses                   |
| $ tcpdump -r /tmp/demo.pcap -A                           | payload in ASCIII                     |
| $ tcpdump -r /tmp/demo.pcap -XX                          | (full) hex/ascii style                |
| $ tcpdump -r /tmp/demo.pcap -c 3 -t                      | no timestamp                          |
| $ tcpdump -r /tmp/demo.pcap -c 3 -tt                     | linux timestamp                       |
| $ tcpdump -r /tmp/demo.pcap -c 3 -ttt                    | delta between timestamps              |
| $ tcpdump -r /tmp/demo.pcap -c 3 -tttt                   | date and timestamp                    |
| $ tcpdump -r /tmp/demo.pcap -c 3 -ttttt                  | time since first captured frame       |
| # tcpdump -i eth1 -n tcp and dst port 22 -t -S           | turn off relative seq numbers         |
| # tcpdump -i eth1 -n "host dc and (port 80 or port 443)" | to avoid bash interpretation          |

<!-- TODO

sudo tcpdump -i eth1 ip6 or arp or icmp
sudo tcpdump -i eth1 "tcp[tcpflags] & tcp-syn !=0"
sudo tcpdump -i eth1 "tcp[tcpflags] & tcp-rst !=0"
sudo tcpdump -i eth1 "tcp[tcpflags] & tcp-ack !=0"

ip -a | grep inet


## Cheatsheet

- man nslookup
- man host
- man dig
- dig axfr @nsztm1.digi.ninja zonetransfer.me
- TODO

## Links

-->


- $ dig axfr @nsztm1.digi.ninja zonetransfer.me


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

## To do list

- [caine forensics videoseries](https://www.youtube.com/watch?v=5S-oCypcyxc&list=PLSbhiuoC0XgUWuLUZ-hWOhcWFdthyugt-)
- [caine basic network commands](https://www.youtube.com/watch?v=xSEdv1S-A4E&list=PLSbhiuoC0XgXXJpFBzFvPd3AjPWmHTOPA)
