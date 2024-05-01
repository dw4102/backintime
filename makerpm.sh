#!/bin/bash

PKGNAME=backintime
PKGVER=$(cat VERSION)
PKGVERNODEV=$(echo $PKGVER | sed 's/-dev//g')
ARCH=all

echo $PKGVERNODEV

if [ -d "../$PKGNAME" ]; then
    mv ../$PKGNAME ../$PKGNAME-$PKGVERNODEV
fi

rpmdev-setuptree
tar -czf ~/rpmbuild/SOURCES/$PKGNAME-$PKGVER.$ARCH.tar.gz ../backintime-$PKGVERNODEV

rpmdev-newspec ~/rpmbuild/SPECS/$PKGNAME-$PKGVER.$ARCH
SPECINFO="Name:           $PKGNAME\nVersion:        $PKGVERNODEV\nRelease:        1%{?dist}\nSummary:        An easy-to-use tool to backup files and folders written in Python3.\nBuildArch:      noarch\n\nLicense:        GPL-2.0\nSource0:        $PKGNAME-$PKGVER.$ARCH.tar.gz\n\nRequires:       bash\n\n%description\nRPM build of backintime\n\n%prep\n%setup -q\n\n%install\ncd \$RPM_BUILD_ROOT/common/ ./configure && make && make test && sudo make install\n\n%files\n%{_bindir}/%{name}.sh\n\n%changelog"
echo -e $SPECINFO > ~/rpmbuild/SPECS/$PKGNAME-$PKGVER.$ARCH.spec

rpmbuild -bb ~/rpmbuild/SPECS/$PKGNAME-$PKGVER.$ARCH.spec