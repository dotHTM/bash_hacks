#!/usr/bin/env bash
# quicksshfs.sh

usage() {
  if [[ $DEBUG_MODE ]]; then
    echo "
    remoteSansColon:  $remoteSansColon
    perlRemoteHost:   $perlRemoteHost
    perlRemotePath:   $perlRemotePath
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
    E) echoCD=1;;          ##
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

remoteSansColon=`echo "${connection}" | perl -pe "s/://gi"`
perlRemoteHost=`echo "${connection//}" | perl -pe "s/:.*//gi"`
perlRemotePath=`echo "${connection//}" | perl -pe "s/.*://gi"`

if [[ $connection == $remoteSansColon ]]; then echo "Incorrect remote format"; usage; fi ##
if [[ -z "${connection}" ]]; then echo "No connection specified"; usage; fi              ##
if [[ -z "${perlRemoteHost}" ]]; then echo "No remote Host specified"; usage; fi         ##
if [[ -z "${perlRemotePath}" ]]; then echo "No remote Path specified"; usage; fi         ##
##

if [[ -z "$volumeName" ]]; then
  volumeName=`echo "$connection" | cut -d "@" -f 2 | tr ":/." "_--"`
fi
if [[ -z "$mountPoint" ]]; then
  mountPoint="/tmp/vol/$volumeName"
fi
if [[ -z "$connection" || -z "$mountPoint" || -z "$volumeName" ]]; then
  usage
fi

## Action modes


if [[ -n $print_mountpoint ]]; then
  echo "$mountPoint"
fi


if [[ -n $print_volume ]]; then
  echo "$volumeName"
fi



if (( $forceUnmountMode )); then 
  diskutil unmount force "${mountPoint}" 1>/dev/null
else
  if (( $unmountMode )); then
    diskutil unmount "${mountPoint}" 1>/dev/null
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
  
  
  if [[ -n "$echoCD" ]]; then
    echo "$domain => \"$path\""
  fi
  
  if [[ -n "$openInLocalShell" ]]; then
    echo "$mountPoint"
  else
    if [[ "$shellOpen" || "$moshOpen" ]]; then
      if (( "$moshOpen" )); then
        echo "; mosh "$domain" -- bash -c \"cd \\\"$path\\\"; ${shellInvokationCommand}\""
        mosh "$domain" -- bash -c "cd \"$path\"; ${shellInvokationCommand}"
      else
        echo "; ssh "$domain" -t \"cd \\\"$path\\\"; ${shellInvokationCommand};\""
        ssh "$domain" -t "cd \"$path\"; ${shellInvokationCommand};"
      fi
    fi
  fi
fi

