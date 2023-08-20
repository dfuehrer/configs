#
# ~/.bashrc
#

# manually read the profile file to see what version is set
profile_version="$(sed -n 's/export PROFILE_VERSION=\(.\+\)/\1/p' ~/.profile)"
# basically if ive updated the profile file then i should change the version variable at the top and bash will try to source it
[ -n "$PROFILE_VERSION" ] && [ "$PROFILE_VERSION" -eq "$profile_version" ] || . ~/.profile

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# move my bash history (i dont think this worked)
export HISTFILE=$XDG_CACHE_HOME/bash/bash_history
# ignore duplicated lines for history (dont go up through all of them) and ignore lines that start with a space
export HISTCONTROL=ignoreboth

# set the current semester path variable
[ $(date +%-m) -ge 8 ] && { YEAR=$(date +%Y) && NYEAR=$(( $YEAR+1 )) && SEMESTER=Fall; } || { NYEAR=$(date +%Y) && YEAR=$(( $NYEAR-1 )) && SEMESTER=Spring; }
export SCHWRK="$HOME/schoolWork/$YEAR-$NYEAR/${SEMESTER}Semester/"

# cd into a directory without cd
shopt -s autocd
# get a thing to do completions with aliases
. /usr/share/bash-complete-alias/complete_alias
# get general bash completions, git completions, and let me know if i need to get a specific package to run that command
. /usr/share/bash-completion/bash_completion
. /usr/share/git/completion/git-completion.bash
. /usr/share/bash-completion/completions/pass
. /usr/share/doc/pkgfile/command-not-found.bash
. /usr/share/bash-completion/completions/dkms
#. <(arduino-cli completion bash)
#. <(code-minimap completion bash)
#. <(starship completions bash)
#. <(rustup completions bash)
make -C $XDG_CACHE_HOME/bash/completion > /dev/null 2>&1
. $XDG_CACHE_HOME/bash/completion/arduino-cli.sh
. $XDG_CACHE_HOME/bash/completion/code-minimap.sh
. $XDG_CACHE_HOME/bash/completion/starship.sh
. $XDG_CACHE_HOME/bash/completion/rustup.sh
# TODO this doesnt work unless normal printenv has been used for with tab completion before, the function doesnt exist until then
#complete -F _printenv pe
complete -v pe
complete -v export
complete -c doas
complete -F _complete_alias config-git
complete -F _complete_alias confg
complete -F _complete_alias sys-config-git
complete -F _complete_alias sconfg
complete -F _complete_alias hi
complete -F _complete_alias p
complete -F _command tabbed
complete -F _command setsid
# dont need these casue theyre in my inputrc
#bind '"\C-l": clear-screen'
#set -o vi

# source some aliases and functions from those files
[[ -f $XDG_CONFIG_HOME/bash/bash_alias ]] && . $XDG_CONFIG_HOME/bash/bash_alias
[[ -f $XDG_CONFIG_HOME/bash/bash_function ]] && . $XDG_CONFIG_HOME/bash/bash_function
# set PS1 to have red [ orange username yellow @ green hostname *space* blue short folder red ]$ 
PS1='\[\033[31m\][\[\033[38;5;208m\]\u\[\033[33m\]@\[\033[32m\]\h \[\033[34m\]\W\[\033[31m\]]\[\033[0m\]\$ '
eval "$(starship init bash)"

# append . to end of normal PATH from the .profile
# this makes it so that if im in my bash shell and i try an executable in there that it cant find in the rest of my path itll check in my current directory
# actually this is a bad idea
#export PATH="$PATH:."

. $XDG_CONFIG_HOME/broot/launcher/bash/br
. "$XDG_DATA_HOME/cargo/env"
