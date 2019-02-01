#!/bin/bash

green=`tput setaf 2`
reset=`tput sgr0`

cd $HOME 

# brew - cli
echo "${green}installing homebrew packages..${reset}"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git
brew install nvm
brew install cask
brew install kubectl 
brew install vim

# brew - apps 
echo "${green}installing mac apps..${reset}"
brew cask install google-chrome
brew cask install iterm2
brew cask install spectacle
brew cask install spotify
brew cask install boostnote
brew cask install dropbox 

# dotfiles
echo "${green}installing dotfiles..${reset}"
echo ".dot" >> .gitignore
git clone --bare git@github.com:d1no007/dotfiles.git $HOME/.dot

dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
$dot checkout .
$dot config --local status.showUntrackedFiles no

# prezto
echo "${green}installing prezto for zsh..${reset}"
chsh -s /bin/zsh

git clone --recursive git@github.com:d1no007/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# node
echo "${green}installing npm..${reset}"
nvm install-latest-npm
nvm use default

# vim
echo "${green}installing vundle..${reset}"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
