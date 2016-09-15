FROM centos
#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV CRASHPLAN_VERSION=4.7.0

# LC_ALL=en_US.UTF-8"     \
# LANG="en_US.UTF-8"      \
# LANGUAGE="en_US.UTF-8"

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

RUN yum install -y bash wget ca-certificates openssl tar expect findutils coreutils procps cpio grep which

RUN mkdir /tmp/crashplan \
  && mkdir -p /usr/local/crashplan/log/


RUN wget -O- http://download.crashplan.com/installs/linux/install/CrashPlanPRO/CrashPlanPRO_${CRASHPLAN_VERSION}_Linux.tgz \
	| tar -xz --strip-components=1 -C /tmp/crashplan

COPY files/ /

RUN chmod +x /app/crashplan.exp \
  && sync \
  && cd /tmp/crashplan/ \
  && /app/crashplan.exp || exit $?

# Bind the UI port 4243 to the container ip
#RUN sed -i "s|</servicePeerConfig>|</servicePeerConfig>\n\t<serviceUIConfig>\n\t\t\
#       <serviceHost>0.0.0.0</serviceHost>\n\t\t<servicePort>4243</servicePort>\n\t\t\
#       <connectCheck>0</connectCheck>\n\t\t<showFullFilePath>false</showFullFilePath>\n\t\
# </serviceUIConfig>|g" /usr/local/crashplan/conf/default.service.xml

# Install launchers
RUN chmod +rx /app/entrypoint.sh /app/crashplan.sh


# Remove unneccessary directories
RUN rm -rf /boot /home /lost+found /media /mnt /run /srv /usr/local/crashplan/log/* /var/cache/apk/*

#########################################
##              VOLUMES                ##
#########################################
VOLUME [ "/usr/local/crashplan", "/var/lib/crashplan", "/storage" ]

#########################################
##            EXPOSE PORTS             ##
#########################################
EXPOSE 4243 4242

WORKDIR /usr/local/crashplan

ENTRYPOINT ["/app/entrypoint.sh"]
CMD [ "/app/crashplan.sh" ]
