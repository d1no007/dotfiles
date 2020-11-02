#!/bin/zsh
# 
# Update cli packages.
#

source ~/.zshrc

# colors
green=`tput setaf 2`
reset=`tput sgr0`

# zim
echo "${green}updating all zsh modules..${reset}"
zimfw upgrade
zimfw update
zimfw install

# brew
echo "${green}updating all homebrew packages..${reset}"
brew update
brew upgrade
brew cleanup
brew doctor

# node 
echo "${green}updating node and npm along with packages..${reset}"
nvm install-latest-npm
nvm use default
