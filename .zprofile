#
# executes commands at login pre-zshrc
#

#
# browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# editors
#
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# language
#
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# paths
#
# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# set the list of directories that zsh searches for programs
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# less 
#
# set the default less options
# mouse-wheel scrolling has been disabled by -X (disable screen clearing)
# remove -X and -F (exit if the content fits on one screen) to enable it
export LESS='-F -g -i -M -R -S -w -X -z-4'

# set the less input preprocessor
# try both `lesspipe` and `lesspipe.sh` as either might exist on a system
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# 
# tmux
#
# fix tmux highlighting issue
export TERM='xterm-256color'

export PATH="$HOME/.cargo/bin:$PATH"
