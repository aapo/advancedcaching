#!/bin/sh
PKGROOT='maemo/advancedcaching/src/'
VERSION="$1"
BUILD="$2"
if [ "$VERSION" == "" ] ; then 
	echo "gimme version, plz"
	exit
fi
if [ "$BUILD" == "" ] ; then
	echo "gimme build, plz"
	exit
fi
mkdir -p $PKGROOT/usr/share/applications/hildon/
mkdir -p $PKGROOT/usr/share/icons/hicolor/48x48/hildon/
mkdir -p $PKGROOT/opt/advancedcaching/actors
mkdir -p $PKGROOT/opt/advancedcaching/data


cp files/advancedcaching-48.png     $PKGROOT/usr/share/icons/hicolor/48x48/hildon/advancedcaching.png
cp files/advancedcaching-maemo.desktop $PKGROOT/usr/share/applications/hildon/advancedcaching.desktop
cp -R files/advancedcaching/*	 $PKGROOT/opt/advancedcaching/
rm $PKGROOT/opt/advancedcaching/*.pyc
rm $PKGROOT/opt/advancedcaching/*.pyo
rm $PKGROOT/opt/advancedcaching/*.class
rm $PKGROOT/opt/advancedcaching/*~
rm -r $PKGROOT/opt/advancedcaching/advcaching.egg-info
rm -r $PKGROOT/opt/advancedcaching/build
rm -r $PKGROOT/opt/advancedcaching/dist

sed -i -e "s/version = \".*\"/version = \"$VERSION\"/" $PKGROOT/../build_myapp.py
sed -i -e "s/build = \".*\"/build = \"$BUILD\"/" $PKGROOT/../build_myapp.py
cd $PKGROOT
cd ..
python2.5 build_myapp.py

