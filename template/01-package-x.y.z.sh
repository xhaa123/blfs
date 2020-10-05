#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/<pack>
 then
  rm -rf /sources/<pack>
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget <link> \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-<basepack> &&

tar xf /sources/<tarball> -C /sources/ &&

cd /sources/<pack> &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
