#!/bin/bash


SCRIPT_PATH="$(dirname ${BASH_SOURCE[0]} )"

source $SCRIPT_PATH/../conf/sources.conf

for module in $RACHEL_MODULES; do
  echo "Fetching $module into $MODULE_ROOT"
  content=${MODULE_ROOT}${module}
  rsync -avz ${RSYNC_BASE}${module} $content 
  tar -C ${MODULE_ROOT} -c $module | bzip2 -9 > $ARCHIVE/$module-${VERSION}.tar.bz2

done


