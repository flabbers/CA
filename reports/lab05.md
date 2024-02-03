# CSA - Lecture 4 Exercises

## Honeypots

### Cowrie

***This lab introduces the implementation of a honeypot.***

***As defined by Kaspersky ( <https://www.kaspersky.com/resource-center/threats/what-is-a-honeypot> ) a honeypot in cyber security is typically a system or service that acts like a decoy to lure hackers. It mimics a target for hackers in such a way that evildoers think they found "a way in" only to waste time. The most interesting part of a good honeypot is the logging and monitoring. By observing, a good blue teamer can take actions accordingly (for example ban a specific IP or remove specific commands).***

***Let's test this out by creating a SSH honeypot on `companyrouter` using <https://github.com/cowrie/cowrie>***

***You are free to install this tool in any way you see fit. Docker is probably the easiest way to get things up and running but you are free to choose.***

`first: installing docker following https://www.liquidweb.com/kb/install-docker-on-linux-almalinux/`

```code
[walt@companyrouter ~]$ sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc
No match for argument: docker
No match for argument: docker-client
No match for argument: docker-client-latest
No match for argument: docker-common
No match for argument: docker-latest
No match for argument: docker-latest-logrotate
No match for argument: docker-logrotate
No match for argument: docker-engine
No match for argument: podman
No match for argument: runc
No packages marked for removal.
Dependencies resolved.
Nothing to do.
Complete!
[walt@companyrouter ~]$ sudo yum install -yq yum-utils

Installed:
  yum-utils-4.3.0-11.el9_3.alma.1.noarch

[walt@companyrouter ~]$ sudo yum-config-manager --add-repo sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
Adding repo from: https://download.docker.com/linux/centos/docker-ce.repo

[walt@companyrouter ~]$ sudo dnf install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin
Importing GPG key 0x621E9F35:
 Userid     : "Docker Release (CE rpm) <docker@docker.com>"
 Fingerprint: 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35
 From       : https://download.docker.com/linux/centos/gpg


Upgraded:
  audit-3.0.7-104.el9.x86_64                      audit-libs-3.0.7-104.el9.x86_64                      libsemanage-3.5-2.el9.x86_64                      policycoreutils-3.5-3.el9_3.x86_64
Installed:
  checkpolicy-3.5-1.el9.x86_64                 container-selinux-3:2.221.0-1.el9.noarch                containerd.io-1.6.26-3.1.el9.x86_64                   docker-buildx-plugin-0.11.2-1.el9.x86_64
  docker-ce-3:24.0.7-1.el9.x86_64              docker-ce-cli-1:24.0.7-1.el9.x86_64                     docker-ce-rootless-extras-24.0.7-1.el9.x86_64         docker-compose-plugin-2.21.0-1.el9.x86_64
  fuse-common-3.10.2-6.el9.x86_64              fuse-overlayfs-1.12-1.el9.x86_64                        fuse3-3.10.2-6.el9.x86_64                             fuse3-libs-3.10.2-6.el9.x86_64
  libslirp-4.4.0-7.el9.x86_64                  policycoreutils-python-utils-3.5-3.el9_3.noarch         python3-audit-3.0.7-104.el9.x86_64                    python3-distro-1.5.0-7.el9.noarch
  python3-libsemanage-3.5-2.el9.x86_64         python3-policycoreutils-3.5-3.el9_3.noarch              python3-setools-4.4.3-1.el9.x86_64                    python3-setuptools-53.0.0-12.el9.noarch
  slirp4netns-1.2.1-1.el9.x86_64

[walt@companyrouter ~]$ sudo systemctl start docker
[walt@companyrouter ~]$ sudo systemctl enable docker
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /usr/lib/systemd/system/docker.service.
[walt@companyrouter ~]$ sudo systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; preset: disabled)
     Active: active (running) since Fri 2024-01-05 11:08:07 UTC; 13s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 3801 (dockerd)
      Tasks: 8
     Memory: 32.8M
        CPU: 199ms
     CGroup: /system.slice/docker.service
             └─3801 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Jan 05 11:08:06 companyrouter systemd[1]: Starting Docker Application Container Engine...
Jan 05 11:08:06 companyrouter dockerd[3801]: time="2024-01-05T11:08:06.986999010Z" level=info msg="Starting up"
Jan 05 11:08:07 companyrouter dockerd[3801]: time="2024-01-05T11:08:07.032664156Z" level=info msg="Loading containers: start."
Jan 05 11:08:07 companyrouter dockerd[3801]: time="2024-01-05T11:08:07.341557269Z" level=info msg="Loading containers: done."
Jan 05 11:08:07 companyrouter dockerd[3801]: time="2024-01-05T11:08:07.355323358Z" level=info msg="Docker daemon" commit=311b9ff graphdriver=overlay2 version=24.0.7
Jan 05 11:08:07 companyrouter dockerd[3801]: time="2024-01-05T11:08:07.355494234Z" level=info msg="Daemon has completed initialization"
Jan 05 11:08:07 companyrouter dockerd[3801]: time="2024-01-05T11:08:07.395105972Z" level=info msg="API listen on /run/docker.sock"
Jan 05 11:08:07 companyrouter systemd[1]: Started Docker Application Container Engine.
[walt@companyrouter ~]$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Pull complete
Digest: sha256:ac69084025c660510933cca701f615283cdbb3aa0963188770b54c31c8962493
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

[walt@companyrouter ~]$ sudo usermod -aG docker walt
[walt@companyrouter ~]$ id walt
uid=1003(walt) gid=1003(walt) groups=1003(walt),988(docker)
[walt@companyrouter ~]$ docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

***Steps***

***Why is `companyrouter`, in this environment, an interesting device to configure with a SSH honeypot? What could be a good argument to NOT configure the router with a honeypot service?***

`Since this device is facing the internet, changes are it will be scanned on standard ports. If attackers loose time here and don't look further into the actual network for e.g. the bastion: gain. It should also have some tight firewall running. On the other hand, if this router is compromised we are in serious trouble. This machine has other functions too (route) which are essential. Perhaps set up a dedicated, isolated machine to serve as a honeypot inside and outside the firewall`

***Change your current SSH configuration in such a way that the SSH server (daemon) is not listening on port 22 anymore but on port 2222.***

`first running it on both ports, adding it to secure linux and adjusting the firewall rules`

```code
[walt@companyrouter ~]$ sudo grep -E "^Port|^Listen" /etc/ssh/sshd_config
Port 22
[walt@companyrouter ~]$ sudo nano /etc/ssh/sshd_config
[walt@companyrouter ~]$ sudo grep -E "^Port|^Listen" /etc/ssh/sshd_config
Port 22
Port 2222
[walt@companyrouter ~]$ sudo semanage port -l | grep ssh
ssh_port_t                     tcp      22
[walt@companyrouter ~]$ sudo semanage port -a -t ssh_port_t -p tcp 2222
[walt@companyrouter ~]$ sudo semanage port -l | grep ssh
ssh_port_t                     tcp      2222, 22
[walt@companyrouter ~]$ sudo systemctl restart sshd
[walt@companyrouter ~]$ sudo ss -tlnp
State             Recv-Q             Send-Q                         Local Address:Port                         Peer Address:Port            Process
LISTEN            0                  128                                  0.0.0.0:22                                0.0.0.0:*                users:(("sshd",pid=1628,fd=5))
LISTEN            0                  4096                                 0.0.0.0:111                               0.0.0.0:*                users:(("rpcbind",pid=624,fd=4),("systemd",pid=1,fd=31))
LISTEN            0                  128                                  0.0.0.0:2222                              0.0.0.0:*                users:(("sshd",pid=1628,fd=3))
LISTEN            0                  128                                     [::]:22                                   [::]:*                users:(("sshd",pid=1628,fd=6))
LISTEN            0                  4096                                    [::]:111                                  [::]:*                users:(("rpcbind",pid=624,fd=6),("systemd",pid=1,fd=34))
LISTEN            0                  128                                     [::]:2222                                 [::]:*                users:(("sshd",pid=1628,fd=4))
[walt@companyrouter ~]$ sudo nft list ruleset
table ip nat {
        chain DOCKER {
                iifname "docker0" counter packets 0 bytes 0 return
        }

        chain POSTROUTING {
                type nat hook postrouting priority srcnat; policy accept;
                oifname != "docker0" ip saddr 172.17.0.0/16 counter packets 0 bytes 0 masquerade
        }

        chain PREROUTING {
                type nat hook prerouting priority dstnat; policy accept;
                fib daddr type local counter packets 1 bytes 52 jump DOCKER
        }

        chain OUTPUT {
                type nat hook output priority -100; policy accept;
                ip daddr != 127.0.0.0/8 fib daddr type local counter packets 0 bytes 0 jump DOCKER
        }
}
table ip filter {
        chain DOCKER {
        }

        chain DOCKER-ISOLATION-STAGE-1 {
                iifname "docker0" oifname != "docker0" counter packets 0 bytes 0 jump DOCKER-ISOLATION-STAGE-2
                counter packets 46 bytes 4170 return
        }

        chain DOCKER-ISOLATION-STAGE-2 {
                oifname "docker0" counter packets 0 bytes 0 drop
                counter packets 0 bytes 0 return
        }

        chain FORWARD {
                type filter hook forward priority filter; policy accept;
                counter packets 46 bytes 4170 jump DOCKER-USER
                counter packets 46 bytes 4170 jump DOCKER-ISOLATION-STAGE-1
                oifname "docker0" ct state related,established counter packets 0 bytes 0 accept
                oifname "docker0" counter packets 0 bytes 0 jump DOCKER
                iifname "docker0" oifname != "docker0" counter packets 0 bytes 0 accept
                iifname "docker0" oifname "docker0" counter packets 0 bytes 0 accept
        }

        chain DOCKER-USER {
                counter packets 46 bytes 4170 return
        }
}
```

`since docker seems to have added a few things I'm continuing without my own nft rules!`

`adjusting the ports on all jump configurations and testing`

```code
PS C:\data\git\CA> cat C:\Users\Benny\.ssh\config
Host webD
        hostname web
        User walt
        Port 22
Host webB
        hostname web
        User walt
        Port 22
        ProxyJump jump@bastion:699
Host webR
        Hostname web
        User walt
        Port 22
        Proxyjump walt@companyrouter:2222
Host databaseD
        hostname database
        User walt
        Port 22
Host databaseB
        hostname database
        User walt
        Port 22
        ProxyJump jump@bastion:699
Host databaseR
        hostname database
        User walt
        Port 22
        ProxyJump walt@companyrouter:2222
Host databaseJ
        hostname bastion
        User jumpdatabase
        Port 699
Host dcD
        hostname dc
        User walt
        Port 22
Host dcB
        hostname dc
        User walt
        Port 22
        ProxyJump jump@bastion:699
Host dcR
        Hostname dc
        User walt
        Port 22
        Proxyjump walt@companyrouter:2222
Host win10D
        hostname win10
        User walt
        Port 22
Host win10B
        hostname win10
        User walt
        Port 22
        ProxyJump jump@bastion:699
Host win10R
        hostname win10
        User walt
        Port 22
        ProxyJump walt@companyrouter:2222
Host companyrouterD
        hostname companyrouter
        User walt
        Port 2222
Host companyrouterB
        hostname companyrouter
        User walt
        Port 22
        ProxyJump jump@bastion:699
Host isprouterD
        hostname isprouter
        User vagrant
        Port 22
Host redD
        hostname red
        User vagrant
        Port 22
Host bastionD
        hostname bastion
        User walt
        Port 699
Host bastionR
        hostname bastion
        User walt
        Port 699
        Proxyjump walt@companyrouter:2222
PS C:\data\git\ca> ssh companyrouterD
Last login: Fri Jan  5 11:56:42 2024 from 192.168.100.1
[walt@companyrouter ~]$ sudo ss -tlnp
State             Recv-Q             Send-Q                         Local Address:Port                         Peer Address:Port            Process
LISTEN            0                  128                                  0.0.0.0:22                                0.0.0.0:*                users:(("sshd",pid=1628,fd=5))
LISTEN            0                  4096                                 0.0.0.0:111                               0.0.0.0:*                users:(("rpcbind",pid=624,fd=4),("systemd",pid=1,fd=31))
LISTEN            0                  128                                  0.0.0.0:2222                              0.0.0.0:*                users:(("sshd",pid=1628,fd=3))
LISTEN            0                  128                                     [::]:22                                   [::]:*                users:(("sshd",pid=1628,fd=6))
LISTEN            0                  4096                                    [::]:111                                  [::]:*                users:(("rpcbind",pid=624,fd=6),("systemd",pid=1,fd=34))
LISTEN            0                  128                                     [::]:2222                                 [::]:*                users:(("sshd",pid=1628,fd=4))
[walt@companyrouter ~]$ sudo ss -tnp
State                  Recv-Q                  Send-Q                                       Local Address:Port                                      Peer Address:Port                   Process
ESTAB                  0                       0                                          192.168.100.253:2222                                     192.168.100.1:29274                   users:(("sshd",pid=1699,fd=4),("sshd",pid=1686,fd=4))
```

```code
PS C:\Users\Benny> ssh databaseR
Last login: Fri Jan  5 11:58:53 2024 from 172.30.20.20
[walt@database ~]$ sudo ss -tnp
State                   Recv-Q                   Send-Q                                     Local Address:Port                                     Peer Address:Port                   Process
ESTAB                   0                        0                                            172.30.0.15:22                                       172.30.0.254:38560                   users:(("sshd",pid=2430,fd=4),("sshd",pid=2427,fd=4))
```

```code
[walt@companyrouter ~]$ sudo ss -tnp
State            Recv-Q            Send-Q                           Local Address:Port                           Peer Address:Port             Process
ESTAB            0                 0                                 172.30.0.254:38560                           172.30.0.15:22                users:(("sshd",pid=1735,fd=8))
ESTAB            0                 52                             192.168.100.253:2222                          192.168.100.1:29274             users:(("sshd",pid=1699,fd=4),("sshd",pid=1686,fd=4))
ESTAB            0                 0                              192.168.100.253:2222                          192.168.100.1:29312             users:(("sshd",pid=1735,fd=4),("sshd",pid=1732,fd=4))
```

`only listen on port 2222, which actually is a too common choice of a port to fool any hacker`

```code
[walt@companyrouter ~]$ sudo nano /etc/ssh/sshd_config
[walt@companyrouter ~]$ sudo grep -E "^Port|^Listen" /etc/ssh/sshd_config
Port 2222
[walt@companyrouter ~]$ sudo systemctl restart sshd
[walt@companyrouter ~]$ sudo ss -tlnp
State             Recv-Q             Send-Q                         Local Address:Port                         Peer Address:Port            Process
LISTEN            0                  4096                                 0.0.0.0:111                               0.0.0.0:*                users:(("rpcbind",pid=624,fd=4),("systemd",pid=1,fd=31))
LISTEN            0                  128                                  0.0.0.0:2222                              0.0.0.0:*                users:(("sshd",pid=1761,fd=3))
LISTEN            0                  4096                                    [::]:111                                  [::]:*                users:(("rpcbind",pid=624,fd=6),("systemd",pid=1,fd=34))
LISTEN            0                  128                                     [::]:2222                                 [::]:*                users:(("sshd",pid=1761,fd=4))
```

***Install and run the cowrie software on the router and listen on port 22 - the default SSH server port.***

```code
docker run -p 22:2222 cowrie/cowrie:latest
Unable to find image 'cowrie/cowrie:latest' locally
latest: Pulling from cowrie/cowrie
62a9f8728f85: Pulling fs layer
2b776ada0341: Pulling fs layer
3996ddec0b81: Pulling fs layer
fcb6f6d2c998: Pulling fs layer
e8c73c638ae9: Pulling fs layer
1e3d9b7d1452: Pulling fs layer
4aa0ea1413d3: Pulling fs layer
2fa82a9c76b2: Pulling fs layer
672354a91bfa: Pulling fs layer
1b26523ec020: Pulling fs layer
ad7888c7ea2f: Pulling fs layer
09c50f98c494: Pulling fs layer
1f1e45d26788: Pulling fs layer
7145a5563bee: Pulling fs layer
cb962b2ad3e0: Pulling fs layer
3b83b970058b: Pull complete
46cabf7510de: Pull complete
80a5700d5b59: Pull complete
7a124acab35c: Pull complete
9e7282066ee5: Pull complete
1a891866ee9d: Pull complete
9480e4f99b9d: Pull complete
270fd836ffec: Pull complete
cf0de6f66aeb: Pull complete
0a8d8b383fe1: Pull complete
6d835e8efc1a: Pull complete
beb1677f7fca: Pull complete
c1880fefce61: Pull complete
5a6c0422a880: Pull complete
2001a3789e44: Pull complete
2838a764c199: Pull complete
6ac4ddc63882: Pull complete
6725da221b5c: Pull complete
019e1db5e48a: Pull complete
36a4a58c8a43: Pull complete
9a7c231e46e2: Pull complete
f9f1b6a4364b: Pull complete
270ddd118176: Pull complete
b38a575a87cb: Pull complete
e25fc685cbd6: Pull complete
8a328f36112d: Pull complete
9077e444c2c4: Pull complete
20bd8a87459e: Pull complete
4f4fb700ef54: Pull complete
Digest: sha256:dc76806c4a0d4c02e9284bd5fee98023c6995d834d0f55f5ce9bbe79c99b46e4
Status: Downloaded newer image for cowrie/cowrie:latest
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:106: CryptographyDeprecationWarning: Blowfish has been deprecated
  b"blowfish-cbc": (algorithms.Blowfish, 16, modes.CBC),
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:110: CryptographyDeprecationWarning: CAST5 has been deprecated
  b"cast128-cbc": (algorithms.CAST5, 16, modes.CBC),
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:115: CryptographyDeprecationWarning: Blowfish has been deprecated
  b"blowfish-ctr": (algorithms.Blowfish, 16, modes.CTR),
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:116: CryptographyDeprecationWarning: CAST5 has been deprecated
  b"cast128-ctr": (algorithms.CAST5, 16, modes.CTR),
2024-01-05T13:42:57+0000 [-] Python Version 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0]
2024-01-05T13:42:57+0000 [-] Twisted Version 23.10.0
2024-01-05T13:42:57+0000 [-] Cowrie Version 2.5.0
2024-01-05T13:42:57+0000 [-] Loaded output engine: jsonlog
2024-01-05T13:42:57+0000 [twisted.scripts._twistd_unix.UnixAppLogger#info] twistd 23.10.0 (/cowrie/cowrie-env/bin/python3 3.11.2) starting up.
2024-01-05T13:42:57+0000 [twisted.scripts._twistd_unix.UnixAppLogger#info] reactor class: twisted.internet.epollreactor.EPollReactor.
2024-01-05T13:42:57+0000 [-] CowrieSSHFactory starting on 2222
2024-01-05T13:42:57+0000 [cowrie.ssh.factory.CowrieSSHFactory#info] Starting factory <cowrie.ssh.factory.CowrieSSHFactory object at 0x7f4847e6c810>
2024-01-05T13:42:57+0000 [-] Generating new RSA keypair...
2024-01-05T13:42:57+0000 [-] Generating new ECDSA keypair...
2024-01-05T13:42:57+0000 [-] Generating new ed25519 keypair...
2024-01-05T13:42:57+0000 [-] Ready to accept SSH connections
```

```code
PS C:\Users\Benny> ssh walt@192.168.100.253 -p22
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:vzJL4jYocQLPIs3vHRxyAB8yPPK5bwR7fwFX4YBH0LA.
Please contact your system administrator.
Add correct host key in C:\\Users\\Benny/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in C:\\Users\\Benny/.ssh/known_hosts:41
ECDSA host key for 192.168.100.253 has changed and you have requested strict checking.
Host key verification failed.
PS C:\Users\Benny>
```

```code
2024-01-05T13:44:21+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha1
2024-01-05T13:44:21+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha256
2024-01-05T13:44:21+0000 [cowrie.ssh.factory.CowrieSSHFactory] New connection: 192.168.100.1:33836 (172.17.0.2:2222) [session: 2235934424cb]
2024-01-05T13:44:21+0000 [HoneyPotSSHTransport,0,192.168.100.1] Remote SSH version: SSH-2.0-OpenSSH_for_Windows_8.1
2024-01-05T13:44:21+0000 [HoneyPotSSHTransport,0,192.168.100.1] SSH client hassh fingerprint: ec7378c1a92f5a8dde7e8b7a1ddf33d1
2024-01-05T13:44:21+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] kex alg=b'curve25519-sha256' key alg=b'ecdsa-sha2-nistp256'
2024-01-05T13:44:21+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] outgoing: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T13:44:21+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] incoming: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T13:44:21+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#info] connection lost
2024-01-05T13:44:21+0000 [HoneyPotSSHTransport,0,192.168.100.1] Connection lost after 0 seconds
```

vagrant@red:~$ ssh walt@192.168.100.253 -p22
The authenticity of host '192.168.100.253 (192.168.100.253)' can't be established.
ED25519 key fingerprint is SHA256:sqFEOUPnfeu+7B4yvdEc84gFIHMw052936a34hG7Adg.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.100.253' (ED25519) to the list of known hosts.
walt@192.168.100.253's password:
Permission denied, please try again.
walt@192.168.100.253's password:
Permission denied, please try again.
walt@192.168.100.253's password:
walt@192.168.100.253: Permission denied (publickey,password).



2024-01-05T13:46:30+0000 [HoneyPotSSHTransport,1,192.168.100.166] Remote SSH version: SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u1
2024-01-05T13:46:30+0000 [HoneyPotSSHTransport,1,192.168.100.166] SSH client hassh fingerprint: 78c05d999799066a2b4554ce7b1585a6
2024-01-05T13:46:30+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] kex alg=b'curve25519-sha256' key alg=b'ssh-ed25519'
2024-01-05T13:46:30+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] outgoing: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T13:46:30+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] incoming: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T13:46:38+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] NEW KEYS
2024-01-05T13:46:38+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] starting service b'ssh-userauth'
2024-01-05T13:46:38+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' trying auth b'none'
2024-01-05T13:46:42+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' trying auth b'password'
2024-01-05T13:46:42+0000 [HoneyPotSSHTransport,1,192.168.100.166] Could not read etc/userdb.txt, default database activated
2024-01-05T13:46:42+0000 [HoneyPotSSHTransport,1,192.168.100.166] login attempt [b'walt'/b'test'] failed
2024-01-05T13:46:43+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' failed auth b'password'
2024-01-05T13:46:43+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] unauthorized login: ()
2024-01-05T13:46:57+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' trying auth b'password'
2024-01-05T13:46:57+0000 [HoneyPotSSHTransport,1,192.168.100.166] Could not read etc/userdb.txt, default database activated
2024-01-05T13:46:57+0000 [HoneyPotSSHTransport,1,192.168.100.166] login attempt [b'walt'/b'test'] failed
2024-01-05T13:46:58+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' failed auth b'password'
2024-01-05T13:46:58+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] unauthorized login: ()
2024-01-05T13:47:00+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' trying auth b'password'
2024-01-05T13:47:00+0000 [HoneyPotSSHTransport,1,192.168.100.166] Could not read etc/userdb.txt, default database activated
2024-01-05T13:47:00+0000 [HoneyPotSSHTransport,1,192.168.100.166] login attempt [b'walt'/b'test'] failed
2024-01-05T13:47:01+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'walt' failed auth b'password'
2024-01-05T13:47:01+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] unauthorized login: ()
2024-01-05T13:47:01+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#info] connection lost
2024-01-05T13:47:01+0000 [HoneyPotSSHTransport,1,192.168.100.166] Connection lost after 30 seconds


vagrant@red:~$ ssh walt@192.168.100.253 -p2222
The authenticity of host '[192.168.100.253]:2222 ([192.168.100.253]:2222)' can't be established.
ED25519 key fingerprint is SHA256:+KItuvzdodGYaCzEV6MY+V6qX60REdBpiA8eztJYK04.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:1: [hashed name]
    ~/.ssh/known_hosts:11: [hashed name]
    ~/.ssh/known_hosts:14: [hashed name]
    ~/.ssh/known_hosts:18: [hashed name]
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[192.168.100.253]:2222' (ED25519) to the list of known hosts.
walt@192.168.100.253's password:
Last login: Fri Jan  5 11:58:05 2024 from 192.168.100.1
[walt@companyrouter ~]$



[walt@companyrouter ~]$ git clone https://github.com/cowrie/cowrie.git
Cloning into 'cowrie'...
remote: Enumerating objects: 17115, done.
remote: Counting objects: 100% (1766/1766), done.
remote: Compressing objects: 100% (338/338), done.
remote: Total 17115 (delta 1604), reused 1479 (delta 1428), pack-reused 15349
Receiving objects: 100% (17115/17115), 9.76 MiB | 2.42 MiB/s, done.
Resolving deltas: 100% (12075/12075), done.


[walt@companyrouter ~]$ cat cowrie/etc/userdb.txt
# Example userdb.txt
# This file may be copied to etc/userdb.txt.
# If etc/userdb.txt is not present, built-in defaults will be used.
#
# ':' separated fields, file is processed line for line
# processing will stop on first match
#
# Field #1 contains the username
# Field #2 is currently unused
# Field #3 contains the password
# '*' for any username or password
# '!' at the start of a password will not grant this password access
# '/' can be used to write a regular expression
#
benny:x:benny


[walt@companyrouter cowrie]$ docker build -t cowriebenny .
[walt@companyrouter cowrie]$ docker build .
[+] Building 164.6s (20/20) FINISHED                                                                                                                                                              docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                        0.0s
 => => transferring dockerfile: 4.26kB                                                                                                                                                                      0.0s
 => [internal] load .dockerignore                                                                                                                                                                           0.0s
 => => transferring context: 131B                                                                                                                                                                           0.0s
 => [internal] load metadata for gcr.io/distroless/python3-debian12:latest                                                                                                                                  0.5s
 => [internal] load metadata for docker.io/library/debian:bookworm-slim                                                                                                                                     0.5s
 => [builder 1/9] FROM docker.io/library/debian:bookworm-slim@sha256:f80c45482c8d147da87613cb6878a7238b8642bcc24fc11bad78c7bec726f340                                                                       3.6s
 => => resolve docker.io/library/debian:bookworm-slim@sha256:f80c45482c8d147da87613cb6878a7238b8642bcc24fc11bad78c7bec726f340                                                                               0.1s
 => => sha256:f80c45482c8d147da87613cb6878a7238b8642bcc24fc11bad78c7bec726f340 1.85kB / 1.85kB                                                                                                              0.0s
 => => sha256:45287d89d96414e57c7705aa30cb8f9836ef30ae8897440dd8f06c4cff801eec 529B / 529B                                                                                                                  0.0s
 => => sha256:8917352b42fa6a6c4a8de28ff102053815d58c7103f7b0c2bbadd12e7e4ea190 1.46kB / 1.46kB                                                                                                              0.0s
 => => sha256:af107e978371b6cd6339127a05502c5eacd1e6b0e9eb7b2f4aa7b6fc87e2dd81 29.13MB / 29.13MB                                                                                                            2.4s
 => => extracting sha256:af107e978371b6cd6339127a05502c5eacd1e6b0e9eb7b2f4aa7b6fc87e2dd81                                                                                                                   1.0s
 => [internal] load build context                                                                                                                                                                           0.1s
 => => transferring context: 2.53MB                                                                                                                                                                         0.1s
 => CACHED [runtime 1/6] FROM gcr.io/distroless/python3-debian12@sha256:a79c243bfb51021d2d08f6ea977396c3f1f416a49566306397776e6710a0735e                                                                    0.0s
 => [builder 2/9] RUN groupadd -r cowrie &&     useradd -r -d /cowrie -m -g cowrie cowrie                                                                                                                   0.5s
 => [builder 3/9] RUN export DEBIAN_FRONTEND=noninteractive;     apt-get -q update &&     apt-get -q install -y         -o APT::Install-Suggests=false         -o APT::Install-Recommends=false       pyt  74.9s
 => [builder 4/9] WORKDIR /cowrie                                                                                                                                                                           0.1s
 => [builder 5/9] RUN mkdir -p /cowrie/cowrie-git                                                                                                                                                           0.2s
 => [builder 6/9] COPY --chown=cowrie:cowrie requirements.txt requirements-output.txt /cowrie/cowrie-git/                                                                                                   0.1s
 => [builder 7/9] RUN python3 -m venv cowrie-env &&     . cowrie-env/bin/activate &&     pip install --no-cache-dir --upgrade pip wheel setuptools &&     pip install --no-cache-dir --upgrade cffi &&     55.1s
 => [builder 8/9] COPY --chown=cowrie:cowrie . /cowrie/cowrie-git                                                                                                                                           0.3s
 => [runtime 2/6] COPY --from=builder --chown=0:0 /etc/passwd /etc/passwd                                                                                                                                   0.1s
 => [runtime 3/6] COPY --from=builder --chown=0:0 /etc/group /etc/group                                                                                                                                     0.1s
 => [runtime 4/6] COPY --from=builder --chown=cowrie:cowrie /cowrie /cowrie                                                                                                                                 4.4s
 => [runtime 5/6] RUN [ "python3", "-m", "compileall", "/cowrie", "/usr/lib/python3.11" ]                                                                                                                   1.8s
 => [runtime 6/6] WORKDIR /cowrie/cowrie-git                                                                                                                                                                0.1s
 => exporting to image                                                                                                                                                                                     15.9s
 => => exporting layers                                                                                                                                                                                    15.9s
  => => writing image sha256:78cde3f9c5ffce9bea27475390ad60f71ddeded5b6c3674503209af0bfbdfdad                                                                                                                0.0s
 => => naming to docker.io/library/cowriebenny

 [walt@companyrouter cowrie]$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
cowriebenny   latest    78cde3f9c5ff   5 minutes ago   622MB
hello-world   latest    d2c94e258dcb   8 months ago    13.3kB



[walt@companyrouter cowrie]$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
cowriebenny   latest    78cde3f9c5ff   5 minutes ago   622MB
hello-world   latest    d2c94e258dcb   8 months ago    13.3kB
[walt@companyrouter cowrie]$ docker run -p 22:2222 cowriebenny
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:106: CryptographyDeprecationWarning: Blowfish has been deprecated
  b"blowfish-cbc": (algorithms.Blowfish, 16, modes.CBC),
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:110: CryptographyDeprecationWarning: CAST5 has been deprecated
  b"cast128-cbc": (algorithms.CAST5, 16, modes.CBC),
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:115: CryptographyDeprecationWarning: Blowfish has been deprecated
  b"blowfish-ctr": (algorithms.Blowfish, 16, modes.CTR),
/cowrie/cowrie-env/lib/python3.11/site-packages/twisted/conch/ssh/transport.py:116: CryptographyDeprecationWarning: CAST5 has been deprecated
  b"cast128-ctr": (algorithms.CAST5, 16, modes.CTR),
2024-01-05T14:49:23+0000 [-] Python Version 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0]
2024-01-05T14:49:23+0000 [-] Twisted Version 23.10.0
2024-01-05T14:49:23+0000 [-] Cowrie Version 2.5.0
2024-01-05T14:49:23+0000 [-] Loaded output engine: jsonlog
2024-01-05T14:49:23+0000 [twisted.scripts._twistd_unix.UnixAppLogger#info] twistd 23.10.0 (/cowrie/cowrie-env/bin/python3 3.11.2) starting up.
2024-01-05T14:49:23+0000 [twisted.scripts._twistd_unix.UnixAppLogger#info] reactor class: twisted.internet.epollreactor.EPollReactor.
2024-01-05T14:49:23+0000 [-] CowrieSSHFactory starting on 2222
2024-01-05T14:49:23+0000 [cowrie.ssh.factory.CowrieSSHFactory#info] Starting factory <cowrie.ssh.factory.CowrieSSHFactory object at 0x7f2d96ebc5d0>
2024-01-05T14:49:23+0000 [-] Generating new RSA keypair...
2024-01-05T14:49:23+0000 [-] Generating new ECDSA keypair...
2024-01-05T14:49:23+0000 [-] Generating new ed25519 keypair...
2024-01-05T14:49:23+0000 [-] Ready to accept SSH connections



vagrant@red:~$ ssh benny@192.168.100.253 -p22
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:XbigReXWALnfkUW3MmYTGk7C76j/bqgIvJXMS1LlXxs.
Please contact your system administrator.
Add correct host key in /home/vagrant/.ssh/known_hosts to get rid of this message.
Offending ED25519 key in /home/vagrant/.ssh/known_hosts:20
  remove with:
  ssh-keygen -f "/home/vagrant/.ssh/known_hosts" -R "192.168.100.253"
Host key for 192.168.100.253 has changed and you have requested strict checking.
Host key verification failed.
vagrant@red:~$ ssh-keygen -f "/home/vagrant/.ssh/known_hosts" -R "192.168.100.253"
# Host 192.168.100.253 found: line 20
/home/vagrant/.ssh/known_hosts updated.
Original contents retained as /home/vagrant/.ssh/known_hosts.old
vagrant@red:~$ ssh benny@192.168.100.253 -p22
The authenticity of host '192.168.100.253 (192.168.100.253)' can't be established.
ED25519 key fingerprint is SHA256:XbigReXWALnfkUW3MmYTGk7C76j/bqgIvJXMS1LlXxs.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.100.253' (ED25519) to the list of known hosts.
benny@192.168.100.253's password:
Permission denied, please try again.
benny@192.168.100.253's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
benny@svr04:~$



2024-01-05T14:49:45+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha1
2024-01-05T14:49:45+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha256
2024-01-05T14:49:45+0000 [cowrie.ssh.factory.CowrieSSHFactory] New connection: 192.168.100.166:51620 (172.17.0.2:2222) [session: 90aea1ce57bf]
2024-01-05T14:49:45+0000 [HoneyPotSSHTransport,0,192.168.100.166] Remote SSH version: SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u1
2024-01-05T14:49:45+0000 [HoneyPotSSHTransport,0,192.168.100.166] SSH client hassh fingerprint: 78c05d999799066a2b4554ce7b1585a6
2024-01-05T14:49:45+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] kex alg=b'curve25519-sha256' key alg=b'ssh-ed25519'
2024-01-05T14:49:45+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] outgoing: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T14:49:45+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] incoming: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T14:49:45+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#info] connection lost
2024-01-05T14:49:45+0000 [HoneyPotSSHTransport,0,192.168.100.166] Connection lost after 0 seconds
2024-01-05T14:49:56+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha1
2024-01-05T14:49:56+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha256
2024-01-05T14:49:56+0000 [cowrie.ssh.factory.CowrieSSHFactory] New connection: 192.168.100.166:39318 (172.17.0.2:2222) [session: 9cc2a998d2b9]
2024-01-05T14:49:56+0000 [HoneyPotSSHTransport,1,192.168.100.166] Remote SSH version: SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u1
2024-01-05T14:49:56+0000 [HoneyPotSSHTransport,1,192.168.100.166] SSH client hassh fingerprint: 78c05d999799066a2b4554ce7b1585a6
2024-01-05T14:49:56+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] kex alg=b'curve25519-sha256' key alg=b'ssh-ed25519'
2024-01-05T14:49:56+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] outgoing: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T14:49:56+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] incoming: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T14:49:56+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#info] connection lost
2024-01-05T14:49:56+0000 [HoneyPotSSHTransport,1,192.168.100.166] Connection lost after 0 seconds
2024-01-05T14:50:09+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha1
2024-01-05T14:50:09+0000 [cowrie.ssh.factory.CowrieSSHFactory] No moduli, no diffie-hellman-group-exchange-sha256
2024-01-05T14:50:09+0000 [cowrie.ssh.factory.CowrieSSHFactory] New connection: 192.168.100.166:53904 (172.17.0.2:2222) [session: 71f726a87f0e]
2024-01-05T14:50:09+0000 [HoneyPotSSHTransport,2,192.168.100.166] Remote SSH version: SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u1
2024-01-05T14:50:09+0000 [HoneyPotSSHTransport,2,192.168.100.166] SSH client hassh fingerprint: 78c05d999799066a2b4554ce7b1585a6
2024-01-05T14:50:09+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] kex alg=b'curve25519-sha256' key alg=b'ssh-ed25519'
2024-01-05T14:50:09+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] outgoing: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T14:50:09+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] incoming: b'aes128-ctr' b'hmac-sha2-256' b'none'
2024-01-05T14:50:11+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] NEW KEYS
2024-01-05T14:50:11+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] starting service b'ssh-userauth'
2024-01-05T14:50:11+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' trying auth b'none'
2024-01-05T14:50:15+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' trying auth b'password'
2024-01-05T14:50:15+0000 [HoneyPotSSHTransport,2,192.168.100.166] login attempt [b'benny'/b'test'] failed
2024-01-05T14:50:16+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' failed auth b'password'
2024-01-05T14:50:16+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] unauthorized login: ()
2024-01-05T14:50:18+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' trying auth b'password'
2024-01-05T14:50:18+0000 [HoneyPotSSHTransport,2,192.168.100.166] login attempt [b'benny'/b'benny'] succeeded
2024-01-05T14:50:18+0000 [HoneyPotSSHTransport,2,192.168.100.166] Initialized emulated server as architecture: linux-x64-lsb
2024-01-05T14:50:18+0000 [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' authenticated with b'password'
2024-01-05T14:50:18+0000 [cowrie.ssh.transport.HoneyPotSSHTransport#debug] starting service b'ssh-connection'
2024-01-05T14:50:18+0000 [cowrie.ssh.connection.CowrieSSHConnection#debug] got channel b'session' request
2024-01-05T14:50:18+0000 [cowrie.ssh.session.HoneyPotSSHSession#info] channel open
2024-01-05T14:50:18+0000 [cowrie.ssh.connection.CowrieSSHConnection#debug] got global b'no-more-sessions@openssh.com' request
2024-01-05T14:50:18+0000 [twisted.conch.ssh.session#info] Handling pty request: b'xterm-256color' (52, 209, 640, 480)
2024-01-05T14:50:18+0000 [SSHChannel session (0) on SSHService b'ssh-connection' on HoneyPotSSHTransport,2,192.168.100.166] Terminal Size: 209 52
2024-01-05T14:50:18+0000 [SSHChannel session (0) on SSHService b'ssh-connection' on HoneyPotSSHTransport,2,192.168.100.166] request_env: LANG=en_US.UTF-8
2024-01-05T14:50:18+0000 [twisted.conch.ssh.session#info] Getting shell

2024-01-05T14:51:03+0000 [HoneyPotSSHTransport,2,192.168.100.166] CMD: ip -4 a
2024-01-05T14:51:03+0000 [HoneyPotSSHTransport,2,192.168.100.166] Can't find command ip
2024-01-05T14:51:03+0000 [HoneyPotSSHTransport,2,192.168.100.166] Command not found: ip -4 a
2024-01-05T14:51:10+0000 [HoneyPotSSHTransport,2,192.168.100.166] CMD: sudo ls
2024-01-05T14:51:10+0000 [HoneyPotSSHTransport,2,192.168.100.166] Command found: sudo ls
2024-01-05T14:51:15+0000 [HoneyPotSSHTransport,2,192.168.100.166] CMD: sudo ss -tnp
2024-01-05T14:51:15+0000 [HoneyPotSSHTransport,2,192.168.100.166] Command found: sudo ss -tnp
2024-01-05T14:51:15+0000 [HoneyPotSSHTransport,2,192.168.100.166] Can't find command ss
2024-01-05T14:51:15+0000 [HoneyPotSSHTransport,2,192.168.100.166] Can't find command -tnp
2024-01-05T14:51:27+0000 [HoneyPotSSHTransport,2,192.168.100.166] CMD: ss -tnp
2024-01-05T14:51:27+0000 [HoneyPotSSHTransport,2,192.168.100.166] Can't find command ss
2024-01-05T14:51:27+0000 [HoneyPotSSHTransport,2,192.168.100.166] Command not found: ss -tnp
2024-01-05T14:51:31+0000 [HoneyPotSSHTransport,2,192.168.100.166] CMD: whoami
2024-01-05T14:51:31+0000 [HoneyPotSSHTransport,2,192.168.100.166] Command found: whoami
2024-01-05T14:51:38+0000 [HoneyPotSSHTransport,2,192.168.100.166] CMD: ifconfig
2024-01-05T14:51:38+0000 [HoneyPotSSHTransport,2,192.168.100.166] Command found: ifconfig


[walt@companyrouter ~]$ ip -4 a
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
6: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever


benny@svr04:~$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/bin/sh
bin:x:2:2:bin:/bin:/bin/sh
sys:x:3:3:sys:/dev:/bin/sh
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/bin/sh
man:x:6:12:man:/var/cache/man:/bin/sh
lp:x:7:7:lp:/var/spool/lpd:/bin/sh
mail:x:8:8:mail:/var/mail:/bin/sh
news:x:9:9:news:/var/spool/news:/bin/sh
uucp:x:10:10:uucp:/var/spool/uucp:/bin/sh
proxy:x:13:13:proxy:/bin:/bin/sh
www-data:x:33:33:www-data:/var/www:/bin/sh
backup:x:34:34:backup:/var/backups:/bin/sh
list:x:38:38:Mailing List Manager:/var/list:/bin/sh
irc:x:39:39:ircd:/var/run/ircd:/bin/sh
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/bin/sh
nobody:x:65534:65534:nobody:/nonexistent:/bin/sh
libuuid:x:100:101::/var/lib/libuuid:/bin/sh
sshd:x:101:65534::/var/run/sshd:/usr/sbin/nologin
phil:x:1000:1000:Phil California,,,:/home/phil:/bin/bash


benny@svr04:~$ ls -l /etc/ssh/sshd_config
-rw-r--r-- 1 root root 2489 2013-04-05 12:02 sshd_config
benny@svr04:~$ cat /etc/ssh/sshd_config
cat: /etc/ssh/sshd_config: No such file or directory


vagrant@red:~$ ssh benny@192.168.100.253 -p22
The authenticity of host '192.168.100.253 (192.168.100.253)' can't be established.
ED25519 key fingerprint is SHA256:22t6X6y4xbtYUSe2CAeHZqZ+VG6SAyfvLP2deGb1mOU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.100.253' (ED25519) to the list of known hosts.
benny@192.168.100.253's password:
Permission denied, please try again.
benny@192.168.100.253's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
benny@companyrouter:~$ w
 16:06:33 up 0 min,  1 user,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
benny    pts/0    192.168.100.253   16:06    0.00s  0.00s  0.00s w
benny@companyrouter:~$ last
benny    pts/0        192.168.100.253  Fri Jan 05 16:06   still logged in

wtmp begins Fri Jan 05 00:01:03 2024
benny@companyrouter:~$ ifconfig
eth0      Link encap:Ethernet  HWaddr 73:ce:28:87:d6:f5
          inet addr:172.17.0.2  Bcast:172.17.0.255  Mask:255.255.255.0
          inet6 addr: fe70::319:2eff:fe0b:fb01/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:343405 errors:0 dropped:0 overruns:0 frame:0
          TX packets:527788 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:167092243 (167.1 MB)  TX bytes:53062407 (53.1 MB)


lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:110 errors:0 dropped:0 overruns:0 frame:0
          TX packets:110 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:42543646 (42.5 MB)  TX bytes:42543646 (42.5 MB)
benny@companyrouter:~$



[walt@companyrouter ~]$ sudo dnf install -yq python3-devel

Installed:
  python3-devel-3.9.18-1.el9_3.x86_64                                                                       python3-pip-21.2.3-7.el9.noarch



  

  vagrant@red:~$ sudo apt-get install -y g it python3-virtualenv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind virtualenv
Reading package lists... DoneReading package lists... 100%Reading package lists... 0%
Building dependency tree... DoneBuilding dependency tree... 50%Building dependency tree... 50%Building dependency tree... 0%Building dependency tree... 0%
Reading state information... DoneReading state information... 0%Reading state information... 0%
git is already the newest version (1:2.39.2-1.1).
build-essential is already the newest version (12.9).
python3-minimal is already the newest version (3.11.2-1+b1).
python3-minimal set to manually installed.
The following additional packages will be installed:
  javascript-common libexpat1-dev libjs-jquery libjs-sphinxdoc libjs-underscore libpython3.11 libpython3.11-dev python3-dev python3-distlib python3-distutils python3-filelock python3-lib2to3 python3-pip-whl
  python3-platformdirs python3-setuptools-whl python3-wheel-whl python3.11-dev zlib1g-dev
Suggested packages:
  apache2 | lighttpd | httpd libssl-doc
The following NEW packages will be installed:
  authbind javascript-common libexpat1-dev libffi-dev libjs-jquery libjs-sphinxdoc libjs-underscore libpython3-dev libpython3.11 libpython3.11-dev libssl-dev python3-dev python3-distlib python3-distutils
  python3-filelock python3-lib2to3 python3-pip-whl python3-platformdirs python3-setuptools-whl python3-virtualenv python3-wheel-whl python3.11-dev virtualenv zlib1g-dev
0 upgraded, 24 newly installed, 0 to remove and 35 not upgraded.
Need to get 15.0 MB of archives.
After this operation, 57.5 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main amd64 authbind amd64 2.1.3 [18.3 kB]            0% [Working]
Get:2 http://deb.debian.org/debian bookworm/main amd64 javascript-common all 11+nmu1 [6,260 B]                        1% [Waiting for headers]                              0% [1 authbind 0 B/18.3 kB 0%]
Get:3 http://deb.debian.org/debian bookworm/main amd64 libexpat1-dev amd64 2.5.0-1 [150 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 libffi-dev amd64 3.4.4-1 [59.4 kB]            3% [Working]                                       2% [3 libexpat1-dev 17.0 kB/150 kB 11%]
Get:5 http://deb.debian.org/debian bookworm/main amd64 libjs-jquery all 3.6.1+dfsg+~3.5.14-1 [326 kB]            5% [Working]                                3% [4 libffi-dev 0 B/59.4 kB 0%]
Get:6 http://deb.debian.org/debian bookworm/main amd64 libjs-underscore all 1.13.4~dfsg+~1.11.4-3 [116 kB]            7% [Working]                                 5% [5 libjs-jquery 0 B/326 kB 0%]
Get:7 http://deb.debian.org/debian bookworm/main amd64 libjs-sphinxdoc all 5.3.0-4 [130 kB]            9% [Working]                                     7% [6 libjs-underscore 0 B/116 kB 0%]
Get:8 http://deb.debian.org/debian bookworm/main amd64 libpython3.11 amd64 3.11.2-6 [1,988 kB]             10% [Working]                                    9% [7 libjs-sphinxdoc 0 B/130 kB 0%]
Get:9 http://deb.debian.org/debian bookworm/main amd64 zlib1g-dev amd64 1:1.2.13.dfsg-1 [916 kB]             22% [Working]                                     10% [8 libpython3.11 0 B/1,988 kB 0%]
Get:10 http://deb.debian.org/debian bookworm/main amd64 libpython3.11-dev amd64 3.11.2-6 [4,738 kB]             27% [Working]                                22% [9 zlib1g-dev 0 B/916 kB 0%]
Get:11 http://deb.debian.org/debian bookworm/main amd64 libpython3-dev amd64 3.11.2-1+b1 [9,572 B]             53% [Working]                                          27% [10 libpython3.11-dev 0 B/4,738 kB 0%]
Get:12 http://deb.debian.org/debian bookworm/main amd64 libssl-dev amd64 3.0.11-1~deb12u2 [2,430 kB]             54% [Working]                                      53% [11 libpython3-dev 0 B/9,572 B 0%]
Get:13 http://deb.debian.org/debian bookworm/main amd64 python3.11-dev amd64 3.11.2-6 [615 kB]             68% [Working]                                   54% [12 libssl-dev 0 B/2,430 kB 0%]
Get:14 http://deb.debian.org/debian bookworm/main amd64 python3-lib2to3 all 3.11.2-3 [76.3 kB]             72% [Working]                                     68% [13 python3.11-dev 0 B/615 kB 0%]
Get:15 http://deb.debian.org/debian bookworm/main amd64 python3-distutils all 3.11.2-3 [131 kB]             73% [Working]                                       72% [14 python3-lib2to3 0 B/76.3 kB 0%]
Get:16 http://deb.debian.org/debian bookworm/main amd64 python3-dev amd64 3.11.2-1+b1 [26.2 kB]             75% [Working]                                        73% [15 python3-distutils 0 B/131 kB 0%]
Get:17 http://deb.debian.org/debian bookworm/main amd64 python3-distlib all 0.3.6-1 [257 kB]                                         75% [16 python3-dev 26.2 kB/26.2 kB 100%]
Get:18 http://deb.debian.org/debian bookworm/main amd64 python3-filelock all 3.9.0-1 [9,460 B]             78% [Working]                                           76% [17 python3-distlib 48.2 kB/257 kB 19%]
Get:19 http://deb.debian.org/debian bookworm/main amd64 python3-pip-whl all 23.0.1+dfsg-1 [1,717 kB]             79% [Working]                                        78% [18 python3-filelock 0 B/9,460 B 0%]
Get:20 http://deb.debian.org/debian bookworm/main amd64 python3-platformdirs all 2.6.0-1 [16.3 kB]             89% [Working]                                        79% [19 python3-pip-whl 0 B/1,717 kB 0%]
Get:21 http://deb.debian.org/debian bookworm/main amd64 python3-setuptools-whl all 66.1.1-1 [1,111 kB]             90% [Working]                                            89% [20 python3-platformdirs 0 B/16.3
Get:22 http://deb.debian.org/debian bookworm/main amd64 python3-wheel-whl all 0.38.4-2 [38.6 kB]             97% [Working]                                               90% [21 python3-setuptools-whl 0 B/1,111
Get:23 http://deb.debian.org/debian bookworm/main amd64 python3-virtualenv all 20.17.1+ds-1 [93.9 kB]             98% [Working]                                         97% [22 python3-wheel-whl 0 B/38.6 kB 0%]
Get:24 http://deb.debian.org/debian bookworm/main amd64 virtualenv all 20.17.1+ds-1 [21.1 kB]             99% [Working]                                          98% [23 python3-virtualenv 0 B/93.9 kB 0%]
Fetched 15.0 MB in 1s (10.5 MB/s)              100% [Working]                                  99% [24 virtualenv 0 B/21.1 kB 0%]
Selecting previously unselected package authbind.
(Reading database ... 58205 files and directories currently installed.)(Reading database ... 100%(Reading database ... 95%(Reading database ... 90%(Reading database ... 85%(Reading database ... 80%(Reading dat
Preparing to unpack .../00-authbind_2.1.3_amd64.deb ...
Unpacking authbind (2.1.3) ...
Selecting previously unselected package javascript-common.
Preparing to unpack .../01-javascript-common_11+nmu1_all.deb ...
Unpacking javascript-common (11+nmu1) ...
Selecting previously unselected package libexpat1-dev:amd64.
Preparing to unpack .../02-libexpat1-dev_2.5.0-1_amd64.deb ...
Unpacking libexpat1-dev:amd64 (2.5.0-1) ...
Selecting previously unselected package libffi-dev:amd64.
Preparing to unpack .../03-libffi-dev_3.4.4-1_amd64.deb ...
Unpacking libffi-dev:amd64 (3.4.4-1) ...
Selecting previously unselected package libjs-jquery.
Preparing to unpack .../04-libjs-jquery_3.6.1+dfsg+~3.5.14-1_all.deb ...
Unpacking libjs-jquery (3.6.1+dfsg+~3.5.14-1) ...
Selecting previously unselected package libjs-underscore.
Preparing to unpack .../05-libjs-underscore_1.13.4~dfsg+~1.11.4-3_all.deb ...
Unpacking libjs-underscore (1.13.4~dfsg+~1.11.4-3) ...
Selecting previously unselected package libjs-sphinxdoc.
Preparing to unpack .../06-libjs-sphinxdoc_5.3.0-4_all.deb ...
Unpacking libjs-sphinxdoc (5.3.0-4) ...
Selecting previously unselected package libpython3.11:amd64.
Preparing to unpack .../07-libpython3.11_3.11.2-6_amd64.deb ...
Unpacking libpython3.11:amd64 (3.11.2-6) ...
Selecting previously unselected package zlib1g-dev:amd64.
Preparing to unpack .../08-zlib1g-dev_1%3a1.2.13.dfsg-1_amd64.deb ...
Unpacking zlib1g-dev:amd64 (1:1.2.13.dfsg-1) ...
Selecting previously unselected package libpython3.11-dev:amd64.
Preparing to unpack .../09-libpython3.11-dev_3.11.2-6_amd64.deb ...
Unpacking libpython3.11-dev:amd64 (3.11.2-6) ...
Selecting previously unselected package libpython3-dev:amd64.
Preparing to unpack .../10-libpython3-dev_3.11.2-1+b1_amd64.deb ...
Unpacking libpython3-dev:amd64 (3.11.2-1+b1) ...
Selecting previously unselected package libssl-dev:amd64.
Preparing to unpack .../11-libssl-dev_3.0.11-1~deb12u2_amd64.deb ...
Unpacking libssl-dev:amd64 (3.0.11-1~deb12u2) ...
Selecting previously unselected package python3.11-dev.
Preparing to unpack .../12-python3.11-dev_3.11.2-6_amd64.deb ...
Unpacking python3.11-dev (3.11.2-6) ...
Selecting previously unselected package python3-lib2to3.
Preparing to unpack .../13-python3-lib2to3_3.11.2-3_all.deb ...
Unpacking python3-lib2to3 (3.11.2-3) ...
Selecting previously unselected package python3-distutils.
Preparing to unpack .../14-python3-distutils_3.11.2-3_all.deb ...
Unpacking python3-distutils (3.11.2-3) ...
Selecting previously unselected package python3-dev.
Preparing to unpack .../15-python3-dev_3.11.2-1+b1_amd64.deb ...
Unpacking python3-dev (3.11.2-1+b1) ...
Selecting previously unselected package python3-distlib.
Preparing to unpack .../16-python3-distlib_0.3.6-1_all.deb ...
Unpacking python3-distlib (0.3.6-1) ...
Selecting previously unselected package python3-filelock.
Preparing to unpack .../17-python3-filelock_3.9.0-1_all.deb ...
Unpacking python3-filelock (3.9.0-1) ...
Selecting previously unselected package python3-pip-whl.
Preparing to unpack .../18-python3-pip-whl_23.0.1+dfsg-1_all.deb ...
Unpacking python3-pip-whl (23.0.1+dfsg-1) ...
Selecting previously unselected package python3-platformdirs.
Preparing to unpack .../19-python3-platformdirs_2.6.0-1_all.deb ...
Unpacking python3-platformdirs (2.6.0-1) ...
Selecting previously unselected package python3-setuptools-whl.
Preparing to unpack .../20-python3-setuptools-whl_66.1.1-1_all.deb ...
Unpacking python3-setuptools-whl (66.1.1-1) ...
Selecting previously unselected package python3-wheel-whl.
Preparing to unpack .../21-python3-wheel-whl_0.38.4-2_all.deb ...
Unpacking python3-wheel-whl (0.38.4-2) ...
Selecting previously unselected package python3-virtualenv.
Preparing to unpack .../22-python3-virtualenv_20.17.1+ds-1_all.deb ...
Unpacking python3-virtualenv (20.17.1+ds-1) ...
Selecting previously unselected package virtualenv.
Preparing to unpack .../23-virtualenv_20.17.1+ds-1_all.deb ...
Unpacking virtualenv (20.17.1+ds-1) ...
Setting up javascript-common (11+nmu1) ...
Setting up python3-setuptools-whl (66.1.1-1) ...
Setting up python3-filelock (3.9.0-1) ...
Setting up libpython3.11:amd64 (3.11.2-6) ...
Setting up authbind (2.1.3) ...
Setting up python3-pip-whl (23.0.1+dfsg-1) ...
Setting up python3-distlib (0.3.6-1) ...
Setting up libffi-dev:amd64 (3.4.4-1) ...
Setting up python3-platformdirs (2.6.0-1) ...
Setting up libexpat1-dev:amd64 (2.5.0-1) ...
Setting up libssl-dev:amd64 (3.0.11-1~deb12u2) ...
Setting up zlib1g-dev:amd64 (1:1.2.13.dfsg-1) ...
Setting up libjs-jquery (3.6.1+dfsg+~3.5.14-1) ...
Setting up python3-lib2to3 (3.11.2-3) ...
Setting up python3-wheel-whl (0.38.4-2) ...
Setting up libjs-underscore (1.13.4~dfsg+~1.11.4-3) ...
Setting up python3-distutils (3.11.2-3) ...
Setting up python3-virtualenv (20.17.1+ds-1) ...
Setting up libpython3.11-dev:amd64 (3.11.2-6) ...
Setting up virtualenv (20.17.1+ds-1) ...
Setting up libjs-sphinxdoc (5.3.0-4) ...
Setting up libpython3-dev:amd64 (3.11.2-1+b1) ...
Setting up python3.11-dev (3.11.2-6) ...
Setting up python3-dev (3.11.2-1+b1) ...
Processing triggers for man-db (2.11.2-2) ...
Processing triggers for libc-bin (2.36-9+deb12u3) ...
vagrant@red:~$

vagrant@red:~$ sudo adduser --disabled-password cowriesudo adduser --disabled-password cowrie
Adding user `cowrie' ...
Adding new group `cowrie' (1001) ...
Adding new user `cowrie' (1001) with group `cowrie (1001)' ...
Creating home directory `/home/cowrie' ...
Copying files from `/etc/skel' ...
Changing the user information for cowrie
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] y
Adding new user `cowrie' to supplemental / extra groups `users' ...
Adding user `cowrie' to group `users' ...
vagrant@red:~$ sudo su - cowriesudo su - cowrie
cowrie@red:~$ sudo su - cowrie^C
cowrie@red:~$ git clone http://github.com/cowrie/cowriegit clone http://github.com/cowrie/cowrie
Cloning into 'cowrie'...
warning: redirecting to https://github.com/cowrie/cowrie/
remote: Enumerating objects: 17115, done.
remote: Counting objects: 100% (1760/1760), done.
remote: Compressing objects: 100% (327/327), done.
remote: Total 17115 (delta 1597), reused 1486 (delta 1433), pack-reused 15355
Receiving objects: 100% (17115/17115), 9.77 MiB | 11.23 MiB/s, done.Receiving objects: 100% (17115/17115), 6.42 MiB | 12.85 MiB/s
Resolving deltas: 100% (12068/12068), done.Resolving deltas: 100% (12068/12068)Resolving deltas:  99% (11948/12068)Resolving deltas:  98% (11827/12068)Resolving deltas:  97% (11706/12068)Resolving deltas:  96%
cowrie@red:~$



[walt@companyrouter etc]$ ssh -p 2222 benny@192.168.100.166
The authenticity of host '[192.168.100.166]:2222 ([192.168.100.166]:2222)' can't be established.
ED25519 key fingerprint is SHA256:T11xQ7ZTYOKNQ1TpWe21QW1hXjUoCXxCYxlSIgpgXeE.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[192.168.100.166]:2222' (ED25519) to the list of known hosts.
benny@192.168.100.166's password:
Permission denied, please try again.
benny@192.168.100.166's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
benny@companyrouter:~$ ifconfig
eth0      Link encap:Ethernet  HWaddr b3:20:2f:b9:9a:20
          inet addr:192.168.100.166  Bcast:192.168.100.255  Mask:255.255.255.0
          inet6 addr: fe03::120:38ff:fe0f:0101/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:343405 errors:0 dropped:0 overruns:0 frame:0
          TX packets:527788 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:167092243 (167.1 MB)  TX bytes:53062407 (53.1 MB)


lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:110 errors:0 dropped:0 overruns:0 frame:0
          TX packets:110 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:42543646 (42.5 MB)  TX bytes:42543646 (42.5 MB)
benny@companyrouter:~$ w
 17:09:53 up 1 min,  1 user,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
benny    pts/0    192.168.100.253   17:09    0.00s  0.00s  0.00s w
benny@companyrouter:~$ last
benny    pts/0        192.168.100.253  Fri Jan 05 17:09   still logged in

wtmp begins Fri Jan 05 00:01:03 2024


(cowrie-env) cowrie@red:~/cowrie/var/log/cowrie$ ls -al
total 24
drwxr-xr-x 2 cowrie cowrie 4096 Jan  5 17:08 .
drwxr-xr-x 3 cowrie cowrie 4096 Jan  5 16:58 ..
-rw-r--r-- 1 cowrie cowrie  727 Jan  5 17:09 audit.log
-rw-rw-r-- 1 cowrie cowrie 3905 Jan  5 17:09 cowrie.json
-rw-r--r-- 1 cowrie cowrie 4389 Jan  5 17:09 cowrie.log
-rw-r--r-- 1 cowrie cowrie    0 Jan  5 16:58 .gitignore
(cowrie-env) cowrie@red:~/cowrie/var/log/cowrie$ cat audit.log
2024-01-05T17:09:34.399033Z b000d7bfbc93 New connection: 192.168.100.253:55730 (192.168.100.166:2222) [session: b000d7bfbc93]
2024-01-05T17:09:34.399615Z b000d7bfbc93 Remote SSH version: SSH-2.0-OpenSSH_8.7
2024-01-05T17:09:34.401697Z b000d7bfbc93 SSH client hassh fingerprint: b50f8371fb780ca7060e53c0b2cf6172
2024-01-05T17:09:39.371634Z b000d7bfbc93 login attempt [benny/teest] failed
2024-01-05T17:09:42.101081Z b000d7bfbc93 login attempt [benny/benny] succeeded
2024-01-05T17:09:42.134866Z b000d7bfbc93 Terminal Size: 209 52
2024-01-05T17:09:42.136197Z b000d7bfbc93 ()
2024-01-05T17:09:46.619325Z b000d7bfbc93 CMD: ifconfig
2024-01-05T17:09:53.822309Z b000d7bfbc93 CMD: w
2024-01-05T17:09:57.690865Z b000d7bfbc93 CMD: last
(cowrie-env) cowrie@red:~/cowrie/var/log/cowrie$ cat cowrie.log
2024-01-05T17:08:22.318565Z [-] Python Version 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0]
2024-01-05T17:08:22.318597Z [-] Twisted Version 23.10.0
2024-01-05T17:08:22.318608Z [-] Cowrie Version 2.5.0
2024-01-05T17:08:22.325141Z [-] Loaded output engine: jsonlog
2024-01-05T17:08:22.326904Z [-] Loaded output engine: textlog
2024-01-05T17:08:22.327708Z [twisted.scripts._twistd_unix.UnixAppLogger#info] twistd 23.10.0 (/home/cowrie/cowrie-env/bin/python 3.11.2) starting up.
2024-01-05T17:08:22.327767Z [twisted.scripts._twistd_unix.UnixAppLogger#info] reactor class: twisted.internet.epollreactor.EPollReactor.
2024-01-05T17:08:22.332071Z [-] CowrieSSHFactory starting on 2222
2024-01-05T17:08:22.332603Z [cowrie.ssh.factory.CowrieSSHFactory#info] Starting factory <cowrie.ssh.factory.CowrieSSHFactory object at 0x7f95c21a8990>
2024-01-05T17:08:22.332932Z [-] Generating new RSA keypair...
2024-01-05T17:08:22.397950Z [-] Generating new ECDSA keypair...
2024-01-05T17:08:22.399632Z [-] Generating new ed25519 keypair...
2024-01-05T17:08:22.407673Z [-] Ready to accept SSH connections
2024-01-05T17:09:34.399033Z [cowrie.ssh.factory.CowrieSSHFactory] New connection: 192.168.100.253:55730 (192.168.100.166:2222) [session: b000d7bfbc93]
2024-01-05T17:09:34.399615Z [HoneyPotSSHTransport,0,192.168.100.253] Remote SSH version: SSH-2.0-OpenSSH_8.7
2024-01-05T17:09:34.401697Z [HoneyPotSSHTransport,0,192.168.100.253] SSH client hassh fingerprint: b50f8371fb780ca7060e53c0b2cf6172
2024-01-05T17:09:34.402547Z [cowrie.ssh.transport.HoneyPotSSHTransport#debug] kex alg=b'curve25519-sha256' key alg=b'ssh-ed25519'
2024-01-05T17:09:34.402605Z [cowrie.ssh.transport.HoneyPotSSHTransport#debug] outgoing: b'aes256-ctr' b'hmac-sha2-256' b'none'
2024-01-05T17:09:34.402657Z [cowrie.ssh.transport.HoneyPotSSHTransport#debug] incoming: b'aes256-ctr' b'hmac-sha2-256' b'none'
2024-01-05T17:09:36.161212Z [cowrie.ssh.transport.HoneyPotSSHTransport#debug] NEW KEYS
2024-01-05T17:09:36.162247Z [cowrie.ssh.transport.HoneyPotSSHTransport#debug] starting service b'ssh-userauth'
2024-01-05T17:09:36.163163Z [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' trying auth b'none'
2024-01-05T17:09:39.370814Z [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' trying auth b'password'
2024-01-05T17:09:39.371634Z [HoneyPotSSHTransport,0,192.168.100.253] login attempt [b'benny'/b'teest'] failed
2024-01-05T17:09:40.373635Z [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' failed auth b'password'
2024-01-05T17:09:40.373810Z [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] unauthorized login: ()
2024-01-05T17:09:42.100721Z [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' trying auth b'password'
2024-01-05T17:09:42.101081Z [HoneyPotSSHTransport,0,192.168.100.253] login attempt [b'benny'/b'benny'] succeeded
2024-01-05T17:09:42.101421Z [HoneyPotSSHTransport,0,192.168.100.253] Initialized emulated server as architecture: linux-x64-lsb
2024-01-05T17:09:42.112864Z [cowrie.ssh.userauth.HoneyPotSSHUserAuthServer#debug] b'benny' authenticated with b'password'
2024-01-05T17:09:42.113067Z [cowrie.ssh.transport.HoneyPotSSHTransport#debug] starting service b'ssh-connection'
2024-01-05T17:09:42.114200Z [cowrie.ssh.connection.CowrieSSHConnection#debug] got channel b'session' request
2024-01-05T17:09:42.114358Z [cowrie.ssh.session.HoneyPotSSHSession#info] channel open
2024-01-05T17:09:42.114429Z [cowrie.ssh.connection.CowrieSSHConnection#debug] got global b'no-more-sessions@openssh.com' request
2024-01-05T17:09:42.134732Z [twisted.conch.ssh.session#info] Handling pty request: b'xterm-256color' (52, 209, 640, 480)
2024-01-05T17:09:42.134866Z [SSHChannel session (0) on SSHService b'ssh-connection' on HoneyPotSSHTransport,0,192.168.100.253] Terminal Size: 209 52
2024-01-05T17:09:42.135265Z [twisted.conch.ssh.session#info] Getting shell
2024-01-05T17:09:46.619325Z [HoneyPotSSHTransport,0,192.168.100.253] CMD: ifconfig
2024-01-05T17:09:46.619738Z [HoneyPotSSHTransport,0,192.168.100.253] Command found: ifconfig
2024-01-05T17:09:53.822309Z [HoneyPotSSHTransport,0,192.168.100.253] CMD: w
2024-01-05T17:09:53.822756Z [HoneyPotSSHTransport,0,192.168.100.253] Command found: w
2024-01-05T17:09:57.690865Z [HoneyPotSSHTransport,0,192.168.100.253] CMD: last
2024-01-05T17:09:57.691365Z [HoneyPotSSHTransport,0,192.168.100.253] Command found: last
(cowrie-env) cowrie@red:~/cowrie/var/log/cowrie$ cat cowrie.json
{"eventid":"cowrie.session.connect","src_ip":"192.168.100.253","src_port":55730,"dst_ip":"192.168.100.166","dst_port":2222,"session":"b000d7bfbc93","protocol":"ssh","message":"New connection: 192.168.100.253:55730 (192.168.100.166:2222) [session: b000d7bfbc93]","sensor":"red","timestamp":"2024-01-05T17:09:34.399033Z"}
{"eventid":"cowrie.client.version","version":"SSH-2.0-OpenSSH_8.7","message":"Remote SSH version: SSH-2.0-OpenSSH_8.7","sensor":"red","timestamp":"2024-01-05T17:09:34.399615Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.client.kex","hassh":"b50f8371fb780ca7060e53c0b2cf6172","hasshAlgorithms":"curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,ext-info-c;aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes128-gcm@openssh.com,aes128-ctr;hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha1,umac-128@openssh.com,hmac-sha2-512;none,zlib@openssh.com,zlib","kexAlgs":["curve25519-sha256","curve25519-sha256@libssh.org","ecdh-sha2-nistp256","ecdh-sha2-nistp384","ecdh-sha2-nistp521","diffie-hellman-group-exchange-sha256","diffie-hellman-group14-sha256","diffie-hellman-group16-sha512","diffie-hellman-group18-sha512","ext-info-c"],"keyAlgs":["ssh-ed25519-cert-v01@openssh.com","ecdsa-sha2-nistp256-cert-v01@openssh.com","ecdsa-sha2-nistp384-cert-v01@openssh.com","ecdsa-sha2-nistp521-cert-v01@openssh.com","sk-ssh-ed25519-cert-v01@openssh.com","sk-ecdsa-sha2-nistp256-cert-v01@openssh.com","rsa-sha2-512-cert-v01@openssh.com","rsa-sha2-256-cert-v01@openssh.com","ssh-ed25519","ecdsa-sha2-nistp256","ecdsa-sha2-nistp384","ecdsa-sha2-nistp521","sk-ssh-ed25519@openssh.com","sk-ecdsa-sha2-nistp256@openssh.com","rsa-sha2-512","rsa-sha2-256"],"encCS":["aes256-gcm@openssh.com","chacha20-poly1305@openssh.com","aes256-ctr","aes128-gcm@openssh.com","aes128-ctr"],"macCS":["hmac-sha2-256-etm@openssh.com","hmac-sha1-etm@openssh.com","umac-128-etm@openssh.com","hmac-sha2-512-etm@openssh.com","hmac-sha2-256","hmac-sha1","umac-128@openssh.com","hmac-sha2-512"],"compCS":["none","zlib@openssh.com","zlib"],"langCS":[""],"message":"SSH client hassh fingerprint: b50f8371fb780ca7060e53c0b2cf6172","sensor":"red","timestamp":"2024-01-05T17:09:34.401697Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.login.failed","username":"benny","password":"teest","message":"login attempt [benny/teest] failed","sensor":"red","timestamp":"2024-01-05T17:09:39.371634Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.login.success","username":"benny","password":"benny","message":"login attempt [benny/benny] succeeded","sensor":"red","timestamp":"2024-01-05T17:09:42.101081Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.client.size","width":209,"height":52,"message":"Terminal Size: 209 52","sensor":"red","timestamp":"2024-01-05T17:09:42.134866Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.session.params","arch":"linux-x64-lsb","message":[],"sensor":"red","timestamp":"2024-01-05T17:09:42.136197Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.command.input","input":"ifconfig","message":"CMD: ifconfig","sensor":"red","timestamp":"2024-01-05T17:09:46.619325Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.command.input","input":"w","message":"CMD: w","sensor":"red","timestamp":"2024-01-05T17:09:53.822309Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}
{"eventid":"cowrie.command.input","input":"last","message":"CMD: last","sensor":"red","timestamp":"2024-01-05T17:09:57.690865Z","src_ip":"192.168.100.253","session":"b000d7bfbc93"}



vagrant@red:~$ hydra -I -l root -s 2222 -t 3 -P SecLists/Passwords/xato-net-10-million-passwords-100000.txt ssh://192.168.100.166
Hydra v9.4 (c) 2022 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).


vagrant@red:~$ hydra -I -l root -s 2222 -t 3 -P SecLists/Passwords/xato-net-10-million-passwords-100000.txt ssh://192.168.100.166
Hydra v9.4 (c) 2022 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2024-01-05 17:18:29
[WARNING] Restorefile (ignored ...) from a previous session found, to prevent overwriting, ./hydra.restore
[DATA] max 3 tasks per 1 server, overall 3 tasks, 100000 login tries (l:1/p:100000), ~33334 tries per task
[DATA] attacking ssh://192.168.100.166:2222/
[STATUS] 84.00 tries/min, 84 tries in 00:01h, 99916 to do in 19:50h, 3 active
[STATUS] 81.00 tries/min, 243 tries in 00:03h, 99757 to do in 20:32h, 3 active





***Once configured and up and running, verify that you can still SSH to the router normally, using port 2222.***

***Attack your router and try to SSH normally. What do you notice?***

***What credentials work? Do you find credentials that don't work?***

***Do you get a shell?***

***Are your commands logged? Is the IP address of the SSH client logged? If this is the case, where?***

***Can an attacker perform malicious things?***

***Are the actions, in other words the commands, logged to a file? Which file?***

***If you are an experienced hacker, how would/can you realize this is not a normal environment?***

### Critical thinking (security) when using "Docker as a service"

***If you decided to run cowrie by using a docker container, you've made the decision to use docker as a "deployment method" of a service or application. Some people in the industry refer to this phenomena as "docker as a service". Try to think, research and answer the following questions when it comes to running services, daemons and programs using docker:***

***What are some (at least 2) advantages of running services (for example cowrie but it could be sql server as well) using docker?***

***What could be a disadvantage? Give at least 1.***

***Explain what is meant with "Docker uses a client-server architecture."***

***As which user is the docker daemon running by default? Tip: <https://docs.docker.com/engine/install/linux-postinstall/>***

`root, I've added walt to the docker group`

***What could be an advantage of running a honeypot inside a virtual machine compared to running it inside a container?***

### Other honeypots

If you want to experiment more with honeypots, have a look at the following list for inspiration: <https://github.com/paralax/awesome-honeypots> .

You don't have to implement them but have a look and answer the following questions:

What type of honeypot is "honeyup"?
What is the idea behind "opencanary"?
Is a HTTP(S) honeypot a good idea? Why or why not?



`èxtra: endlessh`

```code
[walt@companyrouter ~]$ sudo dnf install -yq git

Installed:
  emacs-filesystem-1:27.2-9.el9.noarch      git-2.39.3-1.el9_2.x86_64              git-core-2.39.3-1.el9_2.x86_64
  git-core-doc-2.39.3-1.el9_2.noarch        perl-Error-1:0.17029-7.el9.noarch      perl-Git-2.39.3-1.el9_2.noarch

[walt@companyrouter ~]$ git clone https://github.com/skeeto/endlessh.git
Cloning into 'endlessh'...
remote: Enumerating objects: 346, done.
remote: Counting objects: 100% (144/144), done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 346 (delta 133), reused 130 (delta 130), pack-reused 202
Receiving objects: 100% (346/346), 68.51 KiB | 2.36 MiB/s, done.
Resolving deltas: 100% (211/211), done.

sudo dnf install -yq make
sudo dnf install -yq gcc

```

