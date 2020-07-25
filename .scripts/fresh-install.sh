#!/bin/zsh
# 
# Fresh install script for basic dev apps (and mac apps).
#

cd $HOME 

# brew - cli
read -n "yn?install and homebrew and packages(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  # ruby
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew install git
  brew install cask
  brew install vim
  brew install jq
  brew install yarn
  brew install rg
  brew install redis
  brew install zplug 
  brew install hub
  brew install kubernetes-cli 
  brew install kubernetes-helm
  # envsubst -- to substitute for vars for environment
  brew install gettext
  brew link --force gettext
  # fuzzy finding + key bindings
  brew install fzf
  $(brew --prefix)/opt/fzf/install
fi

# brew - apps 
read -n "yn?install mac apps(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  brew cask install google-chrome
  brew cask install iterm2
  brew cask install spectacle
  brew cask install docker
  brew cask install google-cloud-sdk
  brew cask install postman
  brew cask install slack
  brew cask intall notion
  brew cask install spotify
  brew cask install android-sdk
  brew cask install android-studio
fi

# dotfiles
read -n "yn?install dotfiles(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  echo ".dot" >> .gitignore
  git clone --bare git@github.com:dino-rodriguez/dotfiles.git $HOME/.dot

  dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
  $dot checkout .
  $dot config --local status.showUntrackedFiles no

  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# prezto
read -n "yn?install prezto(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  chsh -s /bin/zsh

  git clone --recursive git@github.com:dino-rodriguez/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

# node
read -n "yn?install nvm/node(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  curl https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh 
  source ~/.zshrc

  nvm install node
  nvm use node

  read -n "yn?install global packages(y/n)? "
  if [[ "$yn" == [Yy] ]] ;
  then
    yarn global add wscat typescript pm2
    pm2 completion install
  fi
fi
