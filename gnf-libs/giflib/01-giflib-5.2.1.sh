#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/giflib-5.2.1
 then
  rm -rf /sources/giflib-5.2.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/giflib-5.2.1.tar.gz ];  
 then
  wget https://sourceforge.net/projects/giflib/files/giflib-5.2.1.tar.gz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-giflib &&

tar xf /sources/giflib-5.2.1.tar.gz -C /sources/ &&

cd /sources/giflib-5.2.1 &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make PREFIX=/usr install &&

find doc \( -name Makefile\* -o -name \*.1 \
         -o -name \*.xml \) -exec rm -v {} \; &&

install -v -dm755 /usr/share/doc/giflib-5.2.1 &&
cp -v -R doc/* /usr/share/doc/giflib-5.2.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
