#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xf86-video-ati-19.1.0
 then
  rm -rf /sources/xf86-video-ati-19.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.x.org/pub/individual/driver/xf86-video-ati-19.1.0.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-xf86-video-ati &&

tar xf /sources/xf86-video-ati-19.1.0.tar.bz2 -C /sources/ &&

cd /sources/xf86-video-ati-19.1.0 &&

sed -e 's/miPointer/extern &/' \
    -i src/drmmode_display.h
./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
