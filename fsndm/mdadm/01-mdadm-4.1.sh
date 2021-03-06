#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mdadm-4.1
 then
  rm -rf /sources/mdadm-4.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.kernel.org/pub/linux/utils/raid/mdadm/mdadm-4.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-mdadm &&

tar xf /sources/mdadm-4.1.tar.xz -C /sources/ &&

cd /sources/mdadm-4.1 &&

sed 's@-Werror@@' -i Makefile &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

./test --keep-going --logdir=/log/test-logs --save-logs &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
