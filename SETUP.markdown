R instructions
==============

Comments:
--------
R is a scripting language normally run from an interpreter, and does not really come with a web front end, so I just read the file in from disk rather than importing via a form.  I hope this is OK.  I also hard-coded both paths and database credentials.  Why?  This is an interpreted language.  Changing the values within the file is just as easy as passing them on a command line.  My take was, if it's devops that's converting files, and we're only going to be doing it a limited number of times, I'd just edit and run the script and it would be OK that it didn't have a nice front end.

Installation of software:
-------------------------

You will need both mySQL and R.  I did this on Windows, so my instructions focus on Windows, but they are available on Linux and Mac as well.

Download MySQL from:
http://dev.mysql.com/downloads/installer/
or
http://dev.mysql.com/downloads/mysql/

set     MYSQL_HOME to a path with no spaces; in my case this was
C:/PROGRA~1/MySQL/MYSQLS~1.6
This will be important when we get to building the RMySQL library.  In Windows you do this from 
Control Panel > System > Advanced Settings > Environment variables.

I believe it also ask you for the name/password of a user to create during installation.  (Since it's already installed on my system, it's hard for me to get back and check.)  I used 
user "root" with password "4science!", which is hard-coded into my script, but can be editted if you use something different.

Download R from :

http://ftp.osuosl.org/pub/cran/
Windows and Mac have binary distributions available there.  For Linux they note
"R is part of many Linux distributions, you should check with your Linux package management system in addition to the link above. " They also offer source distributions.  (There are other mirrors, I just assumed this was a close one for you if you're in Portland.)  Follow the typical installation.

When you start R, it comes up with an interpreter console.  Before you source my R code, you need to install a few packages.

Packages > install packages
choose a mirror
choose package dplyr

Go through again, and choose tidyR.

Now the tricky one: RMySQL isn't available through the drop down menu.  It is not available in binary for Windows.  You will need to run

install.packages("RMySQL", type="source")
which will build it for you.  Make sure that MYSQL_HOME is set and does not contain spaces.


Setup:
-----

Once everything is installed, make a database on mySQL. 
Under Start > All Programs > MySQL  > MySQL Server 5.6, there is a "MySQL Server 5.6 Command Line Client"
Connect using the password you
grant all on mydb.* to root@localhost;

 I used the names "mydb", and the user "root" with password "4science!".  These are hard-coded into my script, so if you use something different, edit the change into the file.  

 You can bring the script up via File > Open Script and edit it within R.
 
Edit the script to change setwd to go to the directory you have the input file in.  If the file name is different from example_in.tab, change that.  Save file.


Run:
---
From the "console" window in R, chose "File > Source R code" and chose convert.R.  

The total purchases (sum of the products of price and number-of-items) will be printed in the R console.

In you mySQL Client Command Line, 
type 
use mydb;
show tables;
select * from purchases;
select * from merchants;
select * from purchasers;

to see the contents of the database tables.





