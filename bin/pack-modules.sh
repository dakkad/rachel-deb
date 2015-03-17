#!/bin/bash


SCRIPT_PATH="$(dirname ${BASH_SOURCE[0]} )"

source $SCRIPT_PATH/../conf/sources.conf

CD=$PWD

echo "Fetching rachel content"
if [ -d content ]; then
  cd $SCRIPT_PATH/../content
  git pull origin master
  cd $CD
else
  git clone $RACHEL_CONTENT content
fi 

echo "Packing rachel content into $ARCHIVE"
tar -c content/* | bzip2 -9 > $ARCHIVE/content-${VERSION}.tar.bz2

cd $CD

echo "Packing modules"
for module in $RACHEL_MODULES; do
  echo "Fetching $module into $MODULE_ROOT"
  content=${MODULE_ROOT}${module}
  echo "Syncing ${RSYNC_BASE}${module} into $content"
  rsync -avz ${RSYNC_BASE}${module} $content 
  echo "Zipping $MODULE_ROOT $module to $ARCHIVE/$module-${VERSION}.tar.bz2"
  tar -C ${MODULE_ROOT} -c $module | bzip2 -9 > $ARCHIVE/$module-${VERSION}.tar.bz2  
done

echo "Creating debs"
cd debs
bzr whoami "$DEBFULLNAME <$DEBEMAIL>"
for module in $RACHEL_MODULES; do 
  dh_make -s -p ${module}_${VERSION} -f ../$ARCHIVE/$module-${VERSION}.tar.bz2
done

