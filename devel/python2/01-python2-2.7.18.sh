#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Python-2.7.18
 then
  rm -rf /sources/Python-2.7.18
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz \
    --continue --directory-prefix=/sources &&

wget https://docs.python.org/ftp/python/doc/2.7.18/python-2.7.18-docs-html.tar.bz2 \
    --continue --directory-prefix=/sources &&

    
md5sum -c ${SCRIPTPATH}/md5-python2 &&

tar xf /sources/Python-2.7.18.tar.xz -C /sources/ &&

cd /sources/Python-2.7.18 &&

./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --with-ensurepip=yes \
            --enable-unicode=ucs4 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make -k test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
chmod -v 755 /usr/lib/libpython2.7.so.1.0 &&
install -v -dm755 /usr/share/doc/python-2.7.18 &&

tar --strip-components=1                     \
    --no-same-owner                          \
    --directory /usr/share/doc/python-2.7.18 \
    -xvf ../python-2.7.18-docs-html.tar.bz2 &&

find /usr/share/doc/python-2.7.18 -type d -exec chmod 0755 {} \; &&
find /usr/share/doc/python-2.7.18 -type f -exec chmod 0644 {} \; &&
python3 -m pip install --force pip &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
