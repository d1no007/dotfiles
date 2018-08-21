#!/bin/zsh

# colors
green=`tput setaf 2`
reset=`tput sgr0`

# create basic config
npm init -y

read -n "yn?install and configure typescript (y/n)? "
if [[ "$yn" == [Yy] ]] ;
  # create tsconfig and add npm scripts to package.json
  echo "${green}installing and configuring tsc..${reset}"
  npm install typescript @types/node --save
  jq .tsconfig ~/.scripts/init/config.json > tsconfig.json 
  mkdir src ; touch src/index.ts ; mkdir build

  echo "${green}installing and configuring tslint..${reset}"
  npm install tslint --save-dev
  jq .tslint ~/.scripts/init/config.json > tslint.json
  
  echo "${green}injecting scripts into package.json..${reset}"
  jq -s '.[0] * .[1].package' package.json ~/.scripts/init/config.json > tmp.json
  cat tmp.json >| package.json && rm tmp.json 

  echo "${green}installing and configuring jest..${reset}"
  npm install @types/jest ts-jest --save-dev 
  mkdir test

  echo "${green}installing debug..${reset}"
  npm install debug @types/debug --save
then
fi

read "yn?install and configure javascript? (y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  echo "${green}installing and configuring eslint..${reset}"
  npm install eslint eslint-watch --save-dev
  ./node_modules/.bin/eslint --init

  echo "${green}installing and configuring jest..${reset}"
  npm install jest --save-dev 
fi
