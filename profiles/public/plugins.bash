# plugins.sh


plugin_sources='
https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
'

# updates
update_plugins(){
    mkdir -p $PROFILE_DIR/plugins
    cd $PROFILE_DIR/plugins
    for some_source_url in $plugin_sources; do
        if [[ -n $some_source_url ]]; then
            curl -O $some_source_url
        fi
    done
}

# git Stuff
if [ -f $PROFILE_DIR/plugins/git-completion.bash ]; then
    source $PROFILE_DIR/plugins/git-completion.bash
fi

completions_list='
/Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
/Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion
/Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
'

for some_completion_file in $completions_list; do
    if [ -f $some_completion_file ]; then
        source $some_completion_file 
    fi
done