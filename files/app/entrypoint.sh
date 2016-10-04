#!/bin/bash


TARGETDIR=/usr/local/crashplan

if grep -q "0.0.0.0" /var/lib/crashplan/.ui_info 
then
  echo "no need to patch ui_info"
else
  sed -i 's/.[^,]*$/,0.0.0.0/g' /var/lib/crashplan/.ui_info
fi

sed -i "s/<serviceHost>.*</<serviceHost>0.0.0.0</g" "$TARGETDIR"/conf/my.service.xml

if grep -q "serviceUIConfig" "$TARGETDIR"/conf/default.service.xml 
then
  sed -i "s/<serviceHost>.*</<serviceHost>0.0.0.0</g" "$TARGETDIR"/conf/default.service.xml
else
  sed -i "s|</servicePeerConfig>|</servicePeerConfig>\n\t<serviceUIConfig>\n\t\t\
<serviceHost>0.0.0.0</serviceHost>\n\t\t<servicePort>4243</servicePort>\n\t\t\
<connectCheck>0</connectCheck>\n\t\t<showFullFilePath>false</showFullFilePath>\n\t\
</serviceUIConfig>|g" "$TARGETDIR"/conf/default.service.xml

fi

exec "$@"
