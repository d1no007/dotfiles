# Zsh login shell script 

# Execute in the background
{
  # Compile the completion dump to increase startup speed
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Initialize Zim
source ${ZIM_HOME}/login_init.zsh -q &!
