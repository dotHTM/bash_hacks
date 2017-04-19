#!/bin/bash
# quicksshfs.sh

usage() {
 echo "Usage: ${0/*\/} [-s] [-o] -r [user@]server.com:/remote/path [-v volumeName [-m /path/to/mountPoint]] "
 echo
 echo "  If [/path/to/mountPoint] is ommitted, then /tmp will be the parent folder to the mounted file system."
 echo
 echo "    -h    Print this help"
 echo "    -s    Open an ssh connection to the host"
 echo "    -o    Open in Sublime Text"
 exit 1
}

while getopts "hr:v:m:so" intputOptions; do
  case "${intputOptions}" in
    h) usage ;;
    r) connection=${OPTARG} ;;
    v) volumeName=${OPTARG} ;;
    m) mountPoint=${OPTARG} ;;
    s) shellOpen=1 ;;
    o) openInSublime=1 ;;
    *) ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${connection}"  ]; then
  usage
fi

if [[ -z $volumeName ]]; then
  volumeName=`echo $connection | cut -d "@" -f 2 | tr ":/." "_--"`
fi

if [[ -z $mountPoint ]]; then
  mountPoint="/tmp/$volumeName"
fi

if [[ -n $connection && -n $mountPoint && -n $volumeName ]]; then

  mkdir -p ${mountPoint}
  umount ${mountPoint}

  sshfs ${connection} \
  ${mountPoint} \
  -o auto_cache \
  -o volname=$volumeName

  if [[ -n $openInSublime ]]; then
    subl -a $mountPoint
  fi

  if [[ -n $shellOpen ]]; then
    ssh ${connection/:*}
  fi

else
  usage
fi
