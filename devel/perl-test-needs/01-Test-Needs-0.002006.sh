#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Test-Needs-0.002006
 then
  rm -rf /sources/Test-Needs-0.002006
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://cpan.metacpan.org/authors/id/H/HA/HAARG/Test-Needs-0.002006.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-Test-Needs &&

tar xf /sources/Test-Needs-0.002006.tar.gz -C /sources/ &&

cd /sources/Test-Needs-0.002006 &&

perl Makefile.PL &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
