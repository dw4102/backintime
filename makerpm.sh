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
cat rpm/specfile >> ~/rpmbuild/SPECS/$PKGNAME-$PKGVER.$ARCH.spec

rpmbuild -bb ~/rpmbuild/SPECS/$PKGNAME-$PKGVER.$ARCH.spec