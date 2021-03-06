#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wayland-1.18.0
 then
  rm -rf /sources/wayland-1.18.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-wayland &&

tar xf /sources/wayland-1.18.0.tar.xz -C /sources/ &&

cd /sources/wayland-1.18.0 &&

./configure --prefix=/usr    \
            --disable-static \
            --disable-documentation  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
