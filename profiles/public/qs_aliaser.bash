# qs_aliaser.bash

if [[ -e $BH_PRIVATE_BASHRC_PATH ]]; then

BH_CONNECTION_LIST=`cat $BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg`

for someServer in $BH_CONNECTION_LIST; do

  serverShortcutName=`echo $someServer | cut -d "@" -f 2 | tr ":/." "_--"`
  hostNickName=`echo $someServer | perl -pe 's/(?:.*@)?(.*):.*/\1/gmi'`
  pathNickName=`echo $someServer | perl -pe 's/\/$//gmi' | perl -pe 's/.*\/.*?/\1/gmi'`
  
  volPath="$hostNickName-$pathNickName"
  
  alias qs_${serverShortcutName}_="quicksshfs.sh -r ${someServer} -v ${volPath} -sumn"
  alias qs_${serverShortcutName}_s="quicksshfs.sh -r ${someServer} -v ${volPath} -s"
  alias qs_${serverShortcutName}_muol="cd \`quicksshfs.sh -r ${someServer} -v ${volPath} -muol\`"
  alias qs_${serverShortcutName}_u="quicksshfs.sh -r ${someServer} -v ${volPath} -u"
  alias qs_${serverShortcutName}_m="quicksshfs.sh -r ${someServer} -v ${volPath} -m"
  alias qs_${serverShortcutName}_n="quicksshfs.sh -r ${someServer} -v ${volPath} -mn"
  alias qs_${serverShortcutName}_no="quicksshfs.sh -r ${someServer} -v ${volPath} -mn"
  alias qs_${serverShortcutName}_o="quicksshfs.sh -r ${someServer} -v ${volPath} -mo"
  alias qs_${serverShortcutName}_f="quicksshfs.sh -r ${someServer} -v ${volPath} -f"
  alias qs_${serverShortcutName}_l="cd \`quicksshfs.sh -r ${someServer} -v ${volPath} -l\`"
done

fi

