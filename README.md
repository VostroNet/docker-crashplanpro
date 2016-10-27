# rungeict/crashplanpro
Centos Image of crashplanpro

## Introduction
Easily manage all of your account and backup device settings online. For IT professionals, remotely manage most of the CrashPlan PRO for Small Business functions from anywhere. Our simple-to-use desktop tools means anyone can restore lost files without assistance.

https://www.crashplan.com/en-us/business/

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
firewall-cmd --reload && systemctl restart docker
 ```
