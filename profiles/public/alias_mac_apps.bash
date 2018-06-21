


alias sourceTreeOpen="open ./ -a /Applications/SourceTree.app"                  #help= Open the current directory in SourceTree
alias md="open -a /Applications/Marked\ 2.app/ "                                #help= Open a file in the app Marked 2



playground(){ #help= CD to a folder for quick script testing and open that path in Sublime Text
    testDir="${HOME}/priv/test/"
    mkcd $testDir
    subl ${testDir}
}

# Sublime Text Helpers

alias sbashedit="subl ~/.bashrc --project $PROFILE_DIR/../bash_hacks.sublime-project"                                    #help= open the bash_hacks & profile project in Sublime Text
alias smlcedit="subl ~/.bashrc --project $PROFILE_DIR/../../machete-line-commands/machete-line-commands.sublime-project" #help= open the machete-line-commands project in Sublime Text
alias shost="subl -n /etc/hosts"                #help= open the machine hosts file in Sublime Text

## Open a Sublime Text project file here or at some path
#   subproj [../path/that/contains/a/project/]
alias subproj='openFilteredFiles  "*.sublime-project" "subl --project" '    #help= Open a Sublime Text project file here or at some path



function dockSpacerTile() { #args= [apps|docs [small]] #help= Create a blank Dock item on the Apps side
    my_side=$1 && shift
    my_small=$1 && shift
    
    if [[ "${my_side}" =~ "docs" || "docs" =~ "${my_side}" ]]; then
        echo "docs"
        tile_side="persistent-others"
    else
        echo "apps"
        tile_side="persistent-apps"
    fi

    if [[ "${my_small}" =~ "small" || "small" =~ "${my_small}" ]]; then
        echo "small"
        tile_size='{"tile-type"="small-spacer-tile";}' 
    else
        echo "large"
        tile_size='{"tile-type"="spacer-tile";}'
    fi
    defaults \
        write com.apple.dock "${tile_side}" \
        -array-add "$tile_size" \
        && killall Dock
}
