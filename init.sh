#!/usr/bin/env bash

# Yes, it is making 4 server requests.  I don't feel like caching the xml at the moment, if you do, PLEASE send a pull request
# Thanks

sudo apt-get install -y wget xmlstarlet

export WSVER=`wget -q -O- https://www.jetbrains.com/updates/updates.xml | xmlstarlet sel -q -t -v //product[@name=\'WebStorm\']/channel[last\(\)-1]/build/@version -`
export CLVER=`wget -q -O- https://www.jetbrains.com/updates/updates.xml | xmlstarlet sel -q -t -v //product[@name=\'CLion\']/channel[last\(\)-1]/build/@version -`

export WSBUILD=`wget -q -O- https://www.jetbrains.com/updates/updates.xml | xmlstarlet sel -q -t -v //product[@name=\'WebStorm\']/channel[last\(\)-1]/build/@build -`
export CLBUILD=`wget -q -O- https://www.jetbrains.com/updates/updates.xml | xmlstarlet sel -q -t -v //product[@name=\'CLion\']/channel[last\(\)-1]/build/@build -`
echo "CLVER $CLVER"

CLSHORTVER=( ${CLVER//./ } )
WSSHORTVER=( ${WSVER//./ } )
WEBSTORM_HIDDEN_DIR=\.WebStorm${WSSHORTVER[0]}
CLION_HIDDEN_DIR=\.clion${CLSHORTVER[0]}${CLSHORTVER[1]}
mkdir -p ~/$WEBSTORM_HIDDEN_DIR
mkdir -p ~/$CLION_HIDDEN_DIR

rm -Rf downloads
mkdir downloads
cd downloads
#wget -O- http://download-cf.jetbrains.com/cpp/clion-${CLSHORTVER[0]}.${CLSHORTVER[1]}.tar.gz | tar xz
wget -O- http://download-cf.jetbrains.com/cpp/clion-$CLVER.tar.gz | tar xz
wget -O- http://download-cf.jetbrains.com/webstorm/WebStorm-$WSVER.tar.gz | tar xz

WSDIR=`ls|grep -i Web`
CLDIR=`ls|grep -i cli`

echo "WSDIR $WSDIR"
echo "CLDIR $CLDIR"

mkdir -p ~/.dockerizedImages/
cp $WSDIR/bin/webstorm.svg ~/.dockerizedImages/
cp $CLDIR/bin/clion.svg ~/.dockerizedImages/
cd -
cat ClionInContainer.desktop | sed -e "s/CLION_HIDDEN_DIR/$CLION_HIDDEN_DIR/g" | sed -e "s/USER_HOME_DIR/\/home\/$USER/g" > ~/Desktop/tClionInContainer.desktop
cat WebStormInContainer.desktop | sed -e "s/WEBSTORM_HIDDEN_DIR/$WEBSTORM_HIDDEN_DIR/g" | sed -e "s/USER_HOME_DIR/\/home\/$USER/g" > ~/Desktop/tWebStormInContainer.desktop
chmod +x ~/Desktop/tClionInContainer.desktop
chmod +x ~/Desktop/tWebStormInContainer.desktop

cat start.sh.in | sed -e "s/CLION_DIR/$CLDIR/g" | sed -e "s/WEBSTORM_DIR/$WSDIR/g" > start.sh
chmod +x start.sh

cat Dockerfile.in | sed -e "s/WSDIR/$WSDIR/g" | sed -e "s/CLDIR/$CLDIR/g" > Dockerfile

docker build -t webdev .
