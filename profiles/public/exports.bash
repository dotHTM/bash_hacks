# exports.sh

export CLICOLOR=1
export LSCOLORS=ehgxfxcxbxExDxBxBxbhbh

# - Export Paths
pathsList="/opt/local/bin
/opt/local/sbin
/usr/local/bin
/usr/local/sbin
/Applications/Sublime\ Text.app/Contents/SharedSupport/bin"

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

export hackParentPath="${profileDir/\/profiles*}"

for anPath in $hacksPaths; do
	path_add_element "${hackParentPath}/${anPath}"
done

# for anPath in $pathsList; do
while read anPath; do
	path_add_element "$anPath"
done <<< "$pathsList"



export MANPATH=/opt/local/share/man:$MANPATH

perlBaseDir="/Users/$USER/perl5"

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

edsubl(){
	export EDITOR="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
}

# gem

export GEM_HOME="~/.gem"

# other utility settings

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31'



