#!/bin/zsh

# source scripts
. ~/.zshrc

# colors
green=`tput setaf 2`
reset=`tput sgr0`

# brew
echo "${green}updating all homebrew packages..${reset}"
brew update
brew upgrade
brew cleanup
brew prune 
brew doctor

# node 
echo "${green}updating node and npm along with packages..${reset}"
nvm install-latest-npm
