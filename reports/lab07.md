# CSA - Lecture 7 Exercises

## Borgbackup

```code
PS C:\Users\Benny> VBoxManage startvm "ca_d_web" --type headless
Waiting for VM "ca_d_web" to power on...
VM "ca_d_web" has been successfully started.
PS C:\Users\Benny> ssh webD
Last login: Sat Jan  6 15:23:31 2024 from 172.30.20.254
[walt@web ~]$ mkdir important-files
[walt@web ~]$ cd important-files/

```


       -L, --location
              (HTTP) If the server reports that the requested page has moved to a different location (indicated with a Location: header and a 3XX response code), this option will make curl redo  the  re‐
              quest  on  the  new place. If used together with -i, --include or -I, --head, headers from all requested pages will be shown. When authentication is used, curl only sends its credentials to
              the initial host. If a redirect takes curl to a different host, it won't be able to intercept the user+password. See also --location-trusted on how to change this. You can limit the  amount
              of redirects to follow by using the --max-redirs option.

              When  curl  follows  a  redirect  and if the request is a POST, it will do the following request with a GET if the HTTP response was 301, 302, or 303. If the response code was any other 3xx
              code, curl will re-send the following request using the same unmodified method.

              You can tell curl to not change POST requests to GET after a 30x response by using the dedicated options for that: --post301, --post302 and --post303.

              The method set with -X, --request overrides the method curl would otherwise select to use.

                     --remote-name-all
              This option changes the default action for all given URLs to be dealt with as if -O, --remote-name were used for each one. So if you want to disable that for a specific URL after  --remote-
              name-all has been used, you must use "-o -" or --no-remote-name.

              Added in 7.19.0.

       -O, --remote-name
              Write output to a local file named like the remote file we get. (Only the file part of the remote file is used, the path is cut off.)

              The  file  will  be saved in the current working directory. If you want the file saved in a different directory, make sure you change the current working directory before invoking curl with
              this option.

              The remote file name to use for saving is extracted from the given URL, nothing else, and if it already exists it will be overwritten. If you want the server to be able to choose  the  file
              name refer to -J, --remote-header-name which can be used in addition to this option. If the server chooses a file name and that name already exists it will not be overwritten.

              There is no URL decoding done on the file name. If it has %20 or other URL encoded parts of the name, they will end up as-is as file name.

              You may use this option as many times as the number of URLs you have.

[walt@web important-files]$ curl -L --remote-name-all https://video.blender.org/download/videos/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4 https://www.gutenberg.org/ebooks/100.txt.utf-8 https://www.gutenberg.org/ebooks/996.txt.utf-8 https://upload.wikimedia.org/wikipedia/commons/4/40/Toreador_song_cleaned.ogg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  105M  100  105M    0     0  4674k      0  0:00:23  0:00:23 --:--:-- 4739k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0    551      0 --:--:-- --:--:-- --:--:--   550
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 5506k  100 5506k    0     0  2548k      0  0:00:02  0:00:02 --:--:-- 5371k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0   2343      0 --:--:-- --:--:-- --:--:--  2343
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 2335k  100 2335k    0     0  2412k      0 --:--:-- --:--:-- --:--:-- 5226k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1662k  100 1662k    0     0  5277k      0 --:--:-- --:--:-- --:--:-- 5277k
[walt@web important-files]$ mv 100.txt.utf-8 100.txt
[walt@web important-files]$ mv 996.txt.utf-8 996.txt
[walt@web important-files]$ ls -lh
total 116M
-rw-r--r--. 1 walt walt 5.4M Jan  6 15:38 100.txt
-rw-r--r--. 1 walt walt 2.3M Jan  6 15:38 996.txt
-rw-r--r--. 1 walt walt 1.7M Jan  6 15:38 Toreador_song_cleaned.ogg
-rw-r--r--. 1 walt walt 106M Jan  6 15:38 bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4




PS C:\Users\Benny> VBoxManage startvm "ca_d_database" --type headless
Waiting for VM "ca_d_database" to power on...
VM "ca_d_database" has been successfully started.
PS C:\Users\Benny> ssh databaseR
Last login: Sat Jan  6 15:24:41 2024 from 172.30.0.254
[walt@database ~]$ mkdir backups
[walt@database ~]$ sudo dnf config-manager --set-enabled crb
[walt@database ~]$ sudo dnf -yq install epel-release

Installed:
  epel-release-9-5.el9.noarch

[walt@database ~]$ sudo dnf install -yq borgbackup
Importing GPG key 0x3228467C:
 Userid     : "Fedora (epel9) <epel@fedoraproject.org>"
 Fingerprint: FF8A D134 4597 106E CE81 3B91 8A38 72BF 3228 467C
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

Installed:
  borgbackup-1.2.7-1.el9.x86_64    fuse-2.9.9-15.el9.x86_64   fuse-common-3.10.2-6.el9.x86_64   python3-llfuse-1.4.2-1.el9.x86_64   python3-msgpack-1.0.3-2.el9.x86_64   python3-packaging-20.9-5.el9.noarch
  xxhash-libs-0.8.1-3.el9.x86_64

[walt@database ~]$ which borg
/usr/bin/borg





[walt@web important-files]$ sudo poweroff
[walt@web important-files]$ Connection to web closed by remote host.
Connection to web closed.
PS C:\Users\Benny> VBoxManage modifyvm "ca_d_web" --memory 1024
PS C:\Users\Benny> VBoxManage startvm "ca_d_web" --type headless
Waiting for VM "ca_d_web" to power on...
VM "ca_d_web" has been successfully started.
PS C:\Users\Benny> ssh webD
Last login: Sat Jan  6 15:27:36 2024 from 192.168.100.1
[walt@web ~]$ sudo dnf config-manager --set-enabled crb
[walt@web ~]$ sudo dnf -yq install epel-release

Installed:
  epel-release-9-5.el9.noarch

[walt@web ~]$ sudo dnf install -yq borgbackup
Importing GPG key 0x3228467C:
 Userid     : "Fedora (epel9) <epel@fedoraproject.org>"
 Fingerprint: FF8A D134 4597 106E CE81 3B91 8A38 72BF 3228 467C
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

Installed:
  borgbackup-1.2.7-1.el9.x86_64         python3-llfuse-1.4.2-1.el9.x86_64         python3-msgpack-1.0.3-2.el9.x86_64         python3-packaging-20.9-5.el9.noarch         xxhash-libs-0.8.1-3.el9.x86_64

[walt@web ~]$ which borg
/usr/bin/borg




[walt@web ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/walt/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/walt/.ssh/id_rsa
Your public key has been saved in /home/walt/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:fSTqjj9sHVkloGofK9SZsrRWYsG3Z0E4rYqK+EyVow8 walt@web
The key's randomart image is:
+---[RSA 3072]----+
|         oo.     |
|     .  oo. . .  |
|      o ooo .o   |
|     . =.* +.    |
|    +.O.S +o.    |
|   o.*.O =o.     |
|..E.  =.+. .     |
|oo.o . ++ .      |
| .o . .oo.       |
+----[SHA256]-----+
[walt@web ~]$ ssh-copy-id walt@database
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/walt/.ssh/id_rsa.pub"
The authenticity of host 'database (172.30.0.15)' can't be established.
ED25519 key fingerprint is SHA256:0DWHYG8LGaH3HKqFFxbHs6Ipnr2aYrjIoyT1t1a3Qfc.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
walt@database's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'walt@database'"
and check to make sure that only the key(s) you wanted were added.

[walt@web ~]$ ssh walt@database sudo ss -tnp
State Recv-Q Send-Q Local Address:Port Peer Address:Port Process
ESTAB 0      0        172.30.0.15:22   172.30.20.10:34348 users:(("sshd",pid=1831,fd=4),("sshd",pid=1828,fd=4))
ESTAB 0      0        172.30.0.15:22   172.30.0.254:51186 users:(("sshd",pid=1294,fd=4),("sshd",pid=1281,fd=4))


```code
[walt@web ~]$ borg init --encryption=repokey walt@database:/home/walt/backups
Enter new passphrase:
Enter same passphrase again:
Do you want your passphrase to be displayed for verification? [yN]: y
Your passphrase (between double-quotes): "borg"
Make sure the passphrase displayed above is exactly what you wanted.

By default repositories initialized with this version will produce security
errors if written to with an older version (up to and including Borg 1.0.8).

If you want to use these older versions, you can disable the check by running:
borg upgrade --disable-tam ssh://walt@database/home/walt/backups

See https://borgbackup.readthedocs.io/en/stable/changes.html#pre-1-0-9-manifest-spoofing-vulnerability for details about the security implications.

IMPORTANT: you will need both KEY AND PASSPHRASE to access this repo!
If you used a repokey mode, the key is stored in the repo, but you should back it up separately.
Use "borg key export" to export the key, optionally in printable format.
Write down the passphrase. Store both at safe place(s).

```

```code
[walt@database backups]$ ls -alh
total 64K
drwxr-xr-x. 3 walt walt 108 Jan  6 16:36 .
drwx------. 5 walt walt 162 Jan  6 16:33 ..
-rw-------. 1 walt walt  73 Jan  6 16:36 README
-rw-------. 1 walt walt 700 Jan  6 16:36 config
drwx------. 3 walt walt  15 Jan  6 16:36 data
-rw-------. 1 walt walt  70 Jan  6 16:36 hints.1
-rw-------. 1 walt walt 41K Jan  6 16:36 index.1
-rw-------. 1 walt walt 190 Jan  6 16:36 integrity.1
-rw-------. 1 walt walt  16 Jan  6 16:36 nonce
[walt@database backups]$ more README
This is a Borg Backup repository.
See https://borgbackup.readthedocs.io/
[walt@database backups]$ more config
[repository]
version = 1
segments_per_dir = 1000
max_segment_size = 524288000
append_only = 0
storage_quota = 0
additional_free_space = 0
id = d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
key = hqlhbGdvcml0aG2mc2hhMjU2pGRhdGHaAN5P7o3IBeqg4znFRtH9dvK1guCf3QjSBuiGov
        KrBPAIjJu8YZ9BmkOQWF0IssSUWbzKW9AFuYI2carD7i/sCq0vQN/dIK0nK7hHWP8+HWbw
        FS7r7X6s9m1/ZnPAQ0dw1ie4Mqz6JfpEsxNlzDNfWyy922nt/Tm+i5zfOxybz6Aj2GkYK8
        d+f05PXxkRsZEVnloN3H5EEyUXm+CUrHwSkSjFCILa/pHUSq+CbNXrI0FS/xEjgdlJsHCP
        9Sc9VxcpkCPKH2P0J/XSKpcweBm9oZ0tKXbYHvt69UtcjV1OSAakaGFzaNoAIEe8YCs7RY
        trc9YU5n9tzPtpPviZtq7XGRfiRGjTapbeqml0ZXJhdGlvbnPOAAGGoKRzYWx02gAgmsH6
        MBJszyl3NkDFYwETkW7kk/0v2nEX15Nji1GKNjqndmVyc2lvbgE=

```


[walt@web ~]$ borg key export walt@database:/home/walt/backups ~/key_bu_database
[walt@web ~]$ cat key_bu_database
BORG_KEY d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
hqlhbGdvcml0aG2mc2hhMjU2pGRhdGHaAN5P7o3IBeqg4znFRtH9dvK1guCf3QjSBuiGov
KrBPAIjJu8YZ9BmkOQWF0IssSUWbzKW9AFuYI2carD7i/sCq0vQN/dIK0nK7hHWP8+HWbw
FS7r7X6s9m1/ZnPAQ0dw1ie4Mqz6JfpEsxNlzDNfWyy922nt/Tm+i5zfOxybz6Aj2GkYK8
d+f05PXxkRsZEVnloN3H5EEyUXm+CUrHwSkSjFCILa/pHUSq+CbNXrI0FS/xEjgdlJsHCP
9Sc9VxcpkCPKH2P0J/XSKpcweBm9oZ0tKXbYHvt69UtcjV1OSAakaGFzaNoAIEe8YCs7RY
trc9YU5n9tzPtpPviZtq7XGRfiRGjTapbeqml0ZXJhdGlvbnPOAAGGoKRzYWx02gAgmsH6
MBJszyl3NkDFYwETkW7kk/0v2nEX15Nji1GKNjqndmVyc2lvbgE=




[walt@web ~]$ borg create walt@database:/home/walt/backups::first ~/important-files/
Enter passphrase for key ssh://walt@database/home/walt/backups:

[walt@web ~]$


[walt@web ~]$ ls -alh important-files/
total 116M
drwxr-xr-x. 2 walt walt  121 Jan  6 15:38 .
drwx------. 6 walt walt  186 Jan  6 17:13 ..
-rw-r--r--. 1 walt walt 5.4M Jan  6 15:38 100.txt
-rw-r--r--. 1 walt walt 2.3M Jan  6 15:38 996.txt
-rw-r--r--. 1 walt walt 1.7M Jan  6 15:38 Toreador_song_cleaned.ogg
-rw-r--r--. 1 walt walt 106M Jan  6 15:38 bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4





[walt@database ~]$ ls -alh /home/walt/backups/data/0/
total 113M
drwx------. 2 walt walt   60 Jan  6 17:13 .
drwx------. 3 walt walt   15 Jan  6 16:36 ..
-rw-------. 1 walt walt  530 Jan  6 16:36 0
-rw-------. 1 walt walt   17 Jan  6 16:36 1
-rw-------. 1 walt walt 113M Jan  6 17:13 2
-rw-------. 1 walt walt   49 Jan  6 17:13 3
-rw-------. 1 walt walt  592 Jan  6 17:13 4
-rw-------. 1 walt walt   17 Jan  6 17:13 5





[walt@web ~]$ borg info walt@database:/home/walt/backups
Enter passphrase for key ssh://walt@database/home/walt/backups:
Repository ID: d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Location: ssh://walt@database/home/walt/backups
Encrypted: Yes (repokey)
Cache: /home/walt/.cache/borg/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Security dir: /home/walt/.config/borg/security/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
All archives:              120.65 MB            117.50 MB            117.51 MB

                       Unique chunks         Total chunks
Chunk index:                      65                   65



[walt@web ~]$ export BORG_PASSPHRASE='borg'
[walt@web ~]$ borg info walt@database:/home/walt/backups
Repository ID: d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Location: ssh://walt@database/home/walt/backups
Encrypted: Yes (repokey)
Cache: /home/walt/.cache/borg/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Security dir: /home/walt/.config/borg/security/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
All archives:              120.65 MB            117.50 MB            117.51 MB

                       Unique chunks         Total chunks
Chunk index:                      65                   65



[walt@web ~]$ borg list walt@database:/home/walt/backups
first                                Sat, 2024-01-06 17:13:21 [22206a55362692fc91f65c1da91a3721652c49d3d98304fae7e1e8becce97a4a]
[walt@web ~]$ borg list walt@database:/home/walt/backups::first
drwxr-xr-x walt   walt          0 Sat, 2024-01-06 15:38:30 home/walt/important-files
-rw-r--r-- walt   walt    5638564 Sat, 2024-01-06 15:38:12 home/walt/important-files/100.txt
-rw-r--r-- walt   walt    2391726 Sat, 2024-01-06 15:38:13 home/walt/important-files/996.txt
-rw-r--r-- walt   walt    1702187 Sat, 2024-01-06 15:38:13 home/walt/important-files/Toreador_song_cleaned.ogg
-rw-r--r-- walt   walt   110916740 Sat, 2024-01-06 15:38:10 home/walt/important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4



borg create walt@database:/home/walt/backups::second ~/important-files/


[walt@database ~]$ ls -alh /home/walt/backups/data/0/
total 113M
drwx------. 2 walt walt   96 Jan  6 17:20 .
drwx------. 3 walt walt   15 Jan  6 16:36 ..
-rw-------. 1 walt walt  530 Jan  6 16:36 0
-rw-------. 1 walt walt   17 Jan  6 16:36 1
-rw-------. 1 walt walt 113M Jan  6 17:13 2
-rw-------. 1 walt walt   49 Jan  6 17:13 3
-rw-------. 1 walt walt  592 Jan  6 17:13 4
-rw-------. 1 walt walt   17 Jan  6 17:13 5
-rw-------. 1 walt walt 4.1K Jan  6 17:20 6
-rw-------. 1 walt walt   49 Jan  6 17:20 7
-rw-------. 1 walt walt  648 Jan  6 17:20 8
-rw-------. 1 walt walt   17 Jan  6 17:20 9




[walt@web ~]$ borg info walt@database:/home/walt/backups
Repository ID: d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Location: ssh://walt@database/home/walt/backups
Encrypted: Yes (repokey)
Cache: /home/walt/.cache/borg/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Security dir: /home/walt/.config/borg/security/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
All archives:              241.30 MB            235.01 MB            117.51 MB

                       Unique chunks         Total chunks
Chunk index:                      68                  131


[walt@web ~]$ borg list walt@database:/home/walt/backups
first                                Sat, 2024-01-06 17:13:21 [22206a55362692fc91f65c1da91a3721652c49d3d98304fae7e1e8becce97a4a]
second                               Sat, 2024-01-06 17:20:39 [f241cd8edb84869131f9374cab89b23d427d4f5f67011d82081ec63f3408048b]
[walt@web ~]$ borg list walt@database:/home/walt/backups::first
drwxr-xr-x walt   walt          0 Sat, 2024-01-06 15:38:30 home/walt/important-files
-rw-r--r-- walt   walt    5638564 Sat, 2024-01-06 15:38:12 home/walt/important-files/100.txt
-rw-r--r-- walt   walt    2391726 Sat, 2024-01-06 15:38:13 home/walt/important-files/996.txt
-rw-r--r-- walt   walt    1702187 Sat, 2024-01-06 15:38:13 home/walt/important-files/Toreador_song_cleaned.ogg
-rw-r--r-- walt   walt   110916740 Sat, 2024-01-06 15:38:10 home/walt/important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4
[walt@web ~]$ borg list walt@database:/home/walt/backups::second
drwxr-xr-x walt   walt          0 Sat, 2024-01-06 17:20:21 home/walt/important-files
-rw-r--r-- walt   walt    5638564 Sat, 2024-01-06 15:38:12 home/walt/important-files/100.txt
-rw-r--r-- walt   walt    2391726 Sat, 2024-01-06 15:38:13 home/walt/important-files/996.txt
-rw-r--r-- walt   walt    1702187 Sat, 2024-01-06 15:38:13 home/walt/important-files/Toreador_song_cleaned.ogg
-rw-r--r-- walt   walt         12 Sat, 2024-01-06 17:20:21 home/walt/important-files/test.txt
-rw-r--r-- walt   walt   110916740 Sat, 2024-01-06 15:38:10 home/walt/important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4



[walt@web ~]$ borg info walt@database:/home/walt/backups::second
Archive name: second
Archive fingerprint: f241cd8edb84869131f9374cab89b23d427d4f5f67011d82081ec63f3408048b
Comment:
Hostname: web
Username: walt
Time (start): Sat, 2024-01-06 17:20:39
Time (end): Sat, 2024-01-06 17:20:39
Duration: 0.03 seconds
Number of files: 5
Command line: /usr/bin/borg create walt@database:/home/walt/backups::second /home/walt/important-files/
Utilization of maximum supported archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:              120.65 MB            117.50 MB              3.99 kB
All archives:              241.30 MB            235.01 MB            117.51 MB

                       Unique chunks         Total chunks
Chunk index:                      68                  131


[walt@web ~]$ du --si important-files/
121M    important-files/
[walt@web ~]$ du -B1000 important-files/
120660  important-files/

[walt@web ~]$ du important-files/
117832  important-files/
[walt@web ~]$ du -h important-files/
116M    important-files/



[walt@web ~]$ borg info --iec walt@database:/home/walt/backups::second
Archive name: second
Archive fingerprint: f241cd8edb84869131f9374cab89b23d427d4f5f67011d82081ec63f3408048b
Comment:
Hostname: web
Username: walt
Time (start): Sat, 2024-01-06 17:20:39
Time (end): Sat, 2024-01-06 17:20:39
Duration: 0.03 seconds
Number of files: 5
Command line: /usr/bin/borg create walt@database:/home/walt/backups::second /home/walt/important-files/
Utilization of maximum supported archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:             115.06 MiB           112.06 MiB             3.90 KiB
All archives:             230.12 MiB           224.12 MiB           112.07 MiB

                       Unique chunks         Total chunks
Chunk index:                      68                  131



https://borgbackup.readthedocs.io/en/stable/usage/general.html

Units
To display quantities, Borg takes care of respecting the usual conventions of scale. Disk sizes are displayed in decimal, using powers of ten (so kB means 1000 bytes). For memory usage, binary prefixes are used, and are indicated using the IEC binary prefixes, using powers of two (so KiB means 1024 bytes).


Common options
All Borg commands share these options:

--iec
format using IEC units (1KiB = 1024B)





[walt@database data]$ du 0
114800  0
[walt@database data]$ du -si 0
du: invalid option -- 'i'
Try 'du --help' for more information.
[walt@database data]$ du --si 0
118M    0
[walt@database data]$ du 0
114800  0
[walt@database data]$ du -h 0
113M    0
[walt@database data]$ du -B1000 0
117556  0
[walt@database data]$ du -B1024 0
114800  0





https://borgbackup.readthedocs.io/en/stable/usage/info.html

Description
This command displays detailed information about the specified archive or repository.

Please note that the deduplicated sizes of the individual archives do not add up to the deduplicated size of the repository (“all archives”), because the two are meaning different things:

This archive / deduplicated size = amount of data stored ONLY for this archive = unique chunks of this archive. All archives / deduplicated size = amount of data stored in the repo = all chunks in the repository.

Borg archives can only contain a limited amount of file metadata. The size of an archive relative to this limit depends on a number of factors, mainly the number of files, the lengths of paths and other metadata stored for files. This is shown as utilization of maximum supported archive size.



[walt@web ~]$ borg info walt@database:/home/walt/backups::second --json
{
    "archives": [
        {
            "chunker_params": [
                "buzhash",
                19,
                23,
                21,
                4095
            ],
            "command_line": [
                "/usr/bin/borg",
                "create",
                "walt@database:/home/walt/backups::second",
                "/home/walt/important-files/"
            ],
            "comment": "",
            "duration": 0.034572,
            "end": "2024-01-06T17:20:39.000000",
            "hostname": "web",
            "id": "f241cd8edb84869131f9374cab89b23d427d4f5f67011d82081ec63f3408048b",
            "limits": {
                "max_archive_size": 2.5558521647424104e-05
            },
            "name": "second",
            "start": "2024-01-06T17:20:39.000000",
            "stats": {
                "compressed_size": 117504301,
                "deduplicated_size": 3994,
                "nfiles": 5,
                "original_size": 120649229
            },
            "username": "walt"
        }
    ],
    "cache": {
        "path": "/home/walt/.cache/borg/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d",
        "stats": {
            "total_chunks": 131,
            "total_csize": 235008547,
            "total_size": 241298446,
            "total_unique_chunks": 68,
            "unique_csize": 117512105,
            "unique_size": 120658527
        }
    },
    "encryption": {
        "mode": "repokey"
    },
    "repository": {
        "id": "d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d",
        "last_modified": "2024-01-06T17:20:39.000000",
        "location": "ssh://walt@database/home/walt/backups"
    }
}



https://borgbackup.readthedocs.io/en/stable/introduction.html

Main features
Space efficient storage
Deduplication based on content-defined chunking is used to reduce the number of bytes stored: each file is split into a number of variable length chunks and only chunks that have never been seen before are added to the repository.

A chunk is considered duplicate if its id_hash value is identical. A cryptographically strong hash or MAC function is used as id_hash, e.g. (hmac-)sha256.

To deduplicate, all the chunks in the same repository are considered, no matter whether they come from different machines, from previous backups, from the same backup or even from the same single file.

Compared to other deduplication approaches, this method does NOT depend on:

file/directory names staying the same: So you can move your stuff around without killing the deduplication, even between machines sharing a repo.

complete files or time stamps staying the same: If a big file changes a little, only a few new chunks need to be stored - this is great for VMs or raw disks.

The absolute position of a data chunk inside a file: Stuff may get shifted and will still be found by the deduplication algorithm.



CHATGPT
User
how would you explain what a chunk in borgbackup is
ChatGPT
In BorgBackup, a "chunk" refers to a fixed-size block of data that the software uses for deduplication and compression purposes. BorgBackup employs a technique known as "chunking" to break down files into these fixed-size chunks, typically 128 KB in size. Each chunk is uniquely identified by its content, which means identical chunks in different files or versions of files will have the same ID.

Here's a breakdown of the key concepts related to chunks in BorgBackup:

Fixed Size: Chunks in BorgBackup are of a predetermined, fixed size, usually 128 KB. This fixed size allows BorgBackup to perform deduplication efficiently. If a part of a file changes, only the affected chunks need to be stored, reducing storage space requirements.

Content-Defined Chunks: BorgBackup uses content-defined chunking, where the chunk boundaries are determined by the content of the data rather than fixed offsets in the file. This approach ensures that changes to the file do not affect the boundaries of the chunks, maintaining deduplication effectiveness.

Deduplication: The deduplication feature of BorgBackup ensures that if multiple files or versions of files have the same content, the identical chunks are stored only once. This significantly reduces storage space requirements, making BorgBackup an efficient backup solution.

Chunk IDs: Each chunk is assigned a unique identifier based on its content. This identifier, often a hash, is used to track and manage chunks efficiently. If the same content appears in different files, BorgBackup recognizes it and only stores one copy of the chunk.

Compression: BorgBackup also applies compression to the data, further reducing the size of each chunk before it's stored. The combination of deduplication and compression helps optimize storage space in the backup repository.

In summary, a chunk in BorgBackup is a fixed-size block of data, typically 128 KB, that represents a piece of a file. These chunks are used for deduplication and compression, allowing BorgBackup to efficiently store and manage backups while minimizing storage requirements.





[walt@web ~]$ borg check -v walt@database:/home/walt/backups
Remote: Starting repository check
Remote: finished segment check at segment 9
Remote: Starting repository index check
Starting archive consistency check...
Remote: Index object count match.
Remote: Finished full repository check, no problems found.
Analyzing archive first (1/2)
Analyzing archive second (2/2)
Archive consistency check complete, no problems found.



https://borgbackup.readthedocs.io/en/stable/usage/check.html

Description
The check command verifies the consistency of a repository and its archives. It consists of two major steps:

Checking the consistency of the repository itself. This includes checking the segment magic headers, and both the metadata and data of all objects in the segments. The read data is checked by size and CRC. Bit rot and other types of accidental damage can be detected this way. Running the repository check can be split into multiple partial checks using --max-duration. When checking a remote repository, please note that the checks run on the server and do not cause significant network traffic.

Checking consistency and correctness of the archive metadata and optionally archive data (requires --verify-data). This includes ensuring that the repository manifest exists, the archive metadata chunk is present, and that all chunks referencing files (items) in the archive exist. This requires reading archive and file metadata, but not data. To cryptographically verify the file (content) data integrity pass --verify-data, but keep in mind that this requires reading all data and is hence very time consuming. When checking archives of a remote repository, archive checks run on the client machine because they require decrypting data and therefore the encryption key.

Both steps can also be run independently. Pass --repository-only to run the repository checks only, or pass --archives-only to run the archive checks only.

The --max-duration option can be used to split a long-running repository check into multiple partial checks. After the given number of seconds the check is interrupted. The next partial check will continue where the previous one stopped, until the full repository has been checked. Assuming a complete check would take 7 hours, then running a daily check with --max-duration=3600 (1 hour) would result in one full repository check per week. Doing a full repository check aborts any previous partial check; the next partial check will restart from the beginning. With partial repository checks you can run neither archive checks, nor enable repair mode. Consequently, if you want to use --max-duration you must also pass --repository-only, and must not pass --archives-only, nor --repair.

Warning: Please note that partial repository checks (i.e. running it with --max-duration) can only perform non-cryptographic checksum checks on the segment files. A full repository check (i.e. without --max-duration) can also do a repository index check. Enabling partial repository checks excepts archive checks for the same reason. Therefore partial checks may be useful with very large repositories only where a full check would take too long.

The --verify-data option will perform a full integrity verification (as opposed to checking the CRC32 of the segment) of data, which means reading the data from the repository, decrypting and decompressing it. It is a complete cryptographic verification and hence very time consuming, but will detect any accidental and malicious corruption. Tamper-resistance is only guaranteed for encrypted repositories against attackers without access to the keys. You can not use --verify-data with --repository-only.



[walt@web ~]$ borg check -v --verify-data walt@database:/home/walt/backups
Remote: Starting repository check
Remote: finished segment check at segment 9
Remote: Starting repository index check
Remote: Index object count match.
Remote: Finished full repository check, no problems found.
Starting archive consistency check...
Starting cryptographic data integrity verification...
Finished cryptographic data integrity verification, verified 69 chunks with 0 integrity errors.
Analyzing archive first (1/2)
Analyzing archive second (2/2)
Archive consistency check complete, no problems found.


CHATGPT:
The --verify-data option in BorgBackup is used to perform additional verification of the data integrity within the repository. When you use borg check, it performs a consistency check on the repository, but it doesn't necessarily verify the actual content of the stored data. The --verify-data option adds an extra layer of verification by comparing the stored data against its expected checksum.

Here's how you can use --verify-data:

bash
Copy code
borg check --verify-data /path/to/your/repo
Replace /path/to/your/repo with the actual path to your BorgBackup repository.

When you use --verify-data, BorgBackup will not only check the consistency of the repository but also verify the correctness of the data content by comparing the stored checksums with the expected checksums. This can help ensure that the data in the repository hasn't been corrupted or tampered with.

It's important to note that --verify-data can be more resource-intensive and time-consuming compared to a regular borg check because it involves reading and verifying the actual content of the stored data. Use it judiciously, especially for large repositories, as it might take a considerable amount of time and resources.

In summary, you might choose to use --verify-data when you want an extra level of assurance about the integrity of the data stored in your BorgBackup repository. Regular use of this option, along with routine checks, contributes to maintaining the reliability of your backups.




[walt@web ~]$ ls important-files/
100.txt  996.txt  Toreador_song_cleaned.ogg  bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4  test.txt
[walt@web ~]$ rm --recursive --verbose important-files/
removed 'important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4'
removed 'important-files/Toreador_song_cleaned.ogg'
removed 'important-files/100.txt'
removed 'important-files/996.txt'
removed 'important-files/test.txt'
removed directory 'important-files/'

[walt@web ~]$ borg extract --dry-run --list --verbose --strip-components 2 walt@database:/home/walt/backups::first
important-files
important-files/100.txt
important-files/996.txt
important-files/Toreador_song_cleaned.ogg
important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4
[walt@web ~]$ borg extract --list --verbose --strip-components 2 walt@database:/home/walt/backups::first
important-files
important-files/100.txt
important-files/996.txt
important-files/Toreador_song_cleaned.ogg
important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4
[walt@web ~]$ ls -al important-files/
total 117828
drwxr-xr-x. 2 walt walt       121 Jan  6 15:38 .
drwx------. 6 walt walt       186 Jan  6 18:33 ..
-rw-r--r--. 1 walt walt   5638564 Jan  6 15:38 100.txt
-rw-r--r--. 1 walt walt   2391726 Jan  6 15:38 996.txt
-rw-r--r--. 1 walt walt   1702187 Jan  6 15:38 Toreador_song_cleaned.ogg
-rw-r--r--. 1 walt walt 110916740 Jan  6 15:38 bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4





[walt@web important-files]$ borg create walt@database:/home/walt/backups::third ~/important-files/

[walt@web important-files]$ borg info walt@database:/home/walt/backups
Repository ID: d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Location: ssh://walt@database/home/walt/backups
Encrypted: Yes (repokey)
Cache: /home/walt/.cache/borg/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
Security dir: /home/walt/.config/borg/security/d433e4d168b39dfaad6942e5cbfe6c972b9853ad2d2d2782975da1279911a32d
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
All archives:              361.95 MB            352.51 MB            117.52 MB

                       Unique chunks         Total chunks
Chunk index:                      71                  197




[walt@web important-files]$ borg info walt@database:/home/walt/backups::third
Archive name: third
Archive fingerprint: 23f75e24cdafee3bcb3d9c89f250b4f3b2cc26f4ccfc82ec1ad64d4ded0dfbd3
Comment:
Hostname: web
Username: walt
Time (start): Sat, 2024-01-06 18:38:03
Time (end): Sat, 2024-01-06 18:38:04
Duration: 0.42 seconds
Number of files: 5
Command line: /usr/bin/borg create walt@database:/home/walt/backups::third /home/walt/important-files/
Utilization of maximum supported archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:              120.65 MB            117.50 MB              4.12 kB
All archives:              361.95 MB            352.51 MB            117.52 MB

                       Unique chunks         Total chunks
Chunk index:                      71                  197




[walt@web important-files]$ borg list walt@database:/home/walt/backups::third
drwxr-xr-x walt   walt          0 Sat, 2024-01-06 18:35:31 home/walt/important-files
-rw-r--r-- walt   walt    5638564 Sat, 2024-01-06 15:38:12 home/walt/important-files/100.txt
-rw-r--r-- walt   walt    2391726 Sat, 2024-01-06 15:38:13 home/walt/important-files/996.txt
-rw-r--r-- walt   walt    1702187 Sat, 2024-01-06 15:38:13 home/walt/important-files/Toreador_song_cleaned.ogg
-rw-r--r-- walt   walt   110916740 Sat, 2024-01-06 15:38:10 home/walt/important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4
-rw-r--r-- walt   walt        146 Sat, 2024-01-06 18:35:31 home/walt/important-files/test2.txt



[walt@web ~]$ crontab -l
*/5 * * * * /home/walt/autobackup.sh





[walt@web ~]$ . autobackup.sh

Sat Jan  6 20:21:03 UTC 2024 Starting backup

Creating archive at "walt@database:/home/walt/backups::autobackup-2024_01_06_20_21_03"
U /home/walt/important-files/100.txt
U /home/walt/important-files/996.txt
U /home/walt/important-files/Toreador_song_cleaned.ogg
U /home/walt/important-files/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4
A /home/walt/important-files/test2.txt
d /home/walt/important-files
------------------------------------------------------------------------------
Repository: ssh://walt@database/home/walt/backups
Archive name: autobackup-2024_01_06_20_21_03
Archive fingerprint: 0e8778b63c32baa1fa8789cf9dcc3fc3d55485dd6f30912423218dfddb3fd324
Time (start): Sat, 2024-01-06 20:21:04
Time (end):   Sat, 2024-01-06 20:21:04
Duration: 0.01 seconds
Number of files: 5
Utilization of max. archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:              120.65 MB            117.50 MB                574 B
All archives:                1.81 GB              1.76 GB            117.52 MB

                       Unique chunks         Total chunks
Chunk index:                      83                  989
------------------------------------------------------------------------------
terminating with success status, rc 0
0

Sat Jan  6 20:21:04 UTC 2024 Pruning repository

Keeping archive (rule: secondly #1):     autobackup-2024_01_06_20_21_03       Sat, 2024-01-06 20:21:04 [0e8778b63c32baa1fa8789cf9dcc3fc3d55485dd6f30912423218dfddb3fd324]
Keeping archive (rule: secondly #2):     autobackup-2024_01_06_20_20_01       Sat, 2024-01-06 20:20:01 [89d990160aee19667f6d13a4a5ae7b8589ccaf9be3a127f2720cc99d370ca56c]
Keeping archive (rule: secondly #3):     autobackup-2024_01_06_20_19_01       Sat, 2024-01-06 20:19:02 [235ef74f08a927ec9ac3fa558824e6023be9e57f4c3cf3681b8ee5c6c82eacb8]
Would prune:                             autobackup-2024_01_06_20_17_38       Sat, 2024-01-06 20:17:39 [12f6730625f293929a07594fb528fc4daea7cfedad1de93e6bb41b89c22d7bbf]
Would prune:                             autobackup-2024_01_06_20_15_34       Sat, 2024-01-06 20:15:34 [a4ea434119def61a3e79f10350cc5634a5ae30e561fc5bd24fc75029db2ed83b]
Would prune:                             autobackup-2024_01_06_20_14_44       Sat, 2024-01-06 20:14:45 [7000021002b1fb8e210ba49c225db35b50c07d02635bc96f42bf2fea4d7d24a3]
Would prune:                             autobackup-2024_01_06_20_12_45       Sat, 2024-01-06 20:12:45 [482e6ff37b1d976acf8951ae5573498034b65d2c7f3145ee51f78fce58591033]
Would prune:                             autobackup-2024_01_06_20_07_41       Sat, 2024-01-06 20:07:42 [0bf5ff0a8ff11ddb403f7162ec14825185c9cfbb12b23f7db8c8107ddf309938]
Would prune:                             backup-2024_01_06_20_04_11           Sat, 2024-01-06 20:04:49 [d202f8eb3e850bed52a2ecce44a6dc0d557ef37272014a1f9b5155e33f4fc6be]
Would prune:                             fifth-2024-01-06T20:02:00            Sat, 2024-01-06 20:02:00 [4895dc72b0906bf2b47539c1873e4df5baa8fb8d433d95975bb68e58fb43dea2]
Would prune:                             forth-2024-01-06T20:01:50            Sat, 2024-01-06 20:01:51 [1ea0569311213e7a9c07fdc75758e79717dffe149289c101efe79e121fcd835c]
Would prune:                             forth                                Sat, 2024-01-06 20:00:57 [e4de22b049c1c331aab64b9177f178dd51a646052696a55fd6f68481cb20a16c]
Would prune:                             third                                Sat, 2024-01-06 18:38:03 [23f75e24cdafee3bcb3d9c89f250b4f3b2cc26f4ccfc82ec1ad64d4ded0dfbd3]
Would prune:                             second                               Sat, 2024-01-06 17:20:39 [f241cd8edb84869131f9374cab89b23d427d4f5f67011d82081ec63f3408048b]
Would prune:                             first                                Sat, 2024-01-06 17:13:21 [22206a55362692fc91f65c1da91a3721652c49d3d98304fae7e1e8becce97a4a]
terminating with success status, rc 0

Sat Jan  6 20:21:04 UTC 2024 Compacting repository


Sat Jan  6 20:21:05 UTC 2024 Backup, Prune, and Compact finished successfully




[walt@web ~]$ borg list
first                                Sat, 2024-01-06 17:13:21 [22206a55362692fc91f65c1da91a3721652c49d3d98304fae7e1e8becce97a4a]
second                               Sat, 2024-01-06 17:20:39 [f241cd8edb84869131f9374cab89b23d427d4f5f67011d82081ec63f3408048b]
third                                Sat, 2024-01-06 18:38:03 [23f75e24cdafee3bcb3d9c89f250b4f3b2cc26f4ccfc82ec1ad64d4ded0dfbd3]
forth                                Sat, 2024-01-06 20:00:57 [e4de22b049c1c331aab64b9177f178dd51a646052696a55fd6f68481cb20a16c]
forth-2024-01-06T20:01:50            Sat, 2024-01-06 20:01:51 [1ea0569311213e7a9c07fdc75758e79717dffe149289c101efe79e121fcd835c]
fifth-2024-01-06T20:02:00            Sat, 2024-01-06 20:02:00 [4895dc72b0906bf2b47539c1873e4df5baa8fb8d433d95975bb68e58fb43dea2]
backup-2024_01_06_20_04_11           Sat, 2024-01-06 20:04:49 [d202f8eb3e850bed52a2ecce44a6dc0d557ef37272014a1f9b5155e33f4fc6be]
autobackup-2024_01_06_20_07_41       Sat, 2024-01-06 20:07:42 [0bf5ff0a8ff11ddb403f7162ec14825185c9cfbb12b23f7db8c8107ddf309938]
autobackup-2024_01_06_20_12_45       Sat, 2024-01-06 20:12:45 [482e6ff37b1d976acf8951ae5573498034b65d2c7f3145ee51f78fce58591033]
autobackup-2024_01_06_20_14_44       Sat, 2024-01-06 20:14:45 [7000021002b1fb8e210ba49c225db35b50c07d02635bc96f42bf2fea4d7d24a3]
autobackup-2024_01_06_20_15_34       Sat, 2024-01-06 20:15:34 [a4ea434119def61a3e79f10350cc5634a5ae30e561fc5bd24fc75029db2ed83b]
autobackup-2024_01_06_20_17_38       Sat, 2024-01-06 20:17:39 [12f6730625f293929a07594fb528fc4daea7cfedad1de93e6bb41b89c22d7bbf]
autobackup-2024_01_06_20_19_01       Sat, 2024-01-06 20:19:02 [235ef74f08a927ec9ac3fa558824e6023be9e57f4c3cf3681b8ee5c6c82eacb8]
autobackup-2024_01_06_20_20_01       Sat, 2024-01-06 20:20:01 [89d990160aee19667f6d13a4a5ae7b8589ccaf9be3a127f2720cc99d370ca56c]
autobackup-2024_01_06_20_21_03       Sat, 2024-01-06 20:21:04 [0e8778b63c32baa1fa8789cf9dcc3fc3d55485dd6f30912423218dfddb3fd324]
[walt@web ~]$ borg list
autobackup-2024_01_06_20_21_03       Sat, 2024-01-06 20:21:04 [0e8778b63c32baa1fa8789cf9dcc3fc3d55485dd6f30912423218dfddb3fd324]
autobackup-2024_01_06_20_25_01       Sat, 2024-01-06 20:25:02 [9fbcbe2bfb4c2ce766c56ca40d4447972796a27e3bd8f70e5da8878cf2f75ac8]
autobackup-2024_01_06_20_30_01       Sat, 2024-01-06 20:30:01 [a1375b17786ed56ab5e95e5a18f411f0464db5f79b6cff5964c9b315d69b0cfd]





[walt@web ~]$ mkdir important-restic-files/
[walt@web ~]$ cd important-restic-files/

[walt@web important-restic-files]$ sudo dnf install -yq restic

Installed:
  restic-0.13.1-1.el9.x86_64





[walt@web important-restic-files]$ curl -L --remote-name-all https://video.blender.org/download/videos/bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4 https://www.gutenberg.org/ebooks/100.txt.utf-8 https://www.gutenberg.org/ebooks/996.txt.utf-8 https://upload.wikimedia.org/wikipedia/commons/4/40/Toreador_song_cleaned.ogg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  105M  100  105M    0     0  4676k      0  0:00:23  0:00:23 --:--:-- 4747k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0    785      0 --:--:-- --:--:-- --:--:--   785
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 5506k  100 5506k    0     0  3139k      0  0:00:01  0:00:01 --:--:-- 14.9M
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   300  100   300    0     0   2500      0 --:--:-- --:--:-- --:--:--  2500
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 2335k  100 2335k    0     0  2121k      0  0:00:01  0:00:01 --:--:-- 2133k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1662k  100 1662k    0     0  6320k      0 --:--:-- --:--:-- --:--:-- 6320k
[walt@web important-restic-files]$ mv 100.txt.utf-8 100.txt
[walt@web important-restic-files]$ mv 996.txt.utf-8 996.txt
[walt@web important-restic-files]$ ls -lh
total 138M
-rw-r--r--. 1 walt walt 5.4M Jan  6 20:42 100.txt
-rw-r--r--. 1 walt walt 2.3M Jan  6 20:42 996.txt
-rw-r--r--. 1 walt walt 1.7M Jan  6 20:42 Toreador_song_cleaned.ogg
-rw-r--r--. 1 walt walt 106M Jan  6 20:42 bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4



[walt@web ~]$ restic init --repo ~/local-restic-repo
enter password for new repository:
enter password again:
created restic repository bb2eae1930 at /home/walt/local-restic-repo

Please note that knowledge of your password is required to access
the repository. Losing your password means that your data is
irrecoverably lost.

[walt@web ~]$ restic --repo ~/local-restic-repo backup ~/important-restic-files/
enter password for repository:
repository bb2eae19 opened successfully, password is correct
no parent snapshot found, will read all files

Files:           4 new,     0 changed,     0 unmodified
Dirs:            3 new,     0 changed,     0 unmodified
Added to the repo: 0 B

processed 4 files, 115.060 MiB in 0:01
snapshot ba2f0230 saved



[walt@web ~]$ RESTIC_PASSWORD='restic'



[walt@web ~]$ restic --repo ~/local-restic-repo backup ~/important-restic-files/
enter password for repository:
repository bb2eae19 opened successfully, password is correct
using parent snapshot ba2f0230

Files:           1 new,     0 changed,     4 unmodified
Dirs:            0 new,     3 changed,     0 unmodified
Added to the repo: 8.466 KiB

processed 5 files, 115.060 MiB in 0:00
snapshot 3ed71414 saved



[walt@web ~]$ restic --repo ~/local-restic-repo snapshots
enter password for repository:
repository bb2eae19 opened successfully, password is correct
ID        Time                 Host        Tags        Paths
----------------------------------------------------------------------------------------
ba2f0230  2024-01-06 20:49:05  web                     /home/walt/important-restic-files
3ed71414  2024-01-06 20:50:48  web                     /home/walt/important-restic-files
----------------------------------------------------------------------------------------
2 snapshots

[walt@web ~]$ RESTIC_PASSWORD=restic
[walt@web ~]$ export RESTIC_PASSWORD

[walt@web ~]$ restic --repo ~/local-restic-repo diff ba2f0230 3ed71414
repository bb2eae19 opened successfully, password is correct
comparing snapshot ba2f0230 to 3ed71414:

+    /home/walt/important-restic-files/testje.txt

Files:           1 new,     0 removed,     0 changed
Dirs:            0 new,     0 removed
Others:          0 new,     0 removed
Data Blobs:      1 new,     0 removed
Tree Blobs:      4 new,     4 removed
  Added:   8.466 KiB
  Removed: 8.004 KiB




[walt@web ~]$ restic --repo ~/local-restic-repo check
using temporary cache in /tmp/restic-check-cache-3587759303
repository bb2eae19 opened successfully, password is correct
created new cache in /tmp/restic-check-cache-3587759303
create exclusive lock for repository
load indexes
check all packs
check snapshots, trees and blobs
[0:00] 100.00%  2 / 2 snapshots...
no errors were found



[walt@web ~]$ restic --repo ~/local-restic-repo check --read-data
using temporary cache in /tmp/restic-check-cache-1206999920
repository bb2eae19 opened successfully, password is correct
created new cache in /tmp/restic-check-cache-1206999920
create exclusive lock for repository
load indexes
check all packs
check snapshots, trees and blobs
[0:00] 100.00%  2 / 2 snapshots...
read all data
[0:01] 100.00%  27 / 27 packs...
no errors were found


[walt@web ~]$ ls important-restic-files/
996.txt  Toreador_song_cleaned.ogg  bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4  testje.txt
[walt@web ~]$ restic --repo ~/local-restic-repo restore latest --target /
repository bb2eae19 opened successfully, password is correct
restoring <Snapshot 3ed71414 of [/home/walt/important-restic-files] at 2024-01-06 20:50:48.732340253 +0000 UTC by walt@web> to /
[walt@web ~]$ ls important-restic-files/
100.txt  996.txt  Toreador_song_cleaned.ogg  bf1f3fb5-b119-4f9f-9930-8e20e892b898-720.mp4  testje.txt



https://restic.readthedocs.io/en/stable/060_forget.html

restic forget --keep-last 1 --prune





