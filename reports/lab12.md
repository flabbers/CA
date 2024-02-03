# Week 12

## Theory

- Linux hardening (high level overview)
  - <https://linuxsecurity.expert/checklists/linux-security-and-system-hardening>
- What are the CIS Benchmarks? Why do they exist? how can they be used? What do they tell?
  - <https://learn.cisecurity.org/benchmarks> (free)
- What is OpenSCAP? What can it do?
  - <https://www.open-scap.org/>
- What is Lynis?
  - <https://github.com/CISOfy/lynis/>
- What is the Microsoft Security Compliance Toolkit?
  - <https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/security-compliance-toolkit-10>
- What is the Docker Bench for Security?
  - <https://github.com/docker/docker-bench-security>
- What does <https://dev-sec.io/> offer? Where do they differ from the other hardening guides?
- Extra: The Practical Linux Hardening Guide (technical!)
  - <https://github.com/trimstray/the-practical-linux-hardening-guide/wiki>

## Lab

### Ansible

***"System hardening" is defined as a set of best practices, tools and/or techniques to reduce security risk as much as possible. In security terms people talk about "eliminating potential attack vectors and condensing the system's attack surface".***

***Ansible is a powerfull tool to configure systems in an automated way. Imagine deploying sysmon and wazuh agents to Windows and Linux clients manually over and over again. This seems like a perfect job for some ansible playbooks.***

***Because installing ansible on Windows is not supported we suggest to install ansible on your companyrouter. Follow the official installation instructions found over here. We suggest to use pip: <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>***

```code
[walt@companyrouter ~]$ sudo useradd -m -s /bin/bash -p "$(openssl passwd -1 'ansible')" ansible
[walt@companyrouter ~]$ sudo su - ansible
[ansible@companyrouter ~]$ pip install ansible
Defaulting to user installation because normal site-packages is not writeable
Collecting ansible
  Downloading ansible-8.7.0-py3-none-any.whl (48.4 MB)
     |████████████████████████████████| 48.4 MB 198 kB/s
Collecting ansible-core~=2.15.7
  Downloading ansible_core-2.15.8-py3-none-any.whl (2.2 MB)
     |████████████████████████████████| 2.2 MB 20.5 MB/s
Collecting jinja2>=3.0.0
  Downloading Jinja2-3.1.2-py3-none-any.whl (133 kB)
     |████████████████████████████████| 133 kB 31.0 MB/s
Collecting packaging
  Downloading packaging-23.2-py3-none-any.whl (53 kB)
     |████████████████████████████████| 53 kB 2.4 MB/s
Collecting importlib-resources<5.1,>=5.0
  Downloading importlib_resources-5.0.7-py3-none-any.whl (24 kB)
Collecting resolvelib<1.1.0,>=0.5.3
  Downloading resolvelib-1.0.1-py2.py3-none-any.whl (17 kB)
Collecting cryptography
  Downloading cryptography-41.0.7-cp37-abi3-manylinux_2_28_x86_64.whl (4.4 MB)
     |████████████████████████████████| 4.4 MB 26.9 MB/s
Requirement already satisfied: PyYAML>=5.1 in /usr/lib64/python3.9/site-packages (from ansible-core~=2.15.7->ansible) (5.4.1)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.1.3-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (25 kB)
Collecting cffi>=1.12
  Downloading cffi-1.16.0-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (443 kB)
     |████████████████████████████████| 443 kB 20.5 MB/s
Collecting pycparser
  Downloading pycparser-2.21-py2.py3-none-any.whl (118 kB)
     |████████████████████████████████| 118 kB 21.3 MB/s
Installing collected packages: pycparser, MarkupSafe, cffi, resolvelib, packaging, jinja2, importlib-resources, cryptography, ansible-core, ansible
  WARNING: Value for scheme.platlib does not match. Please report this to <https://github.com/pypa/pip/issues/10151>
  distutils: /home/ansible/.local/lib/python3.9/site-packages
  sysconfig: /home/ansible/.local/lib64/python3.9/site-packages
  WARNING: Additional context:
  user = True
  home = None
  root = None
  prefix = None
Successfully installed MarkupSafe-2.1.3 ansible-8.7.0 ansible-core-2.15.8 cffi-1.16.0 cryptography-41.0.7 importlib-resources-5.0.7 jinja2-3.1.2 packaging-23.2 pycparser-2.21 resolvelib-1.0.1
[ansible@companyrouter ~]$ ansible --version
ansible [core 2.15.8]
  config file = None
  configured module search path = ['/home/ansible/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ansible/.local/lib/python3.9/site-packages/ansible
  ansible collection location = /home/ansible/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/ansible/.local/bin/ansible
  python version = 3.9.18 (main, Sep  7 2023, 00:00:00) [GCC 11.4.1 20230605 (Red Hat 11.4.1-2)] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```

***Start of by creating a seperate SSH keypair specifically for ansible (we recommend to also create a seperate ansible user) and copy over the correct (public or private?) key to the remote locations (which file holds this key on the remote machine?). You can use the vagrant user the first time for creating the ansible user if you do not want to do this manually.***

```code
[ansible@companyrouter ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ansible/.ssh/id_rsa):
Created directory '/home/ansible/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ansible/.ssh/id_rsa
Your public key has been saved in /home/ansible/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:ssmoLYYs9+ErbFex4uXmJ7KLEGQK9JiXbWOQeEvAZuI ansible@companyrouter
The key's randomart image is:
+---[RSA 3072]----+
|.oo..            |
|o=+++            |
|*=o+.=           |
|=E..o o          |
|o     .oS        |
| .  .o++         |
|oo .o=+          |
|ooB=+.+ .        |
|.+o=BB.o         |
+----[SHA256]-----+
```

***Create an inventory file containing the machines in your environment. Below is an example inventory file. Feel free to extend this. The name between brackets is a group. The name below such brackets is the hostname (or IP). When using [name:vars] it is possible to define extra variables (or settings) for a specific group. Do you notice what protocol is used to authenticate with Windows in this case? What protocol is used for the other machines?***

```code
[companyrouter]
localhost

[dc]
172.30.0.4

[dc:vars]
ansible_user=vagrant
ansible_password=vagrant
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore

[web]
web

[database]
database

[linux]
companyrouter
web
database

[windowsclients]
#TODO
```

```code
[ansible@companyrouter ~]$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXuip0zlIuuTzCW76foIGIkLdI9D5WE/TmfR8O0WnM7NxxWnwIy+zlggkmQ64DK7laIFecdSe7s6oE/gL0hJqSU/l1ECMeUQHc8vNFDYbED48IGIU96icVpPDXTcqZKg4y5/f9F+XpzIrdmBNx94ODWVUsLOQt1tR97fFSzMxuk1+VXp5s9cPgaTMPs9gamy9+l1+FdwusrAp2wwbrTjJCuWrD6WJDsFyY2mvVZnzTNszln+k8/IZ6bTK7Nkd2XgV1fCYTFaslRTs95bkVuzTW8N4pqCt/U4rDhzSvVKNnTlrF8ooSRf/9ZNLJVw4kIp878VVqCPTVFjk4DFfyWNILELS2sX1AtnBSWtp0OWXEModqXlaU9dTEYK7yaRt4u6+Io4hwujBDvt5CYIjpnIVyaDuMDL7oOwEKMSV+X9wY7qIVH3CTckYQpcfHPFjhL0fRPhVpOgUSF1MJsbVO75NxfCfkVuZ+TCqKDtVmulRGgcxkpJo1i1LIKZIyTmhZ0DM= ansible@companyrouter
[ansible@companyrouter ~]$ cat > ~/.ssh/config <<EOF
> Host 172.30.*.*, web
>   StrictHostKeyChecking no
>   UserKnownHostsFile /home/ansible/.ssh/known_hosts
> EOF
```

```code
sudo useradd -m -s /bin/bash -p "$(openssl passwd -1 'ansible')" ansible
sudo cp /etc/sudoers.d/vagrant /etc/sudoers.d/ansible
sudo sed -i 's/vagrant/ansible/g' /etc/sudoers.d/ansible
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXuip0zlIuuTzCW76foIGIkLdI9D5WE/TmfR8O0WnM7NxxWnwIy+zlggkmQ64DK7laIFecdSe7s6oE/gL0hJqSU/l1ECMeUQHc8vNFDYbED48IGIU96icVpPDXTcqZKg4y5/f9F+XpzIrdmBNx94ODWVUsLOQt1tR97fFSzMxuk1+VXp5s9cPgaTMPs9gamy9+l1+FdwusrAp2wwbrTjJCuWrD6WJDsFyY2mvVZnzTNszln+k8/IZ6bTK7Nkd2XgV1fCYTFaslRTs95bkVuzTW8N4pqCt/U4rDhzSvVKNnTlrF8ooSRf/9ZNLJVw4kIp878VVqCPTVFjk4DFfyWNILELS2sX1AtnBSWtp0OWXEModqXlaU9dTEYK7yaRt4u6+Io4hwujBDvt5CYIjpnIVyaDuMDL7oOwEKMSV+X9wY7qIVH3CTckYQpcfHPFjhL0fRPhVpOgUSF1MJsbVO75NxfCfkVuZ+TCqKDtVmulRGgcxkpJo1i1LIKZIyTmhZ0DM= ansible@companyrouter' > ~/tmp_keys
sudo mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo mv ~/tmp_keys /home/ansible/.ssh/authorized_keys
sudo chmod 600 ~/.ssh/authorized_keys
sudo chown ansible:ansible -R /home/ansible
```

```code
host=("web database")
for host in $hosts; do ssh-keyscan -t ed25519 -H "$hosts" >> /home/ansible/.ssh/known_hosts ; done
```

```code
[ansible@companyrouter ~]$ ssh web
The authenticity of host 'web (172.30.20.10)' can't be established.
ED25519 key fingerprint is SHA256:IusIBm57xYHE7POtfDHH+0HZcOD+1eo0heqtMciLZP8.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? ^C
[ansible@companyrouter ~]$ ssh web
The authenticity of host 'web (172.30.20.10)' can't be established.
ED25519 key fingerprint is SHA256:IusIBm57xYHE7POtfDHH+0HZcOD+1eo0heqtMciLZP8.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? ^C
[ansible@companyrouter ~]$ nano ~/.ssh/config
[ansible@companyrouter ~]$ ssh web whoami
Warning: Permanently added 'web' (ED25519) to the list of known hosts.
ansible
[ansible@companyrouter ~]$ ssh web sudo whoami
root
[ansible@companyrouter ~]$
```

***After setting up your keys, and after performing some potential troubleshooting, the following examples should work.***

***Note/tip: maybe you have to tell ansible some information about your SSH-keys. This can be done with an extra argument or in the ansible configuration.***

```code
ansible -i inventory -m "win_ping" dc
ansible -i inventory -m "win_shell" -a "hostname" dc
ansible -i inventory -m "ping" linux
```

***Configure and test out the following use cases. In theory you could do it on all systems but if you have memory issues limit the number of clients in your ansible command or in the inventory file.***

```code
[ansible@companyrouter ~]$ cat inventory
[all:vars]
ansible_user=ansible
#ansible_password=vagrant
#ansible_connection=winrm
#ansible_winrm_server_cert_validation=ignore
ansible_ssh_private_key_file=/home/ansible/.ssh/id_rsa

[linux]
web
database


[ansible@companyrouter ~]$ ansible -i inventory -m "ping" linux
web | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
database | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: ssh: connect to host database port 22: No route to host",
    "unreachable": true
}


```

```code
cat > addansible.sh <<EOF
sudo useradd -m -s /bin/bash -p "$(openssl passwd -1 'ansible')" ansible
sudo cp /etc/sudoers.d/vagrant /etc/sudoers.d/ansible
sudo sed -i 's/vagrant/ansible/g' /etc/sudoers.d/ansible
sudo echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXuip0zlIuuTzCW76foIGIkLdI9D5WE/TmfR8O0WnM7NxxWnwIy+zlggkmQ64DK7laIFecdSe7s6oE/gL0hJqSU/l1ECMeUQHc8vNFDYbED48IGIU96icVpPDXTcqZKg4y5/f9F+XpzIrdmBNx94ODWVUsLOQt1tR97fFSzMxuk1+VXp5s9cPgaTMPs9gamy9+l1+FdwusrAp2wwbrTjJCuWrD6WJDsFyY2mvVZnzTNszln+k8/IZ6bTK7Nkd2XgV1fCYTFaslRTs95bkVuzTW8N4pqCt/U4rDhzSvVKNnTlrF8ooSRf/9ZNLJVw4kIp878VVqCPTVFjk4DFfyWNILELS2sX1AtnBSWtp0OWXEModqXlaU9dTEYK7yaRt4u6+Io4hwujBDvt5CYIjpnIVyaDuMDL7oOwEKMSV+X9wY7qIVH3CTckYQpcfHPFjhL0fRPhVpOgUSF1MJsbVO75NxfCfkVuZ+TCqKDtVmulRGgcxkpJo1i1LIKZIyTmhZ0DM= ansible@companyrouter' | sudo tee -a /home/ansible/tmp_keys
sudo mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo mv /home/ansible/tmp_keys /home/ansible/.ssh/authorized_keys
sudo chmod 600 ~/.ssh/authorized_keys
sudo chown ansible:ansible -R /home/ansible
EOF

chmod +x addansible.sh

. ./addansible.sh
```

```code
[ansible@companyrouter ~]$ cat ~/.ssh/config
Host 172.30.*.*, web, database
  StrictHostKeyChecking no
  UserKnownHostsFile /home/ansible/.ssh/known_hosts

[ansible@companyrouter ~]$ ansible -i inventory -m "ping" linux
database | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
web | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

```code
[ansible@companyrouter ~]$ ansible -i inventory -m "win_ping" dc
The authenticity of host 'dc (172.30.0.4)' can't be established.
ED25519 key fingerprint is SHA256:MOaA3iE5lwkAKQCvWllY5Z+lEfUFq+iV5Q1dP+ethig.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
dc | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to create temporary directory. In some cases, you may have been able to authenticate and did not have permissions on the target directory. Consider changing the remote tmp path in ansible.cfg to a path rooted in \"/tmp\", for more error information use -vvv. Failed command was: ( umask 77 && mkdir -p \"` echo ~/.ansible/tmp `\"&& mkdir \"` echo ~/.ansible/tmp/ansible-tmp-1704830805.355975-3372-168469460313846 `\" && echo ansible-tmp-1704830805.355975-3372-168469460313846=\"` echo ~/.ansible/tmp/ansible-tmp-1704830805.355975-3372-168469460313846 `\" ), exited with result 1",
    "unreachable": true
}
[ansible@companyrouter ~]$ nano inventory
[ansible@companyrouter ~]$ ansible -i inventory -m "win_ping" dc
dc | FAILED! => {
    "msg": "winrm or requests is not installed: No module named 'winrm'"
}
[ansible@companyrouter ~]$ nano inventory
[ansible@companyrouter ~]$ ansible -i inventory -m "win_ping" dc
dc | FAILED! => {
    "msg": "to use the 'ssh' connection type with passwords or pkcs11_provider, you must install the sshpass program"

[ansible@companyrouter ~]$ sudo dnf install -yq sshpass

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for ansible:
sudo: a password is required
[ansible@companyrouter ~]$ su - walt
Password:
Last login: Tue Jan  9 20:00:40 UTC 2024 from 192.168.100.1 on pts/0
[walt@companyrouter ~]$ sudo dnf install -yq sshpass

Installed:
  sshpass-1.09-4.el9.x86_64

[ansible@companyrouter ~]$ pip install pywinrm requests
Defaulting to user installation because normal site-packages is not writeable
Collecting pywinrm
  Downloading pywinrm-0.4.3-py2.py3-none-any.whl (44 kB)
     |████████████████████████████████| 44 kB 1.5 MB/s
Collecting requests
  Downloading requests-2.31.0-py3-none-any.whl (62 kB)
     |████████████████████████████████| 62 kB 1.3 MB/s
Collecting requests-ntlm>=1.1.0
  Downloading requests_ntlm-1.2.0-py3-none-any.whl (6.0 kB)
Collecting xmltodict
  Downloading xmltodict-0.13.0-py2.py3-none-any.whl (10.0 kB)
Requirement already satisfied: six in /usr/lib/python3.9/site-packages (from pywinrm) (1.15.0)
Collecting certifi>=2017.4.17
  Downloading certifi-2023.11.17-py3-none-any.whl (162 kB)
     |████████████████████████████████| 162 kB 11.3 MB/s
Collecting urllib3<3,>=1.21.1
  Downloading urllib3-2.1.0-py3-none-any.whl (104 kB)
     |████████████████████████████████| 104 kB 47.1 MB/s
Collecting idna<4,>=2.5
  Downloading idna-3.6-py3-none-any.whl (61 kB)
     |████████████████████████████████| 61 kB 312 kB/s
Collecting charset-normalizer<4,>=2
  Downloading charset_normalizer-3.3.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (142 kB)
     |████████████████████████████████| 142 kB 22.9 MB/s
Collecting pyspnego>=0.1.6
  Downloading pyspnego-0.10.2-py3-none-any.whl (129 kB)
     |████████████████████████████████| 129 kB 17.2 MB/s
Requirement already satisfied: cryptography>=1.3 in ./.local/lib/python3.9/site-packages (from requests-ntlm>=1.1.0->pywinrm) (41.0.7)
Requirement already satisfied: cffi>=1.12 in ./.local/lib/python3.9/site-packages (from cryptography>=1.3->requests-ntlm>=1.1.0->pywinrm) (1.16.0)
Requirement already satisfied: pycparser in ./.local/lib/python3.9/site-packages (from cffi>=1.12->cryptography>=1.3->requests-ntlm>=1.1.0->pywinrm) (2.21)
Installing collected packages: urllib3, idna, charset-normalizer, certifi, requests, pyspnego, xmltodict, requests-ntlm, pywinrm
  WARNING: Value for scheme.platlib does not match. Please report this to <https://github.com/pypa/pip/issues/10151>
  distutils: /home/ansible/.local/lib/python3.9/site-packages
  sysconfig: /home/ansible/.local/lib64/python3.9/site-packages
  WARNING: Additional context:
  user = True
  home = None
  root = None
  prefix = None
Successfully installed certifi-2023.11.17 charset-normalizer-3.3.2 idna-3.6 pyspnego-0.10.2 pywinrm-0.4.3 requests-2.31.0 requests-ntlm-1.2.0 urllib3-2.1.0 xmltodict-0.13.0

```

```code
[ansible@companyrouter ~]$ ansible -i inventory -m "win_ping" windows
win10 | UNREACHABLE! => {
    "changed": false,
    "msg": "ssl: HTTPSConnectionPool(host='win10', port=5986): Max retries exceeded with url: /wsman (Caused by NewConnectionError('<urllib3.connection.HTTPSConnection object at 0x7fefb9b429a0>: Failed to establish a new connection: [Errno 111] Connection refused'))",
    "unreachable": true
}
^C [ERROR]: User interrupted execution
[ansible@companyrouter ~]$ ansible -i inventory -m "win_ping" dc
dc | UNREACHABLE! => {
    "changed": false,
    "msg": "ssl: HTTPSConnectionPool(host='dc', port=5986): Max retries exceeded with url: /wsman (Caused by ConnectTimeoutError(<urllib3.connection.HTTPSConnection object at 0x7fe92d84b520>, 'Connection to dc timed out. (connect timeout=30)'))",
    "unreachable": true
}
```

```code
PS C:\Users\Walt> winrm enumerate winrm/config/listener
Listener
    Address = *
    Transport = HTTP
    Port = 5985
    Hostname
    Enabled = true
    URLPrefix = wsman
    CertificateThumbprint
    ListeningOn = 127.0.0.1, 169.254.232.3, 172.30.10.100, ::1, fe80::b4c2:9d41:de52:e803%7


PS C:\Users\walt> Test-NetConnection -ComputerName 172.30.0.4 -Port 5986
WARNING: TCP connect to (172.30.0.4 : 5986) failed


ComputerName           : 172.30.0.4
RemoteAddress          : 172.30.0.4
RemotePort             : 5986
InterfaceAlias         : Ethernet
SourceAddress          : 172.30.0.4
PingSucceeded          : True
PingReplyDetails (RTT) : 0 ms
TcpTestSucceeded       : False



PS C:\Users\walt> Test-NetConnection -ComputerName 172.30.0.4 -Port 5985


ComputerName     : 172.30.0.4
RemoteAddress    : 172.30.0.4
RemotePort       : 5985
InterfaceAlias   : Ethernet
SourceAddress    : 172.30.0.4
TcpTestSucceeded : True


PS C:\Users\Walt> Test-NetConnection -ComputerName 172.30.0.4 -Port 5985


ComputerName     : 172.30.0.4
RemoteAddress    : 172.30.0.4
RemotePort       : 5985
InterfaceAlias   : Ethernet
SourceAddress    : 172.30.10.100
TcpTestSucceeded : True



PS C:\Users\Walt> Test-NetConnection -ComputerName 172.30.10.100 -Port 5985


ComputerName     : 172.30.10.100
RemoteAddress    : 172.30.10.100
RemotePort       : 5985
InterfaceAlias   : Ethernet
SourceAddress    : 172.30.10.100
TcpTestSucceeded : True


[ansible@companyrouter ~]$ ansible -i inventory -m "win_ping" windows
win10 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
dc | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

```code
[ansible@companyrouter ~]$ cat inventory
[all:vars]
ansible_ssh_private_key_file=/home/ansible/.ssh/id_rsa

[windows:vars]
ansible_user=vagrant
ansible_password=vagrant
# walt werkt op dc maar niet op win10
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
ansible_port=5985

[linux:vars]
ansible_user=ansible
ansible_connection=ssh

[linux]
localhost ansible_port=2222 ansible_connection=local
web
database
bastion
wazzuh

[windows]
dc
win10

[ansible@companyrouter ~]$ ansible -i inventory -m "win_shell" -a "hostname" dc
dc | CHANGED | rc=0 >>
dc
```

***Run an ad-hoc ansible command to check if the date of all machines are configured the same. Are you able to use the same Windows module for Linux machines and vice versa?***

```code
[ansible@companyrouter ~]$ ansible -i inventory -m "win_shell" -a "get-date" windows
win10 | CHANGED | rc=0 >>

Tuesday, January 9, 2024 9:42:30 PM



dc | CHANGED | rc=0 >>

Tuesday, January 9, 2024 9:42:32 PM



[ansible@companyrouter ~]$ ansible -i inventory -m shell -a "date" linux
localhost | CHANGED | rc=0 >>
Tue Jan  9 20:42:55 UTC 2024
database | CHANGED | rc=0 >>
Tue Jan  9 20:42:55 UTC 2024
web | CHANGED | rc=0 >>
Tue Jan  9 20:42:55 UTC 2024
```

***Create a playbook (or ad-hoc command) that pulls all "/etc/passwd" files from all Linux machines locally to the ansible controller node for every machine seperately.***

```code
[ansible@companyrouter ~]$ cat fetch_passwords.yml

# fetch_passwords.yml
---
- name: Retrieving /etc/passwd from all Linux machines and saving it locally
  hosts: linux
  tasks:
    - name: fetching the file for each machine
      fetch:
        src: /etc/passwd
        dest: "~/{{ inventory_hostname }}_etc_passwd"
        flat: yes

[ansible@companyrouter ~]$ ansible-playbook -i inventory fetch_passwords.yml

PLAY [Retrieving /etc/passwd from all Linux machines and saving it locally] *************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [localhost]
ok: [database]
ok: [web]

TASK [fetching the file for each machine] ***********************************************************************************************************************************************************************
changed: [localhost]
changed: [database]
changed: [web]

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
web                        : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[ansible@companyrouter ~]$ ls -l *passwd
-rw-r--r--. 1 ansible ansible 1402 Jan  9 20:51 database_etc_passwd
-rw-r--r--. 1 ansible ansible 1658 Jan  9 20:51 localhost_etc_passwd
-rw-r--r--. 1 ansible ansible 1716 Jan  9 20:51 web_etc_passwd

[ansible@companyrouter ~]$ grep 'ansible' *_passwd
database_etc_passwd:ansible:x:1014:1014::/home/ansible:/bin/bash
localhost_etc_passwd:ansible:x:1008:1008::/home/ansible:/bin/bash
web_etc_passwd:ansible:x:1002:1002::/home/ansible:/bin/bash
```

***Create a playbook (or ad-hoc command) that creates the user "walt" with password "Friday13th!" on all Linux machines.***

`first with a test user to create redundancy`

```code
# create_walt
---
- name: Create user walt on Linux machines
  hosts: linux
  become: yes
  tasks:
    - name: Check if walt does not yes exist
      shell: getent passwd test2
#      ignore_errors: true
      changed_when: false
      register: user_exists
    - name: Create user walt
      user:
#        name: walt
        name: test
#        password: "{{ 'Friday13th!' | password_hash('sha512') }}"
        password: "{{ 'test3' | password_hash('sha512') }}"
        state: present
      when: ! user_exists
```

```code
[ansible@companyrouter ~]$ ansible-playbook -i inventory create_walt.yml

PLAY [Conditional playbook for user creation] *******************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [database]
ok: [web]
ok: [localhost]

TASK [Test task] ************************************************************************************************************************************************************************************************
fatal: [database]: FAILED! => {"changed": false, "cmd": ["getent", "passwd", "test6"], "delta": "0:00:00.003877", "end": "2024-01-09 22:19:02.933284", "msg": "non-zero return code", "rc": 2, "start": "2024-01-09 22:19:02.929407", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring
ok: [web]
fatal: [localhost]: FAILED! => {"changed": false, "cmd": ["getent", "passwd", "test6"], "delta": "0:00:00.010437", "end": "2024-01-09 22:19:02.968164", "msg": "non-zero return code", "rc": 2, "start": "2024-01-09 22:19:02.957727", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring

TASK [Execute another task only if the first task failed] *******************************************************************************************************************************************************
skipping: [web]
[DEPRECATION WARNING]: Encryption using the Python crypt module is deprecated. The Python crypt module is deprecated and will be removed from Python 3.13. Install the passlib library for continued encryption
functionality. This feature will be removed in version 2.17. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: Encryption using the Python crypt module is deprecated. The Python crypt module is deprecated and will be removed from Python 3.13. Install the passlib library for continued encryption
functionality. This feature will be removed in version 2.17. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
changed: [database]
changed: [localhost]

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1
web                        : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

[ansible@companyrouter ~]$ ansible-playbook -i inventory create_walt.yml

PLAY [Conditional playbook for user creation] *******************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [database]
ok: [web]
ok: [localhost]

TASK [Test task] ************************************************************************************************************************************************************************************************
ok: [database]
ok: [localhost]
ok: [web]

TASK [Execute another task only if the first task failed] *******************************************************************************************************************************************************
skipping: [localhost]
skipping: [web]
skipping: [database]

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
web                        : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

```

```code
[ansible@companyrouter ~]$ pip install passlib
Defaulting to user installation because normal site-packages is not writeable
Collecting passlib
  Downloading passlib-1.7.4-py2.py3-none-any.whl (525 kB)
     |████████████████████████████████| 525 kB 2.5 MB/s
Installing collected packages: passlib
  WARNING: Value for scheme.platlib does not match. Please report this to <https://github.com/pypa/pip/issues/10151>
  distutils: /home/ansible/.local/lib/python3.9/site-packages
  sysconfig: /home/ansible/.local/lib64/python3.9/site-packages
  WARNING: Additional context:
  user = True
  home = None
  root = None
  prefix = None
Successfully installed passlib-1.7.4



[ansible@companyrouter ~]$ cat create_walt.yml | grep -v '#'

---
- name: Conditional playbook for user creation
  hosts: linux
  become: yes
  tasks:
    - name: Test task
      command: getent passwd walt
      ignore_errors: true
      register: result
      changed_when: false


    - name: Execute another task only if the first task failed
      user:
        name: walt
        password: "{{ 'Friday13th!' | password_hash('sha512') }}"
        state: present
      when: result is failed
[ansible@companyrouter ~]$ ansible-playbook -i inventory create_walt.yml

PLAY [Conditional playbook for user creation] *******************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [database]
ok: [localhost]
ok: [web]

TASK [Test task] ************************************************************************************************************************************************************************************************
ok: [database]
ok: [web]
ok: [localhost]

TASK [Execute another task only if the first task failed] *******************************************************************************************************************************************************
skipping: [localhost]
skipping: [web]
skipping: [database]

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
web                        : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

```

```code
[walt@web ~]$ sudo useradd -m -s /bin/bash -p "$(openssl passwd -1 'test6')" test6
```

`then walt (who allready exists everywhere)`

```code
[ansible@companyrouter ~]$ ansible-playbook -i inventory create_walt.yml

PLAY [Conditional playbook for user creation] *******************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [database]
ok: [web]
ok: [localhost]

TASK [Test task] ************************************************************************************************************************************************************************************************
ok: [database]
ok: [localhost]
ok: [web]

TASK [Execute another task only if the first task failed] *******************************************************************************************************************************************************
skipping: [localhost]
skipping: [web]
skipping: [database]

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
web                        : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

***Create a playbook (or ad-hoc command) that pulls all users that are allowed to log in on all Linux machines.***

[ansible@companyrouter ~]$ ansible -i inventory -m getent -a 'database=passwd' linux

***Create a playbook (or ad-hoc command) that calculates the hash (md5sum for example) of a binary (for example the ss binary).***

```code
[ansible@companyrouter ~]$ cat md5.yml
---
- hosts: linux
  tasks:
    - name: Calculate MD5 checksum of ss binary
      command: md5sum /usr/sbin/ss
      register: md5_result

    - name: Display MD5 checksum
      debug:
        var: md5_result.stdout_lines


[ansible@companyrouter ~]$ ansible-playbook -i inventory md5.yml

PLAY [linux] ****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [database]
ok: [web]
ok: [localhost]

TASK [Calculate MD5 checksum of ss binary] **********************************************************************************************************************************************************************
changed: [database]
changed: [localhost]
changed: [web]

TASK [Display MD5 checksum] *************************************************************************************************************************************************************************************
ok: [localhost] => {
    "md5_result.stdout_lines": [
        "f9dd978d3dabb9453fc73d63d0ad0355  /usr/sbin/ss"
    ]
}
ok: [web] => {
    "md5_result.stdout_lines": [
        "e13b63ecba3a94e56fe72ad4128757d5  /usr/sbin/ss"
    ]
}
ok: [database] => {
    "md5_result.stdout_lines": [
        "e13b63ecba3a94e56fe72ad4128757d5  /usr/sbin/ss"
    ]
}

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
web                        : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

***Create a playbook (or ad-hoc command) that shows if Windows Defender is enabled and if there are any folder exclusions configured on the Windows client. This might require a bit of searching on how to retrieve this information through a command/PowerShell.***

```code
PS C:\Users\Walt> (Get-MpPreference).DisableRealtimeMonitoring
False

PS C:\Users\Walt> Set-MpPreference -DisableRealtimeMonitoring $true
PS C:\Users\Walt> (Get-MpPreference).DisableRealtimeMonitoring
True

```

```code
[ansible@companyrouter ~]$ ansible -i inventory dc -m win_shell -a "Get-MpPreference | Select-Object -ExpandProperty ExclusionPath"
dc | CHANGED | rc=0 >>
c:\
C:\Windows

[ansible@companyrouter ~]$ cat defender.yml
---
- hosts: windows
  tasks:
    - name: Retrieve Windows Defender Disabled status
      win_shell: Get-MpPreference | Select-Object -ExpandProperty DisableRealtimeMonitoring
      register: defender_disabled
      changed_when: false

    - name: Retrieve Windows Defender folder exclusions
      win_shell: Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
      register: exclusion_paths
      changed_when: false

    - name: Display Windows Defender status (disabled = false => defender is on)
      debug:
        var: defender_disabled.stdout_lines

    - name: Display Windows Defender folder exclusions
      debug:
        var: exclusion_paths.stdout_lines



[ansible@companyrouter ~]$ ansible-playbook -i inventory defender.yml

PLAY [windows] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [dc]
ok: [win10]

TASK [Retrieve Windows Defender Disabled status] ****************************************************************************************************************************************************************
ok: [win10]
ok: [dc]

TASK [Retrieve Windows Defender folder exclusions] **************************************************************************************************************************************************************
ok: [win10]
ok: [dc]

TASK [Display Windows Defender status (disabled = false => defender is on)] *************************************************************************************************************************************
ok: [dc] => {
    "defender_disabled.stdout_lines": [
        "False"
    ]
}
ok: [win10] => {
    "defender_disabled.stdout_lines": [
        "False"
    ]
}

TASK [Display Windows Defender folder exclusions] ***************************************************************************************************************************************************************
ok: [dc] => {
    "exclusion_paths.stdout_lines": [
        "c:\\",
        "C:\\Windows"
    ]
}
ok: [win10] => {
    "exclusion_paths.stdout_lines": [
        "c:\\"
    ]
}

PLAY RECAP ******************************************************************************************************************************************************************************************************
dc                         : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
win10                      : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

***Create a playbook (or ad-hoc command) that copies a file (for example a txt file) from the ansible controller machine to all Linux machines.***

```code
[ansible@companyrouter ~]$ echo hello world > README.txt
[ansible@companyrouter ~]$ cat README.txt
hello world
[ansible@companyrouter ~]$ cat copylinux.yml
---
- hosts: linux
  tasks:
    - name: Copy a file to all Linux machines
      copy:
        src: /home/ansible/README.txt
        dest: /home/ansible/
[ansible@companyrouter ~]$ ansible-playbook -i inventory copylinux.yml

PLAY [linux] ****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [database]
ok: [web]
ok: [localhost]

TASK [Copy a file to all Linux machines] ************************************************************************************************************************************************************************
ok: [localhost]
changed: [database]
changed: [web]

PLAY RECAP ******************************************************************************************************************************************************************************************************
database                   : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
web                        : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[ansible@companyrouter ~]$ ssh ansible@web cat ~/README.txt
hello world
```

***Create the same as above but for Windows machines***

```code
[ansible@companyrouter ~]$ cat copywindows.yml
---
- hosts: windows
  tasks:
    - name: Copy a file to all Windows machines
      win_copy:
        src: /home/ansible/README.txt
        dest: C:\
[ansible@companyrouter ~]$ ansible-playbook -i inventory copywindows.yml

PLAY [windows] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [dc]
ok: [win10]

TASK [Copy a file to all Windows machines] **********************************************************************************************************************************************************************
changed: [win10]
changed: [dc]

PLAY RECAP ******************************************************************************************************************************************************************************************************
dc                         : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
win10                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


```

```code
PS C:\Users\walt> ls c:\README.txt


    Directory: C:\


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         1/10/2024  12:21 PM             12 README.txt


PS C:\Users\walt> cat c:\README.txt
hello world
```

`faster without gathering facts`

```code
[ansible@companyrouter ~]$ cat copywindows.yml
---
- hosts: windows
  gather_facts: false
  tasks:
    - name: Copy a file to all Windows machines
      win_copy:
        src: /home/ansible/README.txt
        dest: C:\



[ansible@companyrouter ~]$ ansible-playbook -i inventory copywindows.yml

PLAY [windows] **************************************************************************************************************************************************************************************************

TASK [Copy a file to all Windows machines] **********************************************************************************************************************************************************************
ok: [dc]
ok: [win10]

PLAY RECAP ******************************************************************************************************************************************************************************************************
dc                         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
win10                      : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
