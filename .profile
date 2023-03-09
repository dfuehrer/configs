export PROFILE_VERSION=3
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export PATH=$HOME/.local/bin/scripts:$HOME/.local/bin:$PATH:$XDG_CONFIG_HOME/emacs/bin/
# well i wanted to do nvim -p so i could easily have it just open in new tabs but things had issues casue 'nvim -p' isnt a command
export EDITOR=/usr/bin/nvim
export TERMINAL=alacritty
export TABBED_TERMINAL="tabbed -c -r 2 alacritty --embed ''"
export BROWSER=brave
#export BROWSER='tabbed -c surf -ge'
export BASH_ENV=$XDG_CONFIG_HOME/bash/bashrc
#export SHELL="/bin/bash --rcfile $BASH_ENV"
export SCRIPT_SHELL=/bin/sh
export PAGER='less -R'
export SUDO_ASKPASS=$HOME/.local/bin/scripts/dmenupass
export XRESOURCES=$XDG_CONFIG_HOME/Xresources
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export FZF_DEFAULT_OPTS='--layout=reverse --height=50%'
export HIGHLIGHT_DATADIR=$XDG_CONFIG_HOME/highlight
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH=$XDG_DATA_HOME/go
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hist"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export DVTM_PAGER='less -R'
export BAT_THEME=code-dark
export UCOLLAGE_RESIZE=1
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"


# set the current semester path variable
[ $(date +%-m) -ge 8 ] && { YEAR=$(date +%Y) && NYEAR=$(( $YEAR+1 )) && SEMESTER=Fall; } || { NYEAR=$(date +%Y) && YEAR=$(( $NYEAR-1 )) && SEMESTER=Spring; }
export SCHWRK="$HOME/schoolWork/$YEAR-$NYEAR/${SEMESTER}Semester/"


## TODO move this out of here
#if [ -f $XDG_CONFIG_HOME/bash/bash_alias ]; then
#    . $XDG_CONFIG_HOME/bash/bash_alias
#fi
alias bash='bash --rcfile $XDG_CONFIG_HOME/bash/bashrc'


# this is needed for mivcots so hopefully this works
export MivcotsResources=$HOME/gitstuffs/MIVCOTS-Public/projects/mivcots/Resources/
. "/home/dfuehrer/.local/share/cargo/env"
