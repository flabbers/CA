# dc

## Lab 00: Lab environment Guidelines

`All virtual machines should be able to connect to each other`

```console
PS C:\Users\vagrant> ping 172.30.0.10 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\vagrant> ping 172.30.0.15 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\vagrant> ping 172.30.10.100 | select-string Packets

    Packets: Sent = 4, Received = 2, Lost = 2 (50% loss),


PS C:\Users\vagrant> ping 172.30.255.254 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\vagrant> ping 192.168.100.253 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\vagrant> ping 192.168.100.254 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
```

`Every virtual machine should have internet access`

```console
PS C:\Users\vagrant> ping 8.8.8.8 | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),


PS C:\Users\vagrant> ping www.google.be | select-string Packets

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
```

## Lab 01: Lecture 1 Exercises

`Connecting from companyrouter to have the benefits of ssh`

```code
[vagrant@companyrouter ~]$ ssh vagrant@172.30.0.4
vagrant@172.30.0.4's password:
Microsoft Windows [Version 10.0.20348.887]
(c) Microsoft Corporation. All rights reserved.

```

`Who else is here?`

```code
PS C:\Users\vagrant.insecure> Get-adUser -Filter * | Where-Object { $_.Enabled -eq $true } | Select-Object samaccountname, GivenName, Name

samaccountname GivenName Name
-------------- --------- ----
Administrator            Administrator
vagrant                  vagrant
walt           walt      Walt Disney
bdup           bdup      bdup
Aladdin        Aladdin   Aladdin
Jasmine        Jasmine   Jasmine
Genie          Genie     Genie
Jafar          Jafar     Jafar
Iago           Iago      Iago
Abu            Abu       Abu
Carpet         Carpet    Carpet
Sultan         Sultan    Sultan
Rajah          Rajah     Rajah
Simba          Simba     Simba
Nala           Nala      Nala
Timon          Timon     Timon
Pumbaa         Pumbaa    Pumbaa
Scar           Scar      Scar
Mufasa         Mufasa    Mufasa
Zazu           Zazu      Zazu
Rafiki         Rafiki    Rafiki
Sarabi         Sarabi    Sarabi
Sarafina       Sarafina  Sarafina
Shenzi         Shenzi    Shenzi
Banzai         Banzai    Banzai
Ed             Ed        Ed
Gopher         Gopher    Gopher
```

```code
insecure\vagrant@DC C:\Users\vagrant>ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : dc
   Primary Dns Suffix  . . . . . . . : insecure.cyb
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No
   DNS Suffix Search List. . . . . . : insecure.cyb

Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Intel(R) PRO/1000 MT Desktop Adapter
   Physical Address. . . . . . . . . : 08-00-27-CC-A9-66
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::b84c:9536:3ca6:f5eb%5(Preferred)
   IPv4 Address. . . . . . . . . . . : 172.30.0.4(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.0.0
   Default Gateway . . . . . . . . . : 172.30.255.254
   DHCPv6 IAID . . . . . . . . . . . : 101187623
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2C-D6-88-86-08-00-27-CC-A9-66
   DNS Servers . . . . . . . . . . . : ::1
                                       127.0.0.1
   NetBIOS over Tcpip. . . . . . . . : Enabled

PS C:\Users\vagrant> Get-DnsServerForwarder


UseRootHint        : True
Timeout(s)         : 3
EnableReordering   : True
IPAddress          : {10.0.2.3, 8.8.8.8}
ReorderedIPAddress : {10.0.2.3, 8.8.8.8}
```

`Some AD DS information`

```code
PS C:\Users\vagrant> Get-ADDomain


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=insecure,DC=cyb
DeletedObjectsContainer            : CN=Deleted Objects,DC=insecure,DC=cyb
DistinguishedName                  : DC=insecure,DC=cyb
DNSRoot                            : insecure.cyb
DomainControllersContainer         : OU=Domain Controllers,DC=insecure,DC=cyb
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-2681222979-3123228727-1689025860
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=insecure,DC=cyb
Forest                             : insecure.cyb
InfrastructureMaster               : dc.insecure.cyb
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=insecure,DC=cyb}
LostAndFoundContainer              : CN=LostAndFound,DC=insecure,DC=cyb
ManagedBy                          :
Name                               : insecure
NetBIOSName                        : insecure
ObjectClass                        : domainDNS
ObjectGUID                         : c63d9af2-e900-46dd-86ce-7733172b5dc6
ParentDomain                       :
PDCEmulator                        : dc.insecure.cyb
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=insecure,DC=cyb
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {dc.insecure.cyb}
RIDMaster                          : dc.insecure.cyb
SubordinateReferences              : {DC=ForestDnsZones,DC=insecure,DC=cyb, DC=DomainDnsZones,DC=insecure,DC=cyb, CN=Configuration,DC=insecure,DC=cyb}
SystemsContainer                   : CN=System,DC=insecure,DC=cyb
UsersContainer                     : CN=Users,DC=insecure,DC=cyb


PS C:\Users\vagrant> Get-ADDomainController


ComputerObjectDN           : CN=DC,OU=Domain Controllers,DC=insecure,DC=cyb
DefaultPartition           : DC=insecure,DC=cyb
Domain                     : insecure.cyb
Enabled                    : True
Forest                     : insecure.cyb
HostName                   : dc.insecure.cyb
InvocationId               : 70f83cc3-a996-4379-9a08-20906fa5709e
IPv4Address                : 172.30.0.4
IPv6Address                :
IsGlobalCatalog            : True
IsReadOnly                 : False
LdapPort                   : 389
Name                       : DC
NTDSSettingsObjectDN       : CN=NTDS Settings,CN=DC,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=insecure,DC=cyb
OperatingSystem            : Windows Server 2022 Standard Evaluation
OperatingSystemHotfix      :
OperatingSystemServicePack :
OperatingSystemVersion     : 10.0 (20348)
OperationMasterRoles       : {SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster...}
Partitions                 : {DC=ForestDnsZones,DC=insecure,DC=cyb, DC=DomainDnsZones,DC=insecure,DC=cyb, CN=Schema,CN=Configuration,DC=insecure,DC=cyb, CN=Configuration,DC=insecure,DC=cyb...}
ServerObjectDN             : CN=DC,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=insecure,DC=cyb
ServerObjectGuid           : 1985b9ae-38e5-4356-aed1-18862b6b3dde
Site                       : Default-First-Site-Name
SslPort                    : 636


PS C:\Users\vagrant> Get-ADComputer -Filter *


DistinguishedName : CN=DC,OU=Domain Controllers,DC=insecure,DC=cyb
DNSHostName       : dc.insecure.cyb
Enabled           : True
Name              : DC
ObjectClass       : computer
ObjectGUID        : dec3b65f-6c7f-4e00-9c02-7e60103349f1
SamAccountName    : DC$
SID               : S-1-5-21-2681222979-3123228727-1689025860-1001
UserPrincipalName :

DistinguishedName : CN=WIN10,CN=Computers,DC=insecure,DC=cyb
DNSHostName       : win10.insecure.cyb
Enabled           : True
Name              : WIN10
ObjectClass       : computer
ObjectGUID        : 0902c079-a387-4fc1-852b-f23c0939c289
SamAccountName    : WIN10$
SID               : S-1-5-21-2681222979-3123228727-1689025860-1104
UserPrincipalName :
```

`Is the dc vulnerable for a zone transfer attack?`

```code
PS C:\Users\vagrant> Get-DnsServerZone | Where-Object {$_.ZoneName -eq "insecure.cyb"} | Select-Object ZoneName, ZoneType, SecondaryServers, SecureSecondaries

ZoneName     ZoneType SecondaryServers SecureSecondaries
--------     -------- ---------------- -----------------
insecure.cyb Primary                   TransferAnyServer

```

`How to fix this?`

```code
PS C:\Users\vagrant> Set-DnsServerPrimaryZone -Name "insecure.cyb" -SecureSecondaries NoTransfer
PS C:\Users\vagrant> Get-DnsServerZone | Where-Object {$_.ZoneName -eq "insecure.cyb"} | Select-Object ZoneName, ZoneType, SecondaryServers, SecureSecondaries

ZoneName     ZoneType SecondaryServers SecureSecondaries
--------     -------- ---------------- -----------------
insecure.cyb Primary                   NoTransfer
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
