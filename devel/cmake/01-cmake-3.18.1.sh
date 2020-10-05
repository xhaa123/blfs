#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/cmake-3.18.1
 then
  rm -rf /sources/cmake-3.18.1
fi

${log} `basename "$0"` " Downloading" blfs_all &&
wget https://cmake.org/files/v3.18/cmake-3.18.1.tar.gz \
--continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-cmake &&

tar xf /sources/cmake-3.18.1.tar.gz -C /sources/ &&

cd /sources/cmake-3.18.1 &&



sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake &&

./bootstrap --prefix=/usr        \
            --system-libs        \
            --mandir=/share/man  \
            --no-system-jsoncpp  \
            --no-system-librhash \
            --docdir=/share/doc/cmake-3.18.1  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " build" blfs_all &&

bin/ctest -j8 -O cmake-3.18.1-test.log && 
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
