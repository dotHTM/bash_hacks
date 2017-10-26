#!/usr/local/bin/bash
# quicksshfs.sh

usage() {
  if [[ $DEBUG_MODE ]]; then
    echo "
    remoteSansColon:  $remoteSansColon
    perlRemoteHost:   $perlRemoteHost
    perlRemotePath:   $perlRemotePath
    "
  fi

  echo "Usage: ${0/*\/} [-umos] -r [user@]server.com:/remote/path [-v volumeName [-p /path/to/mountPoint]] "
  echo
  echo "  If [/path/to/mountPoint] is ommitted, then /tmp will be the parent folder to the mounted file system."
  echo
  echo "    -h    Print this help"
  echo
  echo "    -u    unmount"
  echo "    -f    force unmount with diskutil"
  echo "    -m    mount disks"
  echo "    -o    Open in Sublime Text"
  echo "    -s    Open an ssh connection to the host"

  exit 1
}

while getopts "hr:v:p:umosdf" inputOptions; do
  case "${inputOptions}" in
    h) usage ;;                ##
    ##
    r) connection=${OPTARG} ;; ##
    v) volumeName=${OPTARG} ;; ##
    p) mountPoint=${OPTARG} ;; ##
    ##
    u) unmountMode=1 ;;        ##
    f) forceUnmountMode=1 ;;   ##
    m) mount_mode=1 ;;         ##
    o) openInSublime=1 ;;      ##
    s) shellOpen=1 ;;          ##
    d) DEBUG_MODE=1;;          ##
    ##
    *) usage ;;                ##
    ##
  esac
done
shift $((OPTIND-1))

remoteSansColon=`echo ${connection} | perl -pe "s/://gi"`
perlRemoteHost=`echo ${connection} | perl -pe "s/:.*//gi"`
perlRemotePath=`echo ${connection} | perl -pe "s/.*://gi"`



if [[ $connection == $remoteSansColon ]]; then echo "Incorrect remote format"; usage; fi ##
if [[ -z "${connection}" ]]; then echo "No connection specified"; usage; fi              ##
if [[ -z "${perlRemoteHost}" ]]; then echo "No remote Host specified"; usage; fi         ##
if [[ -z "${perlRemotePath}" ]]; then echo "No remote Path specified"; usage; fi         ##
##

if [[ -z $volumeName ]]; then
  volumeName=`echo $connection | cut -d "@" -f 2 | tr ":/." "_--"`
fi
if [[ -z $mountPoint ]]; then
  mountPoint="/tmp/vol/$volumeName"
fi
if [[ -z $connection || -z $mountPoint || -z $volumeName ]]; then
  usage
fi

## Action modes

if (( $forceUnmountMode )); then 
  diskutil unmount force ${mountPoint} 
else
  if (( $unmountMode )); then
    umount ${mountPoint} 
  fi
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
    # ssh ${connection/:*}
    ssh ${connection/:*} -t "cd ${connection/*:}; bash" ## --login"
  fi
fi

