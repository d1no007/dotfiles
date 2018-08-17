#!/bin/zsh

SESSION_NAME='monitor'

# colors
green=`tput setaf 2`
reset=`tput sgr0`

# kill any hanging processes on 7771/7770
echo "${green}killing processess on 7771 and 7770${reset}" 
kill $(ps -Afo args | grep 'ssh -N -L 777[01]' | cut -d ' ' -f 4)

# create session
tmux new -s ${SESSION_NAME} -n mofu -d

# first window - mofu (0)
tmux send-keys -t ${SESSION_NAME} 'ssh -N -L 7770:localhost:7770 ubuntu@18.205.38.27' C-m
echo "${green}mofu moneyd-gui running on 7770${reset}"

# second window - scylla (1)
tmux new-window -t ${SESSION_NAME} -n scylla
tmux send-keys -t ${SESSION_NAME}:1 'ssh -N -L 7771:localhost:7769 ubuntu@34.227.15.216' C-m

# moneyd-gui for scylla 
tmux split-window -t ${SESSION_NAME}:1 -v
tmux send-keys -t ${SESSION_NAME}:1.1 'ADMIN_API_PORT=7771 PORT=7772 moneyd-gui' C-m
echo "${green}scylla moneyd-gui running on 7771${reset}"
