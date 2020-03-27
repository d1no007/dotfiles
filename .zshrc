#
# Executes commands at the start of an interactive session.
#

### Prezto
# source prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### Plugins
# source plugin manager
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# zplugin plugins
zplug "greymd/docker-zsh-completion"
zplug "zsh-users/zsh-history-substring-search"
zplug "lukechilds/zsh-better-npm-completion"
zplug "glidenote/hub-zsh-completion"
zplug "nnao45/zsh-kubectl-completion"

# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# source plugins and add commands to $PATH
zplug load --verbose

# history substring keybindings
KEYTIMEOUT=1
bindkey -v
if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
fi

### Aliases/Commands
# dotfiles (git alias)
alias dot='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'

# git
alias gs='git status'
alias gsh='git stash'
alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gpsh='git push'
alias gpshu='git push --set-upstream origin'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias ga='git add'
alias gd='git diff'
alias gr='git rebase'
alias gcl='git clone'
alias gch='git checkout'
alias gchb='git checkout -b'
alias grp='git remote prune origin'
alias gb='git branch'

# kubernetes
alias k='kubectl'
alias ka='kubectl apply -Rf' 
alias kd='kubectl delete'
alias kg='kubectl get'
alias kl='kubectl logs'
alias kc='kubectl config current-context'
alias kx='kc | cut -d "_" -f 4'
alias ku='kubectl config use-context'

# kubernetes (switch context)
ks() {
  if [[ $(kx) == "prod" ]] ; then
    ku $(kc | cut -d "_" -f 1-3)_staging
  else
    ku $(kc | cut -d "_" -f 1-3)_prod
  fi
}

# ls 
alias la='ls -la'

# render markdown to browser
rndr-md() { 
  markdown $1 > $1.html; 
  open $1.html; 
  rm $1.html; 
}

# scripts for hydra
alias sc-init='~/dev/strata/scripts/init/init.sh'
alias sc-monitor='~/dev/strata/scripts/monitor.sh'

# tmux
alias tx='tmux -2'
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tk='tmux kill-server'
alias tl='tmux ls'

# tmux 2 pane
tx2() { 
  tmuxn $1 -d;
  tmux split-window -h;
  tmux -2 attach-session -d; 
}

# tmux 3 pane
tx3() { 
  tmuxn $1 -d;
  tmux split-window -h;
  tmux split-window -h;
  tmux select-layout even-horizontal;
  tmux -2 attach-session -d; 
}

# typescript development set up 
ts-init() {
  # new session with 'main' pane
  tn $1 -d -n main -d

  # left - code
  tx split-window -t $1:0 -h;

  # top right - build
  tmux send-keys -t $1:0.1 'npm run buildWatch' C-m
  tx split-window -v;

  # middle right - lint 
  tmux send-keys -t $1:0.2 'npm run lintWatch' C-m
  tx split-window -v;

  # bottom right - test
  tmux send-keys -t $1:0.3 'npm run testWatch' C-m
  tx select-layout main-vertical 
  tx attach-session -d;
}

# util 
alias sz='source ~/.zshrc'
alias timestamp='date -u "+%Y-%m-%dT%H:%M:%S"'

# vim
alias vinstall='vim +PluginInstall +qall'
alias v='vim'

### Completion and PATH
# hydra
export TS_CONFIG_PATH="$HOME/Code/hydra/scripts/init/config.json"

# rust
fpath+=~/.zfunc

# docker
autoload -Uz compinit; compinit

# kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# helm
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

# minikube
if [ $commands[minikube] ]; then
  source <(minikube completion zsh)
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# gcloud 
if [ -f '/Users/dinorodriguez/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dinorodriguez/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/dinorodriguez/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dinorodriguez/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/opt/curl/bin:$PATH"

# fzf
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pm2
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi

# iterm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
