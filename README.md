# crashplanpro

## Howto
docker run -d -v /:/storage -p 4243:4243 -p 4242:4242 --name=crashplan --restart=always rungeict/crashplanpro
docker exec crashplan cat /var/lib/crashplan/.ui_info

### firewalld
firewall-cmd --zone=public --add-port=4243/tcp --permanent
firewall-cmd --reload
