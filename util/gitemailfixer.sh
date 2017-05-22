#!/bin/sh

usage() {
 echo "Usage: ${0/*\/} -o 'old@ema.il' -e 'correct@ema.il' -n 'Your Name'"
 echo
 echo "    -h    Print this help"
 echo
 echo "    -o 'your-old-email@example.com'"
 echo "    -e 'your-correct-email@example.com'"
 echo "    -n 'Your Correct Name'"
 exit 1
}

while getopts "ho:e:n:" intputOptions; do
  case "${intputOptions}" in
    h) usage ;;
    o) OLD_EMAIL=${OPTARG} ;;
    e) CORRECT_EMAIL=${OPTARG} ;;
    n) CORRECT_NAME=${OPTARG} ;;
    *) ;;
  esac
done
shift $((OPTIND-1))

if [[ -n $OLD_EMAIL && -n $CORRECT_EMAIL && -n $CORRECT_NAME ]]; then

#
git filter-branch -f --env-filter "
if [ \"\$GIT_COMMITTER_EMAIL\" = \"$OLD_EMAIL\" ]
then
    export GIT_COMMITTER_NAME=\"$CORRECT_NAME\"
    export GIT_COMMITTER_EMAIL=\"$CORRECT_EMAIL\"
fi
if [ \"\$GIT_AUTHOR_EMAIL\" = \"$OLD_EMAIL\" ]
then
    export GIT_AUTHOR_NAME=\"$CORRECT_NAME\"
    export GIT_AUTHOR_EMAIL=\"$CORRECT_EMAIL\"
fi
" --tag-name-filter cat -- --branches --tags

fi