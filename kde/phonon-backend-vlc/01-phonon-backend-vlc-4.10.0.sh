#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/phonon-backend-vlc-0.11.1
 then
  rm -rf /sources/phonon-backend-vlc-0.11.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://download.kde.org/stable/phonon/phonon-backend-vlc/0.11.1/phonon-backend-vlc-0.11.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-phonon-backend-vlc &&

tar xf /sources/phonon-backend-vlc-0.11.1.tar.xz -C /sources/ &&

cd /sources/phonon-backend-vlc-0.11.1 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr    \
      -DCMAKE_BUILD_TYPE=Release     \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
