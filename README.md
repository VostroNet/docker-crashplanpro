# rungeict/crashplanpro
Centos Image of crashplanpro

## Introduction
Easily manage all of your account and backup device settings online. For IT professionals, remotely manage most of the CrashPlan PRO for Small Business functions from anywhere. Our simple-to-use desktop tools means anyone can restore lost files without assistance.

This docker instance allows for easy headless setup.  Has been tested on CoreOS, Centos, QNAP Containers.

Additional information:
https://www.crashplan.com/en-us/business/
https://support.code42.com/CrashPlan/4/Configuring/Using_CrashPlan_On_A_Headless_Computer


## Deployment

### Volumes
 - /storage

### Ports
 - 4243/TCP
 - 4242/TCP

 
### Command Line
 ``` 
docker run -d -v /:/storage -p 4243:4243 -p 4242:4242 --name=crashplan --restart=always rungeict/crashplanpro
docker exec crashplan cat /var/lib/crashplan/.ui_info

# firewalld
firewall-cmd --zone=public --add-port=4243/tcp --permanent
firewall-cmd --zone=public --add-port=4242/tcp --permanent
firewall-cmd --reload && systemctl restart docker
 ```


## Connecting to Headless Docker Server
Once you have installed and started your Docker Crashplan Instance you will need to connect to it via a GUI from a remote device to configure.

You will need the information contained in the .ui_info file for your remote GUI device:
```
docker exec crashplan cat /var/lib/crashplan/.ui_info
```

On your remote management device update the settings to match:

The contents should appear in the following format:
```
<port>,<token>,<ipaddress_of_server>
```

Update the file and save.  Once complete, restart the CrashPlan service/daemon on your remote management device and login.  You should now be connected to your Docker Instance of CrashPlan.

#### Locations Of .ui_info

##### Windows Vista, 7, 8, 10, Server 2008, and Server 2012
Installed for everyone: C:\ProgramData\CrashPlan\.ui_info
To view this hidden folder, open Windows Explorer and paste the path in the address bar.
Installed per user: C:\Users\<username>\AppData\<Local|Roaming>\CrashPlan\.ui_info
To view this hidden folder, open Windows Explorer and paste the path in the address bar.
##### Windows XP
Installed for everyone: C:\Documents and Settings\All Users\Application Data\CrashPlan\.ui_info
To view this hidden folder, open Windows Explorer and paste the path in the address bar.
Installed per user: C:\Documents and Settings\<username>\Application Data\CrashPlan\.ui_info 
To view this hidden folder, open Windows Explorer and paste the path in the address bar.
##### OS X:
Installed for everyone: /Library/Application Support/CrashPlan/.ui_info
Installed per user: ~/Library/Application Support/CrashPlan/.ui_info
##### Linux
/var/lib/crashplan/.ui_info
##### Solaris
/var/lib/crashplan/.ui_info
