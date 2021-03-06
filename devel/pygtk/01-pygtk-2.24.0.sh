#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pygtk-2.24.0
 then
  rm -rf /sources/pygtk-2.24.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-pygtk &&

tar xf /sources/pygtk-2.24.0.tar.bz2 -C /sources/ &&

cd /sources/pygtk-2.24.0 &&


sed -i '1394,1402 d' pango.defs &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
