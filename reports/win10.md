# win10

## Lab 00: Lab environment Guidelines

`All virtual machines should be able to connect to each other`

```code
PS C:\Users\Walt> ping 172.30.0.4 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\Walt> ping 172.30.0.10 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\Walt> ping 172.30.0.15 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\Walt> ping 172.30.255.254 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\Walt> ping 192.168.100.253 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\Walt> ping 192.168.100.254 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
```

`Keep in mind that the route for 172.30.0.0/16 was allready added to the isprouter before performing these pings`

`Every virtual machine should have internet access`

```console
PS C:\Users\Walt> ping 8.8.8.8 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\Walt> ping www.google.be | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
```

## Lab 01: Lecture 1 Exercises

`Using the VirtualBox GUI with shared clipboard as vagrant/vagrant`

```code
C:\Users\vagrant.insecure>ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : win10
   Primary Dns Suffix  . . . . . . . : insecure.cyb
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No
   DNS Suffix Search List. . . . . . : insecure.cyb

Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . : insecure.cyb
   Description . . . . . . . . . . . : Intel(R) PRO/1000 MT Desktop Adapter
   Physical Address. . . . . . . . . : 08-00-27-B3-9D-75
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   IPv4 Address. . . . . . . . . . . : 172.30.10.100(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.0.0
   Lease Obtained. . . . . . . . . . : Tuesday, November 28, 2023 6:28:15 PM
   Lease Expires . . . . . . . . . . : Tuesday, November 28, 2023 11:33:11 PM
   Default Gateway . . . . . . . . . : 172.30.255.254
   DHCP Server . . . . . . . . . . . : 172.30.255.254
   DNS Servers . . . . . . . . . . . : 172.30.0.4
   NetBIOS over Tcpip. . . . . . . . : Enabled

Ethernet adapter Npcap Loopback Adapter:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Npcap Loopback Adapter
   Physical Address. . . . . . . . . : 02-00-4C-4F-4F-50
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::b4c2:9d41:de52:e803%7(Preferred)
   Autoconfiguration IPv4 Address. . : 169.254.232.3(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.0.0
   Default Gateway . . . . . . . . . :
   DHCPv6 IAID . . . . . . . . . . . : 184680524
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2C-D6-88-D1-08-00-27-B3-9D-75
   DNS Servers . . . . . . . . . . . : fec0:0:0:ffff::1%1
                                       fec0:0:0:ffff::2%1
                                       fec0:0:0:ffff::3%1
   NetBIOS over Tcpip. . . . . . . . : Enabled
```

`Who else is here?`

```code
PS C:\Users\vagrant.insecure> Get-LocalUser | Where-Object { $_.Enabled -eq $true } | Select-Object Name,FullName,Description

Name    FullName Description
----    -------- -----------
vagrant Vagrant  Vagrant
```

`Connectivity for win10 was allready checked in Lab 00. Dns is working too`

```code
C:\Users\Walt>ping dc

Pinging dc.insecure.cyb [172.30.0.4] with 32 bytes of data:
Reply from 172.30.0.4: bytes=32 time<1ms TTL=128
Reply from 172.30.0.4: bytes=32 time<1ms TTL=128
Reply from 172.30.0.4: bytes=32 time=1ms TTL=128
Reply from 172.30.0.4: bytes=32 time=1ms TTL=128

Ping statistics for 172.30.0.4:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms
```

## Lab 02: Lecture 2 Exercises

## Lab 03: Lecture 3 Exercises

## Lab 04: Lecture 4 Exercises

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
