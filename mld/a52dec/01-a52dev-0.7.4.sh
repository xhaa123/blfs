#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/a52dec-0.7.4
 then
  rm -rf /sources/a52dec-0.7.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/a52dec-0.7.4.tar.gz ];  
 then
  wget http://liba52.sourceforge.net/files/a52dec-0.7.4.tar.gz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-a52dec &&

tar xf /sources/a52dec-0.7.4.tar.gz -C /sources/ &&

cd /sources/a52dec-0.7.4 &&

./configure --prefix=/usr \
            --mandir=/usr/share/man \
            --enable-shared \
            --disable-static \
            CFLAGS="-g -O2 $([ $(uname -m) = x86_64 ] && echo -fPIC)" &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
cp liba52/a52_internal.h /usr/include/a52dec &&
install -v -m644 -D doc/liba52.txt \
    /usr/share/doc/liba52-0.7.4/liba52.txt &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
