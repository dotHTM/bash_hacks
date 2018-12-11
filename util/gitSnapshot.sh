#!/usr/bin/env bash
# gitSnapshot.sh

if [[ -z ${XPC_SERVICE_NAME/*SourceTree*} ]]; then
  #statements
  repoFolder=$1 && shift
  echo "  * SourceTree Actions"
  cd $repoFolder
else
  echo "  * shell actions"
fi

pwd

echo "  * universal actions"

git commit -m "Snapshot `date "+%Y-%m-%d %H:%M:%S"`"