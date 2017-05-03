#!/usr/local/bin/bash
# quicksshfs.sh

usage() {
  echo "Usage: ${0/*\/} [-umos] -r [user@]server.com:/remote/path [-v volumeName [-p /path/to/mountPoint]] "
  echo
  echo "  If [/path/to/mountPoint] is ommitted, then /tmp will be the parent folder to the mounted file system."
  echo
  echo "    -h    Print this help"
  echo
  echo "    -u    unmount"
  echo "    -m    mount disks"
  echo "    -o    Open in Sublime Text"
  echo "    -s    Open an ssh connection to the host"

  exit 1
}

while getopts "hr:v:p:umos" intputOptions; do
  case "${intputOptions}" in
    h) usage ;;

    r) connection=${OPTARG} ;;
    v) volumeName=${OPTARG} ;;
    p) mountPoint=${OPTARG} ;;

    u) unmountMode=1 ;;
    m) mount_mode=1 ;;
    o) openInSublime=1 ;;
    s) shellOpen=1 ;;

    *) usage ;;
esac
done
shift $((OPTIND-1))

if [[ -z "${connection}" ]]; then
  usage
fi
if [[ -z $volumeName ]]; then
  volumeName=`echo $connection | cut -d "@" -f 2 | tr ":/." "_--"`
fi
if [[ -z $mountPoint ]]; then
  mountPoint="/tmp/vol/$volumeName"
fi
if [[ -z $connection || -z $mountPoint || -z $volumeName ]]; then
  usage
fi

# Action modes

if (( $unmountMode )); then
  umount ${mountPoint}
fi

if (( $mount_mode )); then
  mkdir -p ${mountPoint}
  sshfs ${connection} \
  ${mountPoint} \
  -o auto_cache \
  -o volname=$volumeName
fi

if (( $openInSublime )); then
  subl -a $mountPoint
fi

if [[ -n $connection ]]; then
  if (( $shellOpen )); then
    ssh ${connection/:*}
  fi
fi

