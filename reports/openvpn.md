# OpenVPN

```code
[walt@companyrouter ~]$ sudo dnf provides easyrsa
Last metadata expiration check: 13:57:11 ago on Mon Jan  8 18:11:08 2024.
Error: No matches found. If searching for a file, try specifying the full path or using a wildcard prefix ("*/") at the beginning.
[walt@companyrouter ~]$ sudo dnf provides */easyrsa
Last metadata expiration check: 13:57:23 ago on Mon Jan  8 18:11:08 2024.
easy-rsa-3.1.6-1.el9.noarch : Simple shell based CA utility
Repo        : epel
Matched from:
Filename    : /usr/share/easy-rsa/3.1.6/easyrsa

[walt@companyrouter ~]$ sudo dnf provides easy-rsa
Last metadata expiration check: 0:04:12 ago on Tue Jan  9 08:11:46 2024.
easy-rsa-3.1.6-1.el9.noarch : Simple shell based CA utility
Repo        : epel
Matched from:
Provide    : easy-rsa = 3.1.6-1.el9

[walt@companyrouter ~]$ dnf search easy-rsa
Copr repo for suricata-6.0 owned by @oisf                                                                                                                                         13 kB/s |  11 kB     00:00
AlmaLinux 9 - AppStream                                                                                                                                                          4.4 MB/s | 8.1 MB     00:01
AlmaLinux 9 - BaseOS                                                                                                                                                             3.5 MB/s | 3.5 MB     00:00
AlmaLinux 9 - Extras                                                                                                                                                              21 kB/s |  17 kB     00:00
Docker CE Stable - x86_64                                                                                                                                                        115 kB/s |  33 kB     00:00
Extra Packages for Enterprise Linux 9 - x86_64                                                                                                                                   9.6 MB/s |  20 MB     00:02
Extra Packages for Enterprise Linux 9 openh264 (From Cisco) - x86_64                                                                                                             2.2 kB/s | 2.5 kB     00:01
EL-\9 - Wazuh                                                                                                                                                                    9.5 MB/s |  25 MB     00:02
======================================================================================== Name Exactly Matched: easy-rsa =========================================================================================
easy-rsa.noarch : Simple shell based CA utility
[walt@companyrouter ~]$

[walt@companyrouter ~]$ sudo dnf repoquery -i easy-rsa
Last metadata expiration check: 0:19:58 ago on Tue Jan  9 08:11:46 2024.
Name         : easy-rsa
Version      : 3.1.6
Release      : 1.el9
Architecture : noarch
Size         : 67 k
Source       : easy-rsa-3.1.6-1.el9.src.rpm
Repository   : epel
Summary      : Simple shell based CA utility
URL          : https://github.com/OpenVPN/easy-rsa
License      : GPL-2.0-only
Description  : This is a small RSA key management package, based on the openssl
             : command line tool, that can be found in the easy-rsa subdirectory
             : of the OpenVPN distribution. While this tool is primary concerned
             : with key management for the SSL VPN application space, it can also
             : be used for building web certificates.


[walt@companyrouter ~]$ sudo dnf repoquery -l easy-rsa
Last metadata expiration check: 0:21:11 ago on Tue Jan  9 08:11:46 2024.
/usr/share/doc/easy-rsa
/usr/share/doc/easy-rsa/COPYING.md
/usr/share/doc/easy-rsa/ChangeLog
/usr/share/doc/easy-rsa/README.md
/usr/share/doc/easy-rsa/README.quickstart.md
/usr/share/doc/easy-rsa/vars.example
/usr/share/easy-rsa
/usr/share/easy-rsa/3
/usr/share/easy-rsa/3.0
/usr/share/easy-rsa/3.1.6
/usr/share/easy-rsa/3.1.6/easyrsa
/usr/share/easy-rsa/3.1.6/openssl-easyrsa.cnf
/usr/share/easy-rsa/3.1.6/x509-types
/usr/share/easy-rsa/3.1.6/x509-types/COMMON
/usr/share/easy-rsa/3.1.6/x509-types/ca
/usr/share/easy-rsa/3.1.6/x509-types/client
/usr/share/easy-rsa/3.1.6/x509-types/code-signing
/usr/share/easy-rsa/3.1.6/x509-types/email
/usr/share/easy-rsa/3.1.6/x509-types/kdc
/usr/share/easy-rsa/3.1.6/x509-types/server
/usr/share/easy-rsa/3.1.6/x509-types/serverClient
/usr/share/licenses/easy-rsa
/usr/share/licenses/easy-rsa/COPYING.md
/usr/share/licenses/easy-rsa/gpl-2.0.txt



[walt@companyrouter ~]$ sudo dnf repoquery -i openvpn
Last metadata expiration check: 0:24:37 ago on Tue Jan  9 08:11:46 2024.
Name         : openvpn
Version      : 2.5.9
Release      : 2.el9
Architecture : x86_64
Size         : 653 k
Source       : openvpn-2.5.9-2.el9.src.rpm
Repository   : epel
Summary      : A full-featured TLS VPN solution
URL          : https://community.openvpn.net/
License      : GPLv2
Description  : OpenVPN is a robust and highly flexible tunneling application that uses all
             : of the encryption, authentication, and certification features of the
             : OpenSSL library to securely tunnel IP networks over a single UDP or TCP
             : port.  It can use the Marcus Franz Xaver Johannes Oberhumers LZO library
             : for compression.

[walt@companyrouter ~]$ sudo dnf install -yq openvpn easy-rsa

Installed:
  easy-rsa-3.1.6-1.el9.noarch                                        openvpn-2.5.9-2.el9.x86_64                                        pkcs11-helper-1.27.0-6.el9.x86_64

[walt@companyrouter ~]$



[walt@companyrouter ~]$ openvpn --version
OpenVPN 2.5.9 x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Nov  9 2023
library versions: OpenSSL 3.0.7 1 Nov 2022, LZO 2.10
Originally developed by James Yonan
Copyright (C) 2002-2022 OpenVPN Inc <sales@openvpn.net>
Compile time defines: enable_async_push=yes enable_comp_stub=no enable_crypto_ofb_cfb=yes enable_debug=yes enable_def_auth=yes enable_dependency_tracking=no enable_dlopen=unknown enable_dlopen_self=unknown enable_dlopen_self_static=unknown enable_fast_install=yes enable_fragment=yes enable_iproute2=no enable_libtool_lock=yes enable_lz4=yes enable_lzo=yes enable_management=yes enable_multihome=yes enable_pam_dlopen=no enable_pedantic=no enable_pf=yes enable_pkcs11=yes enable_plugin_auth_pam=yes enable_plugin_down_root=yes enable_plugins=yes enable_port_share=yes enable_selinux=yes enable_shared=yes enable_shared_with_static_runtimes=no enable_silent_rules=yes enable_small=no enable_static=yes enable_strict=no enable_strict_options=no enable_systemd=yes enable_werror=no enable_win32_dll=yes enable_x509_alt_username=yes with_aix_soname=aix with_crypto_library=openssl with_gnu_ld=yes with_mem_check=no with_openssl_engine=auto with_sysroot=no
[walt@companyrouter bin]$ echo ln -s /usr/share/easy-rsa/3/easyrsa ~/.local/bin/
ln -s /usr/share/easy-rsa/3/easyrsa /home/walt/.local/bin/
[walt@companyrouter bin]$ cd
[walt@companyrouter ~]$ ln -s /usr/share/easy-rsa/3/easyrsa ~/.local/bin/
[walt@companyrouter ~]$ easyrsa --version
EasyRSA Version Information
Version:     3.1.6
Generated:   Fri Aug 18 09:28:23 CDT 2023
SSL Lib:     OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
Git Commit:  9850ced8bec5e0a065d9c576f59c3f372f82f4a9
Source Repo: https://github.com/OpenVPN/easy-rsa

[walt@companyrouter ~]$

[walt@companyrouter ~]$ mkdir -p openvpn
[walt@companyrouter ~]$ cd openvpn/

[walt@companyrouter openvpn]$ easyrsa init-pki

Notice
------
'init-pki' complete; you may now create a CA or requests.

Your newly created PKI dir is:
* /home/walt/openvpn/pki

Using Easy-RSA configuration:
* /home/walt/openvpn/pki/vars

IMPORTANT:
  Easy-RSA 'vars' template file has been created in your new PKI.
  Edit this 'vars' file to customise the settings for your PKI.
  To use a global vars file, use global option --vars=<FILE>

[walt@companyrouter openvpn]$


[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── inline
    ├── openssl-easyrsa.cnf
    ├── private
    ├── reqs
    ├── vars
    └── vars.example

4 directories, 3 files
[walt@companyrouter openvpn]$

```

When building a CA, a number of new files are created by a combination of Easy-RSA and (indirectly) openssl. The important CA files are:

- ca.crt - This is the CA certificate
- index.txt - This is the "master database" of all issued certs
- serial - Stores the next serial number (serial numbers increment)
- private/ca.key - This is the CA private key (security-critical)
- certs_by_serial/ - dir with all CA-signed certs by serial number
- issued/ - dir with issued certs by commonName

```code
[walt@companyrouter openvpn]$ easyrsa build-ca
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)

Enter New CA Key Passphrase:

Confirm New CA Key Passphrase:
.....+.+...+..+.........+.+.....+.+........+.......+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+...+......+.........+......+......+...+..+............+.+......+.....+...+.+.........+...+............+........+...+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+....+..+....+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.+...............+..+.......+...+..+......+.........+.+.....+.+.....+.+...+.....+....+...+........+.+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+..+..........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*......+..+...............+...+.+......+...+......+...........+....+.....+.+......+...+...........+................+...+..+...+......+...+.......+..................+...+..+......+.......+..+......+.........+.+.....+......+.+.........+.....+......+.......+........+.......+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [Easy-RSA CA]:companyCA

Notice
------
CA creation complete. Your new CA certificate is at:
* /home/walt/openvpn/pki/ca.crt

[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── ca.crt
    ├── certs_by_serial
    ├── index.txt
    ├── index.txt.attr
    ├── inline
    ├── issued
    ├── openssl-easyrsa.cnf
    ├── private
    │   └── ca.key
    ├── reqs
    ├── revoked
    │   ├── certs_by_serial
    │   ├── private_by_serial
    │   └── reqs_by_serial
    ├── serial
    ├── vars
    └── vars.example

10 directories, 8 files
[walt@companyrouter openvpn]
```

`Passphrase: admin`

```code
[walt@companyrouter openvpn]$ easyrsa gen-req CompanyServer
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.....+......+.........+...+..+...+...+......+.+.........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+........+.......+...+..+.+..+............+......+.........+...+...+...+....+......+...........+.+..+...+....+.........+......+.........+.....+.+....................+.+.................+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+..+......+....+......+..+.+......+..............+......+....+......+...+..+......+...+.+...+........+..........+...+......+.....+....+..+...+.......+.....+...+......+...+.+...............+.....+.+.....+.+..+............+.+..............+.+.........+...........+...+.........+...+.........+...+.......+......+..+...+...+.+........+......+......+.............+......+..+.........+....+.....+.......+...+.....+................+......+..+.......+...+.....+.......+.....+..................+...+....+.........+..+....+...+............+...+..+.+........+......+....+..+...+....+...........+....+........+...+.........+...+.......+...........+.........+......+....+......+.....+.+.....+.+............+.....+...+.......+...+...+..+.........+.+...+..+....+.....+...+.+...............+.........+...+....................+.........+......+...+....+......+.........+..+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [CompanyServer]:CompanyServer

Notice
------
Private-Key and Public-Certificate-Request files created.
Your files are:
* req: /home/walt/openvpn/pki/reqs/CompanyServer.req
* key: /home/walt/openvpn/pki/private/CompanyServer.key

[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── ca.crt
    ├── certs_by_serial
    ├── index.txt
    ├── index.txt.attr
    ├── inline
    ├── issued
    ├── openssl-easyrsa.cnf
    ├── private
    │   ├── CompanyServer.key
    │   └── ca.key
    ├── reqs
    │   └── CompanyServer.req
    ├── revoked
    │   ├── certs_by_serial
    │   ├── private_by_serial
    │   └── reqs_by_serial
    ├── serial
    ├── vars
    └── vars.example

10 directories, 10 files
```

`Passphrase: server`


`niet nodig:`
```code
[walt@companyrouter openvpn]$ easyrsa import-req pki/reqs/CompanyServer.req CompanyServerReq
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)

Notice
------
Request successfully imported with short-name: CompanyServerReq
This request is now ready to be signed.
```

```code
[walt@companyrouter openvpn]$ easyrsa sign-req server CompanyServer
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
You are about to sign the following certificate:
Please check over the details shown below for accuracy. Note that this request
has not been cryptographically verified. Please be sure it came from a trusted
source or that you have verified the request checksum with the sender.
Request subject, to be signed as a server certificate
for '825' days:

subject=
    commonName                = CompanyServer

Type the word 'yes' to continue, or any other input to abort.
  Confirm request details: yes

Using configuration from /home/walt/openvpn/pki/openssl-easyrsa.cnf
Enter pass phrase for /home/walt/openvpn/pki/private/ca.key:
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
commonName            :ASN.1 12:'CompanyServer'
Certificate is to be certified until Apr 13 09:14:32 2026 GMT (825 days)

Write out database with 1 new entries
Data Base Updated

Notice
------
Certificate created at:
* /home/walt/openvpn/pki/issued/CompanyServer.crt

[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── ca.crt
    ├── certs_by_serial
    │   └── 86B4F4613222BA428284B73A886ECEC0.pem
    ├── index.txt
    ├── index.txt.attr
    ├── index.txt.attr.old
    ├── index.txt.old
    ├── inline
    ├── issued
    │   └── CompanyServer.crt
    ├── openssl-easyrsa.cnf
    ├── private
    │   ├── CompanyServer.key
    │   └── ca.key
    ├── reqs
    │   └── CompanyServer.req
    ├── revoked
    │   ├── certs_by_serial
    │   ├── private_by_serial
    │   └── reqs_by_serial
    ├── serial
    ├── serial.old
    ├── vars
    └── vars.example

10 directories, 15 files
[walt@companyrouter openvpn]$
```

```code
[walt@companyrouter openvpn]$ sudo openssl verify -CAfile pki/ca.crt  pki/issued/CompanyServer.crt
pki/issued/CompanyServer.crt: OK
```


```code
[walt@companyrouter openvpn]$ easyrsa gen-req HomeClient
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
..+....+.....+.+.........+..+....+......+..................+...........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+.+..+............+...+.+.........+............+...+..+.+........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.....+.+..+.......+...+..+.......+.....+...+......+.+...+...+.........+...+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
..+..+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+..+...+......+.+......+...+.....+.+...+..+.+.....+...+....+...+.....+.............+..+..................+.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*......+....+...+.................+...+.+......+.....+......+..........+..+.......+...+.....+............+....+..+...+.+.....+..........+...+...+...+...........+...+.+...............+..+.............+............+........+............+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [HomeClient]:HomeClient

Notice
------
Private-Key and Public-Certificate-Request files created.
Your files are:
* req: /home/walt/openvpn/pki/reqs/HomeClient.req
* key: /home/walt/openvpn/pki/private/HomeClient.key

[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── ca.crt
    ├── certs_by_serial
    │   └── 86B4F4613222BA428284B73A886ECEC0.pem
    ├── index.txt
    ├── index.txt.attr
    ├── index.txt.attr.old
    ├── index.txt.old
    ├── inline
    ├── issued
    │   └── CompanyServer.crt
    ├── openssl-easyrsa.cnf
    ├── private
    │   ├── CompanyServer.key
    │   ├── HomeClient.key
    │   └── ca.key
    ├── reqs
    │   ├── CompanyServer.req
    │   └── HomeClient.req
    ├── revoked
    │   ├── certs_by_serial
    │   ├── private_by_serial
    │   └── reqs_by_serial
    ├── serial
    ├── serial.old
    ├── vars
    └── vars.example

10 directories, 17 files
```

`Passphrase: client`

```code
[walt@companyrouter openvpn]$ easyrsa sign-req client HomeClient
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
You are about to sign the following certificate:
Please check over the details shown below for accuracy. Note that this request
has not been cryptographically verified. Please be sure it came from a trusted
source or that you have verified the request checksum with the sender.
Request subject, to be signed as a client certificate
for '825' days:

subject=
    commonName                = HomeClient

Type the word 'yes' to continue, or any other input to abort.
  Confirm request details: yes

Using configuration from /home/walt/openvpn/pki/openssl-easyrsa.cnf
Enter pass phrase for /home/walt/openvpn/pki/private/ca.key:
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
commonName            :ASN.1 12:'HomeClient'
Certificate is to be certified until Apr 13 09:29:02 2026 GMT (825 days)

Write out database with 1 new entries
Data Base Updated

Notice
------
Certificate created at:
* /home/walt/openvpn/pki/issued/HomeClient.crt

[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── ca.crt
    ├── certs_by_serial
    │   ├── 86B4F4613222BA428284B73A886ECEC0.pem
    │   └── D63F31C958EAD88BF796F0F233BBFBA7.pem
    ├── index.txt
    ├── index.txt.attr
    ├── index.txt.attr.old
    ├── index.txt.old
    ├── inline
    ├── issued
    │   ├── CompanyServer.crt
    │   └── HomeClient.crt
    ├── openssl-easyrsa.cnf
    ├── private
    │   ├── CompanyServer.key
    │   ├── HomeClient.key
    │   └── ca.key
    ├── reqs
    │   ├── CompanyServer.req
    │   └── HomeClient.req
    ├── revoked
    │   ├── certs_by_serial
    │   ├── private_by_serial
    │   └── reqs_by_serial
    ├── serial
    ├── serial.old
    ├── vars
    └── vars.example

10 directories, 19 files
[walt@companyrouter openvpn]$ sudo openssl verify -CAfile pki/ca.crt  pki/issued/HomeClient.crt
pki/issued/HomeClient.crt: OK
```


```code
[walt@companyrouter openvpn]$ easyrsa help gen-dh

* gen-dh

      Generates DH (Diffie-Hellman) parameters file

Available command options [ cmd-opts ]:

      * No supported command options

[walt@companyrouter openvpn]$ easyrsa gen-dh
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
Generating DH parameters, 2048 bit long safe prime
...................................................................................+.......................................................................................+.........................................................+...........................................+....................................+............................................................................+..............................................+.....................................................................................+.................................................................................................................................................................+...............................................................................................................................................+.........................................+............................................................................................................................................................................................................................................................................................................................................+...........................................................................+...............................................................+....+.......................+...............................................+.............+.............................................................................................................................................................+...........................................................................................................................................................................+......+............................................................................................+...............................................+............................................................................................................................+.....................................................................................................................................................+...........................................................................+.................................................................................................................................+......................................................+.....+.....................................................................................................................+.......................................................................+.................................................................................................................................+.........................+...................................+......................................................................................................................................+..............................................................................+................................................................................................................+........+.............................................................................................................................................+..............................+.........................................................................................................................................................................+...........................................................................+.......................................................................+....+........................................................+.................................................................................................................................................................................................................+......................................................................................................+.....................................................................+............................................................................................................................................................................+..................................................................................................................+...........................+...+.............................+.................................................................................................................................................................................................................................................................................................................+..................................................+.........................................................................................+...............................................................................................................................................................................................................................................................................+.........................+.................................................................................................................................................................................................................+................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..............................................+...................................................+................................................................................................................................................................+.........................................+...................+........................+...........................................................................................................................................................+..........................................................................................................................................................................................................................................................................................+.....................................................................................................................................................................................................................................................................................+............+......................................................................................................................................................................................................................................................+..........................................+................+.........................................................................................................+...................................................+..+.......................+........................................................................................................................................................................................................................................................................................................................................+...................................................................................................................................+.........+.............+...........................+.......................................+..................................................................................................................................................................................................+............................................................................................................+.....................................................................................................................+......................................................................................................................................................................................................+..+.........................................................................................................................................................................................................................................................................+...................................................................+.......................................................+..................................+.....................................................................................................................................................................+..........+......................................................................................................................................................................................................+...........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+...........................................................................................................................................................................................................................................................................................................................................+.....................+................................+...............+.........................+......................................................................................................................+...........................................................................................................................+..................................................................................................................................................+........................................+...................................................................+....................................................+.....................+.................................................+............................................................................................................................................................................................................................+....................................................................+................................................+.........+........................................................................................................................................................................................+.......................................................+............+..................................................................................................................................................................................................................................+.........................................................................................................................+.........................................................+........................+.......................................+........+.....................+..................................................................................................................................................................................................................................+.............................................................................................................................................................+.....................................................................................................................................................................+...................................+.....................................................................................................................................................................+.......................................................................................................................................................................................+........................+...................................................................................................+..................................................+..............................................................................................................................................+............................................................................................................................................................................................................................................................+........+..................+.......+................................................................+......................+........+......+.........................................................................................................................................................................................+.....................................................................................................+.............................................................................................................+.............+........................................................+............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+.....................................................................+....................................................................................+......................................................................................................................................................................................................................................+...........................................................+......................................+.........+........................................................................................................................................................................+...........................................+....................................................................................................................................+.............................................................................................+................................................................................................................................................................................................................................................+..................................................................................................................................+...+...........+................................................................................................................................................................+...................................................................+.....................................................................................................................................................................................+.................................................................+.................................................................................................................................+..................................+..........................................................................................................+........................................+.........................................................................................................................................................................................................+......................................................................................+.................................................+................................................................................................................................................................................................+................+......................................................................................+...................................................................................................+...............................+...................................................................................................................+.....................+.................................................................................................................+......................................................+......................................................................................................................................................................+..+...........................+..........+...................................................................................................................+.......+..........................................................................................+.......................................................................................................................+........................................................+................................................................................+..................+...............................+...............................+.......................................................................................+..........................................................................+...................................................................................+....................................................................................................+......................................................................................................................................................+........................................................................................+..........................................................................................................................................................+........................................................................................................+...................................................................................................................................................................................................+..............+......................................................................................................+..............................................................................+..............+................................................................................................................................................+..................................................+................................................................................................................................................+...................................................................................................................................................................................................................................................................................................................+................................................................................................+..........+............................................+.......................................................................+.....................................................................................................................................................................................................................................................................................................................+......................................................................................................................................................+.............................................................................+............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+...........................................................................................................................................................................+...........................................................................................................+...........................+..............................................................................+.......+........................................................................................................................................................................................................................................................................................................................................+...................................................+.....................+.......+................................+....................................................................+..................+................+................................+.........................................................................................................................................................................................................................................+.........................+.......................................+................................................................................................................................................................................................................................................................................................................+.......+..................................................................................................................................................+....................................................................+.................................................................................................................................................................................+.....................................................................................+.........................................................................................................................................................................................................................................+.........................+....+......................++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*
DH parameters appear to be ok.

Notice
------

DH parameters of size 2048 created at:
* /home/walt/openvpn/pki/dh.pem

[walt@companyrouter openvpn]$ tree
.
└── pki
    ├── ca.crt
    ├── certs_by_serial
    │   ├── 86B4F4613222BA428284B73A886ECEC0.pem
    │   └── D63F31C958EAD88BF796F0F233BBFBA7.pem
    ├── dh.pem
    ├── index.txt
    ├── index.txt.attr
    ├── index.txt.attr.old
    ├── index.txt.old
    ├── inline
    ├── issued
    │   ├── CompanyServer.crt
    │   └── HomeClient.crt
    ├── openssl-easyrsa.cnf
    ├── private
    │   ├── CompanyServer.key
    │   ├── HomeClient.key
    │   └── ca.key
    ├── reqs
    │   ├── CompanyServer.req
    │   └── HomeClient.req
    ├── revoked
    │   ├── certs_by_serial
    │   ├── private_by_serial
    │   └── reqs_by_serial
    ├── serial
    ├── serial.old
    ├── vars
    └── vars.example

10 directories, 20 files
[walt@companyrouter openvpn]$ diff pki/certs_by_serial/86B4F4613222BA428284B73A886ECEC0.pem pki/issued/CompanyServer.crt
```


```code
[walt@companyrouter ~]$ ls -al /usr/share/doc/openvpn/sample/sample-config-files/
total 84
drwxr-xr-x. 2 root root  4096 Jan  9 08:37 .
drwxr-xr-x. 5 root root    77 Jan  9 08:37 ..
-rw-r--r--. 1 root root   131 Feb 14  2023 README
-rw-r--r--. 1 root root  3589 Feb 14  2023 client.conf
-rw-r--r--. 1 root root  3562 Feb 14  2023 firewall.sh
-rw-r--r--. 1 root root    62 Feb 14  2023 home.up
-rw-r--r--. 1 root root 11386 Feb 14  2023 loopback-client
-rw-r--r--. 1 root root   694 Feb 14  2023 loopback-server
-rw-r--r--. 1 root root    62 Feb 14  2023 office.up
-rw-r--r--. 1 root root    63 Feb 14  2023 openvpn-shutdown.sh
-rw-r--r--. 1 root root   776 Feb 14  2023 openvpn-startup.sh
-rw-r--r--. 1 root root   820 Nov 10 00:02 roadwarrior-client.conf
-rw-r--r--. 1 root root  1498 Nov 10 00:02 roadwarrior-server.conf
-rw-r--r--. 1 root root 10784 Feb 14  2023 server.conf
-rw-r--r--. 1 root root  1990 Feb 14  2023 tls-home.conf
-rw-r--r--. 1 root root  2019 Feb 14  2023 tls-office.conf
-rw-r--r--. 1 root root   199 Feb 14  2023 xinetd-client-config
-rw-r--r--. 1 root root   989 Feb 14  2023 xinetd-server-config
[walt@companyrouter ~]$ sudo cp /usr/share/doc/openvpn/sample/sample-config-files/server.conf /etc/openvpn/server/
[walt@companyrouter ~]$ sudo cp ~/openvpn/pki/ca.crt /etc/openvpn/server
[walt@companyrouter ~]$ sudo cp ~/openvpn/pki/dh.pem /etc/openvpn/server
[walt@companyrouter ~]$ sudo cp ~/openvpn/pki/issued/CompanyServer.crt /etc/openvpn/server
[walt@companyrouter ~]$ sudo cp ~/openvpn/pki/private/CompanyServer.key /etc/openvpn/server
[walt@companyrouter ~]$ sudo nano /etc/openvpn/server/server.conf
[walt@companyrouter ~]$ sudo cat /etc/openvpn/server/server.conf | grep -v -E "^$|#|;"
local 192.168.100.253
port 1194
proto udp
dev tun
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/CompanyServer.crt
dh /etc/openvpn/server/dh.pem
server 172.30.124.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "route 172.30.0.0 255.255.0.0"
keepalive 10 120
cipher AES-256-CBC
persist-key
persist-tun
status openvpn-status.log
log-append openvpn.log
verb 4
explicit-exit-notify 1
```


[walt@companyrouter ~]$ sudo cat openvpn.log
2024-01-09 10:49:25 us=84488 WARNING: --topology net30 support for server configs with IPv4 pools will be removed in a future release. Please migrate to --topology subnet as soon as possible.
2024-01-09 10:49:25 us=84513 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC' to --data-ciphers or change --cipher 'AES-256-CBC' to --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
2024-01-09 10:49:25 us=85166 WARNING: cannot stat file '/etc/openvpn/CompanyServer.key': No such file or directory (errno=2)
Options error: --key fails with '/etc/openvpn/CompanyServer.key': No such file or directory (errno=2)
Options error: Please correct these errors.
Use --help for more information.
2024-01-09 10:57:28 us=224159 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC' to --data-ciphers or change --cipher 'AES-256-CBC' to --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
Options error: You must define CA file (--ca) or CA path (--capath)
Use --help for more information.
2024-01-09 10:59:19 us=747944 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC' to --data-ciphers or change --cipher 'AES-256-CBC' to --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
Options error: You must define CA file (--ca) or CA path (--capath)


[walt@companyrouter ~]$ sudo nano /etc/openvpn/server/server.conf


[walt@companyrouter ~]$ sudo cat /etc/openvpn/server/server.conf | grep -v -E "^$|#|;"
local 192.168.100.253
port 1194
proto udp
dev tun
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/CompanyServer.crt
key /etc/openvpn/server/CompanyServer.key
dh /etc/openvpn/server/dh.pem
topology subnet
server 172.30.124.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "route 172.30.0.0 255.255.0.0"
keepalive 10 120
persist-key
persist-tun
status openvpn-status.log
log-append openvpn.log
verb 4
explicit-exit-notify 1
[walt@companyrouter ~]$





[walt@companyrouter ~]$ sudo openvpn /etc/openvpn/server/server.conf
🔐 Enter Private Key Password: ******
[walt@companyrouter ~]$ sudo ss -ulnp
State             Recv-Q             Send-Q                         Local Address:Port                         Peer Address:Port            Process
UNCONN            0                  0                                    0.0.0.0:67                                0.0.0.0:*                users:(("dhcpd",pid=760,fd=7))
UNCONN            0                  0                                    0.0.0.0:111                               0.0.0.0:*                users:(("rpcbind",pid=651,fd=5),("systemd",pid=1,fd=33))
UNCONN            0                  0                                  127.0.0.1:323                               0.0.0.0:*                users:(("chronyd",pid=685,fd=5))
UNCONN            0                  0                                       [::]:111                                  [::]:*                users:(("rpcbind",pid=651,fd=7),("systemd",pid=1,fd=35))
UNCONN            0                  0                                      [::1]:323                                  [::]:*                users:(("chronyd",pid=685,fd=6))




[walt@companyrouter ca]$ easyrsa gen-dh
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/ca/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
Generating DH parameters, 2048 bit long safe prime
............................................................................................+..................................+....................................................................................................................................+................................................................++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*
DH parameters appear to be ok.

Notice
------

DH parameters of size 2048 created at:
* /home/walt/openvpn/ca/pki/dh.pem

[walt@companyrouter ca]$


[walt@companyrouter server]$ cat server.conf | grep -v -E "^$|#|;"
local 192.168.100.253
port 1194
proto udp
dev tun
ca ca.crt
cert companyserver.crt
key companyserver.key
dh dh.pem
topology subnet
server 172.30.124.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "route 172.30.0.0 255.255.0.0"
keepalive 10 120
cipher AES-256-GCM
persist-key
persist-tun
status openvpn-status.log
log-append openvpn.log
verb 9
explicit-exit-notify 1
[walt@companyrouter server]$


[walt@companyrouter server]$ sudo openvpn server.conf &
[1] 2828
[walt@companyrouter server]$ sudo ss -unlp
State             Recv-Q            Send-Q                          Local Address:Port                         Peer Address:Port            Process
UNCONN            0                 0                                     0.0.0.0:67                                0.0.0.0:*                users:(("dhcpd",pid=760,fd=7))
UNCONN            0                 0                                     0.0.0.0:111                               0.0.0.0:*                users:(("rpcbind",pid=651,fd=5),("systemd",pid=1,fd=33))
UNCONN            0                 0                             192.168.100.253:1194                              0.0.0.0:*                users:(("openvpn",pid=2830,fd=6))
UNCONN            0                 0                                   127.0.0.1:323                               0.0.0.0:*                users:(("chronyd",pid=685,fd=5))
UNCONN            0                 0                                        [::]:111                                  [::]:*                users:(("rpcbind",pid=651,fd=7),("systemd",pid=1,fd=35))
UNCONN            0                 0                                       [::1]:323                                  [::]:*                users:(("chronyd",pid=685,fd=6))


[walt@companyrouter server]$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s3
    inet 192.168.100.253/24 brd 192.168.100.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s8
    inet 172.30.0.254/24 brd 172.30.0.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s9
    inet 172.30.10.254/24 brd 172.30.10.255 scope global noprefixroute eth2
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s10
    inet 172.30.20.254/24 brd 172.30.20.255 scope global noprefixroute eth3
       valid_lft forever preferred_lft forever
6: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
9: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 500
    inet 172.30.124.1/24 scope global tun0
       valid_lft forever preferred_lft forever



vagrant@red:~$ sudo nmap -sU -sV 192.168.100.253 -p1194
Starting Nmap 7.93 ( https://nmap.org ) at 2024-01-09 12:05 UTC
Nmap scan report for companyrouter (192.168.100.253)
Host is up (0.0011s latency).

PORT     STATE SERVICE VERSION
1194/udp open  openvpn OpenVPN
MAC Address: 08:00:27:2E:6B:E6 (Oracle VirtualBox virtual NIC)

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.30 seconds





vagrant@homeclient:~$ sudo apt update && sudo apt install -y openvpn
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease
Get:3 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [2643 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal/universe amd64 Packages [8628 kB]
Get:7 http://security.ubuntu.com/ubuntu focal-security/main Translation-en [406 kB]
Get:8 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [2451 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal/universe Translation-en [5124 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal/universe amd64 c-n-f Metadata [265 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 Packages [144 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal/multiverse Translation-en [104 kB]
Get:13 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 c-n-f Metadata [9136 B]
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [3023 kB]
Get:15 http://archive.ubuntu.com/ubuntu focal-updates/main Translation-en [488 kB]
Get:16 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [2570 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal-updates/restricted Translation-en [359 kB]
Get:18 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [1143 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [274 kB]
Get:20 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 c-n-f Metadata [25.7 kB]
Get:21 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [26.1 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal-updates/multiverse Translation-en [7768 B]
Get:23 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 c-n-f Metadata [620 B]
Get:24 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [45.7 kB]
Get:25 http://archive.ubuntu.com/ubuntu focal-backports/main Translation-en [16.3 kB]
Get:26 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 c-n-f Metadata [1420 B]
Get:27 http://archive.ubuntu.com/ubuntu focal-backports/restricted amd64 c-n-f Metadata [116 B]
Get:28 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [25.0 kB]
Get:29 http://archive.ubuntu.com/ubuntu focal-backports/universe Translation-en [16.3 kB]
Get:30 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 c-n-f Metadata [880 B]
Get:31 http://archive.ubuntu.com/ubuntu focal-backports/multiverse amd64 c-n-f Metadata [116 B]
Get:32 http://security.ubuntu.com/ubuntu focal-security/restricted Translation-en [342 kB]
Get:33 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [917 kB]
Get:34 http://security.ubuntu.com/ubuntu focal-security/universe Translation-en [192 kB]
Get:35 http://security.ubuntu.com/ubuntu focal-security/universe amd64 c-n-f Metadata [19.2 kB]
Get:36 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [23.9 kB]
Get:37 http://security.ubuntu.com/ubuntu focal-security/multiverse Translation-en [5796 B]
Get:38 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 c-n-f Metadata [548 B]
Fetched 29.6 MB in 7s (4448 kB/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
18 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  libpkcs11-helper1
Suggested packages:
  resolvconf openvpn-systemd-resolved easy-rsa
The following NEW packages will be installed:
  libpkcs11-helper1 openvpn
0 upgraded, 2 newly installed, 0 to remove and 18 not upgraded.
Need to get 527 kB of archives.
After this operation, 1352 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libpkcs11-helper1 amd64 1.26-1 [44.3 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 openvpn amd64 2.4.12-0ubuntu0.20.04.1 [483 kB]
Fetched 527 kB in 0s (1876 kB/s)
Preconfiguring packages ...
Selecting previously unselected package libpkcs11-helper1:amd64.
(Reading database ... 63756 files and directories currently installed.)
Preparing to unpack .../libpkcs11-helper1_1.26-1_amd64.deb ...
Unpacking libpkcs11-helper1:amd64 (1.26-1) ...
Selecting previously unselected package openvpn.
Preparing to unpack .../openvpn_2.4.12-0ubuntu0.20.04.1_amd64.deb ...
Unpacking openvpn (2.4.12-0ubuntu0.20.04.1) ...
Setting up libpkcs11-helper1:amd64 (1.26-1) ...
Setting up openvpn (2.4.12-0ubuntu0.20.04.1) ...
 * Restarting virtual private network daemon.                                                                                                                                                             [ OK ]
Created symlink /etc/systemd/system/multi-user.target.wants/openvpn.service → /lib/systemd/system/openvpn.service.
Processing triggers for systemd (245.4-4ubuntu3.22) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.14) ...
vagrant@homeclient:~$




vagrant@homeclient:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_rsa
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:82pr47yB2HoaaK6LQ4QfTn/1g8EwkFy1z90oWUHgWWM vagrant@homeclient
The key's randomart image is:
+---[RSA 3072]----+
|   ..+... .oE    |
|    o o  o + o   |
|.      +. o .    |
|..o     +o + o   |
|.+ o   .S+= o .  |
| .o..o...oo.     |
|. o o.o . ..     |
|oo   o..+o       |
|++. oo +*+       |
+----[SHA256]-----+
vagrant@homeclient:~$




vagrant@homeclient:~$ ssh-copy-id walt@192.168.100.253 -p2222
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
walt@192.168.100.253's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh -p '2222' 'walt@192.168.100.253'"
and check to make sure that only the key(s) you wanted were added.

vagrant@homeclient:~$ mkdir client
vagrant@homeclient:~$ scp -P2222 walt@192.168.100.253:/home/walt/openvpn/ca/pki/ca.crt ~/client/
ca.crt                                                                                                                                                                         100% 1196     1.7MB/s   00:00
vagrant@homeclient:~$ scp -P2222 walt@192.168.100.253:/home/walt/openvpn/ca/pki/dh.pem ~/client/
dh.pem                                                                                                                                                                         100%  424   524.5KB/s   00:00
vagrant@homeclient:~$ scp -P2222 walt@192.168.100.253:/home/walt/openvpn/ca/pki/issued/homeclient.crt ~/client/
homeclient.crt                                                                                                                                                                 100% 4511     4.9MB/s   00:00
vagrant@homeclient:~$ scp -P2222 walt@192.168.100.253:/home/walt/openvpn/ca/pki/private/homeclient.key ~/client/
homeclient.key                                                                                                                                                                 100% 1704     1.5MB/s   00:00
vagrant@homeclient:~$ scp -P2222 walt@192.168.100.253:/usr/share/doc/openvpn/sample/sample-config-files/client.conf ~/client/
client.conf                                                                                                                                                                    100% 3589     1.2MB/s   00:00
vagrant@homeclient:~$ ls -al client/
total 32
drwxrwxr-x 2 vagrant vagrant 4096 Jan  9 13:28 .
drwxr-xr-x 5 vagrant vagrant 4096 Jan  9 13:28 ..
-rw------- 1 vagrant vagrant 1196 Jan  9 13:25 ca.crt
-rw-r--r-- 1 vagrant vagrant 3589 Jan  9 13:27 client.conf
-rw------- 1 vagrant vagrant  424 Jan  9 13:25 dh.pem
-rw------- 1 vagrant vagrant 4511 Jan  9 13:26 homeclient.crt
-rw------- 1 vagrant vagrant 1704 Jan  9 13:26 homeclient.key




vagrant@homeclient:~/client$ grep -v -E "^$|#|;" client.conf
client
dev tun
proto udp
remote 192.168.100.253 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ca ca.crt
cert homeclient.crt
key homeclient.key
remote-cert-tls server
cipher AES-256-GCM
verb 3



vagrant@homeclient:~/client$ sudo openvpn client.conf &
[1] 2319
vagrant@homeclient:~/client$ Tue Jan  9 13:38:41 2024 OpenVPN 2.4.12 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Aug 21 2023
Tue Jan  9 13:38:41 2024 library versions: OpenSSL 1.1.1f  31 Mar 2020, LZO 2.10
Tue Jan  9 13:38:41 2024 TCP/UDP: Preserving recently used remote address: [AF_INET]192.168.100.253:1194
Tue Jan  9 13:38:41 2024 Socket Buffers: R=[212992->212992] S=[212992->212992]
Tue Jan  9 13:38:41 2024 UDP link local: (not bound)
Tue Jan  9 13:38:41 2024 UDP link remote: [AF_INET]192.168.100.253:1194
Tue Jan  9 13:38:41 2024 TLS: Initial packet from [AF_INET]192.168.100.253:1194, sid=262ee283 289754b0
Tue Jan  9 13:38:41 2024 VERIFY OK: depth=1, CN=companyCA
Tue Jan  9 13:38:41 2024 VERIFY KU OK
Tue Jan  9 13:38:41 2024 Validating certificate extended key usage
Tue Jan  9 13:38:41 2024 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
Tue Jan  9 13:38:41 2024 VERIFY EKU OK
Tue Jan  9 13:38:41 2024 VERIFY OK: depth=0, CN=companyserver
Tue Jan  9 13:38:41 2024 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
Tue Jan  9 13:38:41 2024 [companyserver] Peer Connection Initiated with [AF_INET]192.168.100.253:1194
Tue Jan  9 13:38:42 2024 SENT CONTROL [companyserver]: 'PUSH_REQUEST' (status=1)
Tue Jan  9 13:38:42 2024 PUSH: Received control message: 'PUSH_REPLY,route 172.30.0.0 255.255.0.0,route-gateway 172.30.124.1,topology subnet,ping 10,ping-restart 120,ifconfig 172.30.124.2 255.255.255.0,peer-id 0,cipher AES-256-GCM'
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: timers and/or timeouts modified
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: --ifconfig/up options modified
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: route options modified
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: route-related options modified
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: peer-id set
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: adjusting link_mtu to 1624
Tue Jan  9 13:38:42 2024 OPTIONS IMPORT: data channel crypto options modified
Tue Jan  9 13:38:42 2024 Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Tue Jan  9 13:38:42 2024 Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Tue Jan  9 13:38:42 2024 ROUTE_GATEWAY 192.168.100.254/255.255.255.0 IFACE=enp0s8 HWADDR=08:00:27:fa:c8:7b
Tue Jan  9 13:38:43 2024 TUN/TAP device tun0 opened
Tue Jan  9 13:38:43 2024 TUN/TAP TX queue length set to 100
Tue Jan  9 13:38:43 2024 /sbin/ip link set dev tun0 up mtu 1500
Tue Jan  9 13:38:43 2024 /sbin/ip addr add dev tun0 172.30.124.2/24 broadcast 172.30.124.255
Tue Jan  9 13:38:43 2024 /sbin/ip route add 172.30.0.0/16 via 172.30.124.1
Tue Jan  9 13:38:43 2024 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Tue Jan  9 13:38:43 2024 Initialization Sequence Completed

vagrant@homeclient:~/client$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 192.168.100.167/24 brd 192.168.100.255 scope global enp0s8
       valid_lft forever preferred_lft forever
5: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 100
    inet 172.30.124.2/24 brd 172.30.124.255 scope global tun0
       valid_lft forever preferred_lft forever
vagrant@homeclient:~/client$ ip r
default via 192.168.100.254 dev enp0s8 proto static
172.30.0.0/16 via 172.30.124.1 dev tun0
172.30.124.0/24 dev tun0 proto kernel scope link src 172.30.124.2
192.168.100.0/24 dev enp0s8 proto kernel scope link src 192.168.100.167


vagrant@homeclient:~/client$ ping 172.30.0.15
PING 172.30.0.15 (172.30.0.15) 56(84) bytes of data.
64 bytes from 172.30.0.15: icmp_seq=1 ttl=63 time=0.933 ms
64 bytes from 172.30.0.15: icmp_seq=2 ttl=63 time=2.58 ms
^C
--- 172.30.0.15 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.933/1.758/2.584/0.825 ms
vagrant@homeclient:~/client$ traceroute 172.30.0.15
traceroute to 172.30.0.15 (172.30.0.15), 30 hops max, 60 byte packets
 1  172.30.124.1 (172.30.124.1)  4.591 ms  4.689 ms  4.683 ms
 2  172.30.0.15 (172.30.0.15)  4.849 ms  5.429 ms  5.398 ms
vagrant@homeclient:~/client$

vagrant@homeclient:~/client$ sudo apt install mysql-client
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  mysql-client-8.0 mysql-client-core-8.0 mysql-common
The following NEW packages will be installed:
  mysql-client mysql-client-8.0 mysql-client-core-8.0 mysql-common
0 upgraded, 4 newly installed, 0 to remove and 18 not upgraded.
Need to get 5118 kB of archives.
After this operation, 74.7 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 mysql-client-core-8.0 amd64 8.0.35-0ubuntu0.20.04.1 [5079 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 mysql-common all 5.8+1.0.5ubuntu2 [7496 B]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 mysql-client-8.0 amd64 8.0.35-0ubuntu0.20.04.1 [22.0 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 mysql-client all 8.0.35-0ubuntu0.20.04.1 [9364 B]
Fetched 5118 kB in 2s (2253 kB/s)
Selecting previously unselected package mysql-client-core-8.0.
(Reading database ... 63871 files and directories currently installed.)
Preparing to unpack .../mysql-client-core-8.0_8.0.35-0ubuntu0.20.04.1_amd64.deb ...
Unpacking mysql-client-core-8.0 (8.0.35-0ubuntu0.20.04.1) ...
Selecting previously unselected package mysql-common.
Preparing to unpack .../mysql-common_5.8+1.0.5ubuntu2_all.deb ...
Unpacking mysql-common (5.8+1.0.5ubuntu2) ...
Selecting previously unselected package mysql-client-8.0.
Preparing to unpack .../mysql-client-8.0_8.0.35-0ubuntu0.20.04.1_amd64.deb ...
Unpacking mysql-client-8.0 (8.0.35-0ubuntu0.20.04.1) ...
Selecting previously unselected package mysql-client.
Preparing to unpack .../mysql-client_8.0.35-0ubuntu0.20.04.1_all.deb ...
Unpacking mysql-client (8.0.35-0ubuntu0.20.04.1) ...
Setting up mysql-common (5.8+1.0.5ubuntu2) ...
update-alternatives: using /etc/mysql/my.cnf.fallback to provide /etc/mysql/my.cnf (my.cnf) in auto mode
Setting up mysql-client-core-8.0 (8.0.35-0ubuntu0.20.04.1) ...
Setting up mysql-client-8.0 (8.0.35-0ubuntu0.20.04.1) ...
Setting up mysql-client (8.0.35-0ubuntu0.20.04.1) ...
Processing triggers for man-db (2.9.1-1) ...


vagrant@homeclient:~/client$ fg
sudo openvpn client.conf
^CTue Jan  9 13:45:40 2024 event_wait : Interrupted system call (code=4)
Tue Jan  9 13:45:40 2024 /sbin/ip route del 172.30.0.0/16
Tue Jan  9 13:45:40 2024 Closing TUN/TAP interface
Tue Jan  9 13:45:40 2024 /sbin/ip addr del dev tun0 172.30.124.2/24
Tue Jan  9 13:45:40 2024 SIGINT[hard,] received, process exiting




[walt@companyrouter server]$ sudo openvpn server.conf &
[1] 3313
[walt@companyrouter server]$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s3
    inet 192.168.100.253/24 brd 192.168.100.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s8
    inet 172.30.0.254/24 brd 172.30.0.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s9
    inet 172.30.10.254/24 brd 172.30.10.255 scope global noprefixroute eth2
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s10
    inet 172.30.20.254/24 brd 172.30.20.255 scope global noprefixroute eth3
       valid_lft forever preferred_lft forever
6: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
10: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 500
    inet 172.124.0.1/24 scope global tun0
       valid_lft forever preferred_lft forever



vagrant@homeclient:~/client$ ip -br -4 a
lo               UNKNOWN        127.0.0.1/8
enp0s8           UP             192.168.100.167/24
vagrant@homeclient:~/client$ mysql -utoor -psummer -h172.30.0.15 -e "SELECT user, host FROM mysql.user;"
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 2003 (HY000): Can't connect to MySQL server on '172.30.0.15:3306' (111)
vagrant@homeclient:~/client$ sudo openvpn client.conf &
[1] 4200
vagrant@homeclient:~/client$ Tue Jan  9 14:03:43 2024 OpenVPN 2.4.12 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Aug 21 2023
Tue Jan  9 14:03:43 2024 library versions: OpenSSL 1.1.1f  31 Mar 2020, LZO 2.10
Tue Jan  9 14:03:43 2024 TCP/UDP: Preserving recently used remote address: [AF_INET]192.168.100.253:1194
Tue Jan  9 14:03:43 2024 Socket Buffers: R=[212992->212992] S=[212992->212992]
Tue Jan  9 14:03:43 2024 UDP link local: (not bound)
Tue Jan  9 14:03:43 2024 UDP link remote: [AF_INET]192.168.100.253:1194
Tue Jan  9 14:03:43 2024 TLS: Initial packet from [AF_INET]192.168.100.253:1194, sid=8ffade70 0deb7375
Tue Jan  9 14:03:43 2024 VERIFY OK: depth=1, CN=companyCA
Tue Jan  9 14:03:43 2024 VERIFY KU OK
Tue Jan  9 14:03:43 2024 Validating certificate extended key usage
Tue Jan  9 14:03:43 2024 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
Tue Jan  9 14:03:43 2024 VERIFY EKU OK
Tue Jan  9 14:03:43 2024 VERIFY OK: depth=0, CN=companyserver
Tue Jan  9 14:03:43 2024 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
Tue Jan  9 14:03:43 2024 [companyserver] Peer Connection Initiated with [AF_INET]192.168.100.253:1194
Tue Jan  9 14:03:44 2024 SENT CONTROL [companyserver]: 'PUSH_REQUEST' (status=1)
Tue Jan  9 14:03:44 2024 PUSH: Received control message: 'PUSH_REPLY,route 172.30.0.0 255.255.0.0,route-gateway 172.124.0.1,topology subnet,ping 10,ping-restart 120,ifconfig 172.124.0.2 255.255.255.0,peer-id 0,cipher AES-256-GCM'
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: timers and/or timeouts modified
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: --ifconfig/up options modified
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: route options modified
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: route-related options modified
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: peer-id set
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: adjusting link_mtu to 1624
Tue Jan  9 14:03:44 2024 OPTIONS IMPORT: data channel crypto options modified
Tue Jan  9 14:03:44 2024 Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Tue Jan  9 14:03:44 2024 Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Tue Jan  9 14:03:44 2024 ROUTE_GATEWAY 192.168.100.254/255.255.255.0 IFACE=enp0s8 HWADDR=08:00:27:fa:c8:7b
Tue Jan  9 14:03:44 2024 TUN/TAP device tun0 opened
Tue Jan  9 14:03:44 2024 TUN/TAP TX queue length set to 100
Tue Jan  9 14:03:44 2024 /sbin/ip link set dev tun0 up mtu 1500
Tue Jan  9 14:03:44 2024 /sbin/ip addr add dev tun0 172.124.0.2/24 broadcast 172.124.0.255
Tue Jan  9 14:03:44 2024 /sbin/ip route add 172.30.0.0/16 via 172.124.0.1
Tue Jan  9 14:03:44 2024 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Tue Jan  9 14:03:44 2024 Initialization Sequence Completed

vagrant@homeclient:~/client$ mysql -utoor -psummer -h172.30.0.15 -e "SELECT user, host FROM mysql.user;"
mysql: [Warning] Using a password on the command line interface can be insecure.
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| sammy            | %         |
| toor             | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| root             | localhost |
+------------------+-----------+
vagrant@homeclient:~/client$









[walt@companyrouter ca]$ easyrsa gen-req winclient
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/ca/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
....+............+......+..........+.....+...+.......+..............+.........+.+...+........+...+.........+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.........+.+........+....+......+...........+....+.....+.+........+.+..+....+......+.........+......+............+........+.........+....+.....+............+............+..........+...+..+.+.........+..+.+........+.+........+......+......+...+......+..........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
....+...+..........+.....+......+.......+..+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*....+..+............+....+..+...+......+.........+....+...+...+.....+.......+..+.+..+.........+....+..+....+....................+..........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+................+.....+.+.....+....+..+....+........+......+......+......+...+....+...+.....+...............+...+.+...+......+..+....+.....+....+............+.........+........+......+.+.....+...............+.+..+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [winclient]:

Notice
------
Private-Key and Public-Certificate-Request files created.
Your files are:
* req: /home/walt/openvpn/ca/pki/reqs/winclient.req
* key: /home/walt/openvpn/ca/pki/private/winclient.key

[walt@companyrouter ca]$ easyrsa sign-req client winclient
Using Easy-RSA 'vars' configuration:
* /home/walt/openvpn/ca/pki/vars

Using SSL:
* openssl OpenSSL 3.0.7 1 Nov 2022 (Library: OpenSSL 3.0.7 1 Nov 2022)
You are about to sign the following certificate:
Please check over the details shown below for accuracy. Note that this request
has not been cryptographically verified. Please be sure it came from a trusted
source or that you have verified the request checksum with the sender.
Request subject, to be signed as a client certificate
for '825' days:

subject=
    commonName                = winclient

Type the word 'yes' to continue, or any other input to abort.
  Confirm request details: yes

Using configuration from /home/walt/openvpn/ca/pki/openssl-easyrsa.cnf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
commonName            :ASN.1 12:'winclient'
Certificate is to be certified until Apr 13 23:01:05 2026 GMT (825 days)

Write out database with 1 new entries
Data Base Updated

Notice
------
Certificate created at:
* /home/walt/openvpn/ca/pki/issued/winclient.crt

[walt@companyrouter ca]$ sudo openssl verify -CAfile pki/ca.crt  pki/issued/winclient.crt
pki/issued/winclient.crt: OK
[walt@companyrouter ca]$