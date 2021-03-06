#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/avahi-0.8
 then
  rm -rf /sources/avahi-0.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-avahi &&

tar xf /sources/avahi-0.8.tar.gz -C /sources/ &&

cd /sources/avahi-0.8 &&

# groupadd -fg 84 avahi &&
# useradd -c "Avahi Daemon Owner" -d /var/run/avahi-daemon -u 84 \
#         -g avahi -s /bin/false avahi &&
# 
# groupadd -fg 86 netdev &&


./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static     \
            --disable-libevent   \
            --disable-mono       \
            --disable-monodoc    \
            --disable-python     \
            --disable-qt3        \
            --disable-qt4        \
            --enable-core-docs   \
            --with-distro=none   \
            --with-systemdsystemunitdir=/lib/systemd/system &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&

systemctl enable avahi-daemon &&
systemctl enable avahi-dnsconfd &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
