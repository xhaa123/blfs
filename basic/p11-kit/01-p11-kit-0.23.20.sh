#!/bin/bash

${log} `basename "$0"` " started" blfs_basic &&

if test -d /sources/p11-kit-0.23.20
 then
  rm -rf /sources/p11-kit-0.23.20
fi

tar xf /sources/p11-kit-0.23.20.tar.xz -C /sources/ &&

cd /sources/p11-kit-0.23.20 &&

sed '20,$ d' -i trust/trust-extract-compat.in &&
cat >> trust/trust-extract-compat.in << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Generate a new trust store
/usr/sbin/make-ca -f -g
EOF


./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --with-trust-paths=/etc/pki/anchors &&
${log} `basename "$0"` " configured" blfs_basic &&

make && 
${log} `basename "$0"` " build" blfs_basic &&

make check &&          #Ignoring result, not related to root user
${log} `basename "$0"` " Unexpected Test succeeded" blfs_basic
${log} `basename "$0"` " expected test fail?" blfs_basic &&

make install &&
ln -sfv /usr/libexec/p11-kit/trust-extract-compat \
        /usr/bin/update-ca-certificates &&
${log} `basename "$0"` " installed" blfs_basic &&
ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so &&
${log} `basename "$0"` " finished" blfs_basic
