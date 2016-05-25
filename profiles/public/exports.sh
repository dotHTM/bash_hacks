#!/bin/bash
#
# 

export CLICOLOR=1
export LSCOLORS=ehgxfxcxbxExDxBxBxbhbh

# - Export Paths
pathsList="/opt/local/bin
/opt/local/sbin
/usr/local/bin
/Applications/Sublime\ Text.app/Contents/SharedSupport/bin
"

hacksPaths="amuse
docker
filer
web
web/downloaders
web/webcams"

for anPath in $hacksPaths; do
	export PATH="$baseDir/../$anPath${PATH+:}${PATH}"
done

# for anPath in $pathsList; do
while read anPath; do
	export PATH="$anPath${PATH+:}${PATH}"
done <<< "$pathsList"



export MANPATH=/opt/local/share/man:$MANPATH

## Perl stuff
export PATH="/Users/$USER/perl5/bin${PATH+:}${PATH}"
# export PATH
export PERL5LIB="/Users/$USER/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
# export PERL5LIB
export PERL_LOCAL_LIB_ROOT="/Users/$USER/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
# export PERL_LOCAL_LIB_ROOT
export PERL_MB_OPT="--install_base \"/Users/$USER/perl5\""
# export PERL_MB_OPT
export PERL_MM_OPT="INSTALL_BASE=/Users/$USER/perl5"
# export PERL_MM_OPT


# - Set Nano as the default editor
export EDITOR=/usr/bin/nano

