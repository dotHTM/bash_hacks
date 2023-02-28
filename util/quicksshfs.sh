#!/usr/bin/env bash
# quicksshfs.sh


defaultMountParent="/tmp/vol/"

usage() {
  if [[ $DEBUG_MODE ]]; then
    echo "
    remoteSansColon:  $remoteSansColon
    remoteHost:   $remoteHost
    remotePath:   $remotePath
    "
  fi

  echo "Usage: ${0/*\/} [-umosfl] -r [user@]server.com:/remote/path [-v volumeName [-p /path/to/mountPoint]] "
  echo
  echo "  If [/path/to/mountPoint] is ommitted, then /tmp will be the parent folder to the mounted file system."
  echo
  echo "    -h    Print this help"
  echo
  echo "    -u    unmount"
  echo "    -f    force unmount with diskutil"
  echo "    -m    mount disks"
  echo "    -o    Open in Sublime Text in the current open Project window"
  echo "    -n    Open in Sublime Text in a New window (overrides above)"
  echo "    -l    return the path to the mount point (overrides shell connection)"
  echo "    -s    Open an ssh connection to the host"
  echo "    -e    Try to reconnect to a terminal emulator (tmux, then screen) on the remote."
  echo "    -b    Open an mobile-shell (mosh) connection to the host"
  echo "    -P    Print the local mount path."
  echo "    -V    Print the local volume name."
  echo "    -E    Be a little verbose."

  exit 1
}

while getopts "hr:v:p:umosbnedflPVE" inputOptions; do
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
    n) openInSublimeNewWindow=1 ;;      ##
    l) openInLocalShell=1 ;;      ##
    s) shellOpen=1 ;;          ##
    e) screenOpen=1 ;;          ##
    b) moshOpen=1 ;;           ##
    d) DEBUG_MODE=1;;          ##
    P) print_mountpoint=1;;          ##
    V) print_volume=1;;          ##
    E) echoOut=1;;          ##
    ##
    *) usage ;;                ##
    ##
  esac
done
shift $((OPTIND-1))

shellInvokationCommand="\$SHELL"
if (( "$screenOpen" )); then
  shellInvokationCommand="env tmux attach || env tmux || env screen -d -r  || env screen || ${shellInvokationCommand}"
fi

remoteSansColon="${connection/:/}"
remoteHost="${connection/:*/}"
remotePath="${connection/*:/}"

if [[ $connection == $remoteSansColon ]]; then echo "Incorrect remote format"; usage; fi ##
if [[ -z "${connection}" ]]; then echo "No connection specified"; usage; fi              ##
if [[ -z "${remoteHost}" ]]; then echo "No remote Host specified"; usage; fi         ##
if [[ -z "${remotePath}" ]]; then echo "No remote Path specified"; usage; fi         ##
##

if [[ -z "$volumeName" ]]; then
  volumeName=`echo "$connection" | cut -d "@" -f 2 | tr ":/." "_--"`
fi
if [[ -z "$mountPoint" ]]; then
  mountPoint="$defaultMountParent/$volumeName"
fi
if [[ -z "$connection" || -z "$mountPoint" || -z "$volumeName" ]]; then
  usage
fi


platform=`uname`


## Action modes

trashMountPoint(){
  mp=$1 && shift
  if [[ -d $mp ]]; then
    if [[ "$platform" == "Darwin" ]]; then
      mv "$mp" ~/.Trash/"${mp/*\//}__`date "+%s"`"
    else
      echo "idk what to do for your platform to remove/trash this mount point..." >&2
    fi
  fi
}


if (( $forceUnmountMode )); then 
  if [[ -d "${mountPoint}" ]]; then
    if [[ "$platform" == "Darwin" ]]; then
      diskutil unmount force "${mountPoint}" 1>/dev/null
    else
      echo "idk what to do for your platform to unmount this mount point..." >&2
    fi
    trashMountPoint "${mountPoint}"
  fi
elif (( $unmountMode )); then
  if [[ -d "${mountPoint}" ]]; then
    if [[ "$platform" == "Darwin" ]]; then
      diskutil unmount "${mountPoint}" 1>/dev/null
    else
      echo "idk what to do for your platform to unmount this mount point..." >&2
    fi
    trashMountPoint "${mountPoint}"
  fi
fi

if (( "$mount_mode" )); then
  mkdir -p "${mountPoint}"
  sshfs "${connection}" \
  "${mountPoint}" \
  -o reconnect \
  -o auto_cache \
  -o volname="$volumeName" \
  -o gid=`id -g` \
  -o uid=`id -u`
fi

if (( "$openInSublimeNewWindow" )); then
  subl -n "$mountPoint"
elif (( "$openInSublime" )); then
  subl -a "$mountPoint"
fi

if [[ -n "$connection" ]]; then
  
  domain="${connection/:*}"
  path="${connection/*:}"
  
  
  if [[ -n "$echoOut" ]]; then
    echo "$domain => \"$path\""
  fi
  
  if [[ -n "$openInLocalShell" ]]; then
    if [[ -n "$echoOut" ]]; then
      echo "$mountPoint"
    fi
  else
    if [[ "$shellOpen" || "$moshOpen" ]]; then
      if (( "$moshOpen" )); then
        if [[ -n "$echoOut" ]]; then
          echo "; mosh "$domain" -- bash -c \"cd \\\"$path\\\"; ${shellInvokationCommand}\""
        fi
        mosh "$domain" -- bash -c "cd \"$path\"; ${shellInvokationCommand}"
      else
        if [[ -n "$echoOut" ]]; then
          echo "; ssh "$domain" -t \"cd \\\"$path\\\"; ${shellInvokationCommand};\""
        fi
        ssh "$domain" -t "cd \"$path\"; ${shellInvokationCommand};"
      fi
    fi
  fi
fi

if [[ -n $print_mountpoint ]]; then
  echo "$mountPoint"
fi


if [[ -n $print_volume ]]; then
  echo "$volumeName"
fi
