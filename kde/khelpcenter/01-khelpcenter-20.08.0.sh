#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/khelpcenter-20.08.0
 then
  rm -rf /sources/khelpcenter-20.08.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://download.kde.org/stable/release-service/20.08.0/src/khelpcenter-20.08.0.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-khelpcenter &&

tar xf /sources/khelpcenter-20.08.0.tar.xz -C /sources/ &&

cd /sources/khelpcenter-20.08.0 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DBUILD_TESTING=OFF                \
      -Wno-dev ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install  &&

mv -v $KF5_PREFIX/share/kde4/services/khelpcenter.desktop /usr/share/applications/ &&
rm -rv $KF5_PREFIX/share/kde4 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
