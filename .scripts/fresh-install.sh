#!/bin/zsh
# 
# Fresh install script for basic dev apps (and mac apps).
#

cd $HOME 

# general - settings
# remove workspace auto-switching
defaults write com.apple.dock workspaces-auto-swoosh -bool NO
killall Dock
# enable repeating keys 
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# brew - cli
read -n "yn?install and homebrew and packages(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  brew install git
  git config --global user.name "Dino Rodriguez"
  git config --global user.email "dinoorodriguez@gmail.com"
  git config --global credential.helper osxkeychain
  git config --global pull.rebase true

  brew install cask
  brew install hub
  brew install rg
  brew install tmux 
  brew install tree
  brew install vim
  brew install yarn
fi

# brew - apps 
read -n "yn?install mac apps(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  brew cask install iterm2
  brew cask install spectacle
  brew cask install docker
  brew cask install spotify
fi

# dotfiles
read -n "yn?install dotfiles(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  echo ".dot" >> .gitignore
  git clone --bare git@github.com:dino-rodriguez/dotfiles.git $HOME/.dot

  alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
  $dot checkout
  $dot config --local status.showUntrackedFiles no

  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# zim
read -n "yn?install zim(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
fi

# stronghold 
read -n "yn?run stronghold security script(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  pip3 install stronghold
  stronghold
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
    yarn global add typescript pm2 vim-language-server
    pm2 completion install
  fi
fi
