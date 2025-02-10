#!/usr/bin/env bash
# quicksshfs.sh


defaultMountParent="/tmp/vol/"

platform=`uname`

CT=60

usage() {
  if [[ $DEBUG_MODE ]]; then
    echo "
    remoteSansColon:  $remoteSansColon
    remoteHost:   $remoteHost
    remotePath:   $remotePath
    "
  fi

  echo "Usage: 
  ${0/*\/}  -r [user@]server.com:/remote/path [-a sub/directory/path] [-v volumeName [-p /path/to/mountPoint]] [-ufmonlsebPVE]
  ${0/*\/} [-uf]
  "
  echo
  echo "  If [/path/to/mountPoint] is ommitted, then /tmp will be the parent folder to the mounted file system."
  echo
  echo "    -h        Print this help"
  echo
  echo "Required"
  echo
  echo "    -r <str>  Remote connection string. An SSH host string, followed
                      by a colon (:), and the absolute path to cd into
                      and/or (un)mount from the remote system's root."
  echo
  echo "CONFIG"
  echo
  echo "    -a <str>  Additional subdirectory to append to the defined path
                      in the -r flag. Useful for use in aliases where
                      mounting the parent configured directory is not possible."
  echo
  echo "    -v <str>  The local volume mount name. When displaying in Finder
                      on the Desktop, this name replaces the mount point name."
  echo
  echo "    -p <str>  The local volume mount point."
  echo
  echo "    -c <int>  Set cache_timeout"
  echo 
  echo "    -C <cmd>  run a command" 
  echo 
  echo "ACTIONS"
  echo 
  echo "    -u        unmount"
  echo "    -f        force unmount with diskutil"
  echo "    -m        mount disks"
  echo 
  echo "    -o        Open in Sublime Text in the current open Project window"
  echo "    -n        Open in Sublime Text in a New window (overrides above)"
  echo "    -s        Open an ssh connection to the host"
  echo "    -b        Open an mobile-shell (mosh) connection to the host"
  echo "    -e        Try to reconnect to a terminal emulator (tmux, then screen)
                      on the remote."
  echo
  echo "MESSAGING"
  echo
  echo "    -l        return the path to the mount point (overrides shell connection)"
  echo "    -P        Print the local mount path."
  echo "    -V        Print the local volume name."
  echo "    -E        Be a little verbose."

  exit 1
}

ifEcho(){
  message=$1 && shift
  level=$1 && shift
  if (( ${level} )); then
    echo $message
  fi
}


unmount(){
  path=$1 && shift
  verbose=$1 && shift
  ifEcho  "unmounting      : ${path}" $verbose
  if [[ -d "${path}" ]]; then
    if [[ "$platform" == "Darwin" ]]; then
      diskutil unmount "${path}" 1>/dev/null
    else
      echo "idk what to do for your platform to unmount this mount point..." >&2
    fi
    trashMountPoint "${path}"
  fi
}

forceUnmount(){
  path=$1 && shift
  verbose=$1 && shift
  ifEcho  "force unmounting: ${path}" $verbose
  if [[ -d "${path}" ]]; then
    if [[ "$platform" == "Darwin" ]]; then
      diskutil unmount force "${path}" 1>/dev/null
    else
      echo "idk what to do for your platform to unmount this mount point..." >&2
    fi
    trashMountPoint "${path}"
  fi
}


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






while getopts "hr:a:v:p:c:C:x:umosbnedflPVE" inputOptions; do
  case "${inputOptions}" in
  h) usage ;;                ##
    ##
  r) connection=${OPTARG} ;; ##
  a) appendPath=${OPTARG} ;; ##
  v) volumeName=${OPTARG} ;; ##
  p) mountPoint=${OPTARG} ;; ##
  C) remoteCommand=${OPTARG} ;;          ##
  c) CT=${OPTARG} ;; ##
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

if [[ -z "${connection}" ]];then
  ifEcho  "No connection, eject all mode." $echoOut
  if (( ${unmountMode}  )); then
    for path in `find ${defaultMountParent} -type d -d 1`; do
      unmount "${path}" $echoOut
    done
    exit
  fi
  if (( ${forceUnmountMode}  )); then
    for path in `find ${defaultMountParent} -type d -d 1`; do
      forceUnmount "${path}" $echoOut
    done
    exit
  fi
fi

if [[ -z "${connection}" ]]; then echo "No connection specified"; usage; fi #             
if [[ -z "${remoteHost}" ]]; then echo "No remote Host specified"; usage; fi #        
if [[ -z "${remotePath}" ]]; then echo "No remote Path specified"; usage; fi #        
if [[ $connection == $remoteSansColon ]]; then echo "Incorrect remote format"; usage; fi #


if [[ -n "$appendPath" ]]; then
  connection="${connection}/${appendPath}"
fi
if [[ -z "$volumeName" ]]; then
  volumeName=`echo "$connection" | cut -d "@" -f 2 | tr ":/." "_--"`
fi
if [[ -z "$mountPoint" ]]; then
  mountPoint="$defaultMountParent/$volumeName"
fi
if [[ -z "$connection" || -z "$mountPoint" || -z "$volumeName" ]]; then
  usage
fi



if (( $unmountMode )); then
  unmount "${mountPoint}" $echoOut
fi
if (( $forceUnmountMode )); then 
  forceUnmount "${mountPoint}" $echoOut
fi

if (( "$mount_mode" )); then
  mkdir -p "${mountPoint}"
  sshfs "${connection}" \
    "${mountPoint}" \
    -o reconnect \
    -o cache_timeout="$CT" \
    -o volname="$volumeName" \
    -o gid=`id -g` \
    -o uid=`id -u`
fi

if (( "$openInSublimeNewWindow" )); then
  subl -n "$mountPoint"
elif (( "$openInSublime" )); then
  subl -a "$mountPoint"
fi



domain="${connection/:*}"
path="${connection/*:}"


ifEcho "$domain => \"$path\"" $echoOut

if [[ -n "$remoteCommand" ]]; then
  ssh "$domain" -t "cd \"$path\"; ${remoteCommand};"
fi

if [[ -n "$openInLocalShell" ]]; then
  ifEcho "$mountPoint" $echoOut
else
  if [[ "$shellOpen" || "$moshOpen" ]]; then
    if (( "$moshOpen" )); then
      ifEcho "; mosh "$domain" -- bash -c \"cd \\\"$path\\\"; ${shellInvokationCommand}\"" $echoOut
      mosh "$domain" -- bash -c "cd \"$path\"; ${shellInvokationCommand}"
    else
      ifEcho "; ssh "$domain" -t \"cd \\\"$path\\\"; ${shellInvokationCommand};\"" $echoOut
      ssh "$domain" -t "cd \"$path\"; ${shellInvokationCommand};"
    fi
  fi
fi


ifEcho "$mountPoint" $print_mountpoint
ifEcho "$volumeName" $print_volume
