#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cryptsetup-2.3.3
 then
  rm -rf /sources/cryptsetup-2.3.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.kernel.org/pub/linux/utils/cryptsetup/v2.3/cryptsetup-2.3.3.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-cryptsetup &&

tar xf /sources/cryptsetup-2.3.3.tar.xz -C /sources/ &&

cd /sources/cryptsetup-2.3.3 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
