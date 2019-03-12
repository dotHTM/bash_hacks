
if [[ 
    !( $TERM_PROGRAM == "vscode" || $TERM_PROGRAM == "subl" ) &&
     -n $TERM &&
      $TERM != "dumb"
 ]]; then
    export IS_USER_TERM=1
else
    export IS_USER_TERM=0
fi

