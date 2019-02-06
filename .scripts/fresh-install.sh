#!/bin/zsh

cd $HOME 

# brew - cli
read -n "yn?install and homebrew and packages(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew install git
  brew install cask
  brew install kubernetes-cli 
  brew install vim
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
  brew cask install boostnote
  brew cask install slack
  brew cask intall notion
  brew cask install dropbox 
  brew cask install spotify
fi

# dotfiles
read -n "yn?install dotfiles(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  echo ".dot" >> .gitignore
  git clone --bare git@github.com:d1no007/dotfiles.git $HOME/.dot

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

  git clone --recursive git@github.com:d1no007/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

# node
read -n "yn?install nvm/npm/node(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  curl https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh 
  source ~/.zshrc

  nvm install node
  nvm use node

  nvm install-latest-npm
  nvm use default
fi
