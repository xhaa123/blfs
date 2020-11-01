#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/acpid-2.0.32
 then
  rm -rf /sources/acpid-2.0.32
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/acpid-2.0.32.tar.xz ];  
 then
  wget https://downloads.sourceforge.net/acpid2/acpid-2.0.32.tar.xz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-acpid &&

tar xf /sources/acpid-2.0.32.tar.xz -C /sources/ &&

cd /sources/acpid-2.0.32 &&

./configure --prefix=/usr \
            --docdir=/usr/share/doc/acpid-2.0.32 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install                         &&
install -v -m755 -d /etc/acpi/events &&
cp -r samples /usr/share/doc/acpid-2.0.32 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
