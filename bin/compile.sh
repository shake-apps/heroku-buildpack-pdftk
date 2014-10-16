#!/usr/bin/env bash

BUILD_DIR=$1
CACHE_DIR=$2
ENV_DIR=$3

FILE_NAME='pdftk.tar.gz'
ARCHIVE_NAME='pdftk'
PROFILE_PATH="$BUILD_DIR/.profile.d/pdftk.sh"

mkdir -p $CACHE_DIR
mkdir -p $CACHE_DIR/$ARCHIVE_NAME
mkdir -p $BUILD_DIR/vendor
mkdir -p "$BUILD_DIR/.profile.d"

if [ -d "$ENV_DIR" ] && [ -a "$ENV_DIR/PDFTK_URL" ]; then
  echo "-----> Exporting Environment variables"
  echo "       PDFTK_URL=$(cat $ENV_DIR/PDFTK_URL)"
  export "PDFTK_URL=$(cat $ENV_DIR/PDFTK_URL)"
fi

# make sure PDFTK_URL is set
if [ -z "$PDFTK_URL" ]; then
  echo "-----> You need you set PDFTK_URL"
  echo "       You also need to host PDFTK somewhere"
  exit 1
fi

if ! [ -e $CACHE_DIR/$FILE_NAME ]; then
  echo "-----> Fetching PDFTK binaries from $PDFTK_URL"
  curl $PDFTK_URL -L -o $CACHE_DIR/$FILE_NAME
fi

echo "-----> Extracting PDFTK binaries to ${BUILD_DIR}/vendor/pdftk"
tar jxf $CACHE_DIR/$FILE_NAME -C $CACHE_DIR
mv $CACHE_DIR/$ARCHIVE_NAME $BUILD_DIR/vendor/pdftk

echo "-----> exporting PATH and LIBRARY_PATH"
echo 'export PATH="$PATH:vendor/pdftk/bin"' >> $PROFILE_PATH
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:vendor/pdftk/lib"' >> $PROFILE_PATH
