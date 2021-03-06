#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libksba
 then
  rm -rf /sources/libksba
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.4.0.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libksba &&

tar xf /sources/libksba-1.4.0.tar.bz2 -C /sources/ &&

cd /sources/libksba-1.4.0 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
