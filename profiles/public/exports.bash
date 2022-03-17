# exports.sh

export CLICOLOR=1

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31'


export LSCOLORS=ExFxCxDxBxegedabagacad


# - Export Paths
pathsList=""

if [[ `uname` == 'Darwin' ]]; then ## Mac Specific directories
    pathsList="$pathsList
/opt/local/bin
/opt/local/sbin
/usr/local/bin
/opt/homebrew/bin
/opt/homebrew/sbin
/usr/local/sbin
/usr/local/opt/python/libexec/bin
/usr/local/Cellar/perl/5.26.1/bin
$HOME/Library/Python/3.7/bin
/Applications/Sublime\ Text.app/Contents/SharedSupport/bin
/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin"
fi    
    

hacksPaths=".
amuse
dev
docker
filer
web
util
reference
web/downloaders
web/webcams"

export HACK_PARENT_PATH="${PROFILE_DIR/\/profiles*}"

for anPath in $hacksPaths; do
	path_add_element "${HACK_PARENT_PATH}/${anPath}"
done

# for anPath in $pathsList; do
while read anPath; do
	path_add_element "$anPath"
done <<< "$pathsList"

export MANPATH=/opt/local/share/man:$MANPATH

perlBaseDir="$HOME/perl5"

## Perl stuff
export PATH="${perlBaseDir}/bin${PATH+:}${PATH}"
# export PATH
export PERL5LIB="${perlBaseDir}/lib/perl5${PERL5LIB+:}${PERL5LIB}"
# export PERL5LIB
export PERL_LOCAL_LIB_ROOT="${perlBaseDir}${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
# export PERL_LOCAL_LIB_ROOT
export PERL_MB_OPT="--install_base \"${perlBaseDir}\""
# export PERL_MB_OPT
export PERL_MM_OPT="INSTALL_BASE=${perlBaseDir}"
# export PERL_MM_OPT


# - Set Nano as the default editor
export EDITOR=/usr/bin/nano

ed_subl(){
	export EDITOR="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
}

# gem

export GEM_HOME="$HOME/.gem"

# other utility settings



