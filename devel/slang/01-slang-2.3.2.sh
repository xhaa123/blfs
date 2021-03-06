#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/slang-2.3.2
 then
  rm -rf /sources/slang-2.3.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://www.jedsoft.org/releases/slang/slang-2.3.2.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-slang &&

tar xf /sources/slang-2.3.2.tar.bz2 -C /sources/ &&

cd /sources/slang-2.3.2 &&

./configure --prefix=/usr \
            --sysconfdir=/etc \
            --with-readline=gnu &&
${log} `basename "$0"` " configured" blfs_all &&

make -j1 &&
${log} `basename "$0"` " built" blfs_all &&

# make check &&
# ${log} `basename "$0"` " unexpected check succeed" blfs_all
# ${log} `basename "$0"` " expected check fail?" blfs_all &&

make install_doc_dir=/usr/share/doc/slang-2.3.2   \
     SLSH_DOC_DIR=/usr/share/doc/slang-2.3.2/slsh \
     install-all &&

chmod -v 755 /usr/lib/libslang.so.2.3.2 \
             /usr/lib/slang/v2/modules/*.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
