# Simple command alias that should be the same across all Un*x/*BSD/Linux
alias df='df -h'
alias v='vi'
alias vi='vim'
alias vis='sudo vim'
alias lst='ls -tl'

# docker ailias
alias dcu='docker compose up $1'
alias dcd='docker compose down $1'
alias dri='docker run -it --entrypoint bash $1'

# Aliases for using the ipmitool
alias ipmitool='sudo ipmitool' 

# Alias for sudo commands
alias oports='sudo lsof -nP -iTCP -sTCP:LISTEN'

# Aliases for ansible
alias ap=ansible-playbook

# Aliases/functions for connecting to other machine domains 
function dsh {
  ssh dph@"$1".home.dphtech.com
}

function dth {
  ssh dph@"$1".truckee.dphtech.com
}

# Shortcuts for using and starting Jupyter notebooks.
function jlab-up {
  echo Starting Jypter Lab
  conda activate
  nohup /usr/bin/python3 /home/dph/.local/bin/jupyter-lab --no-browser --port=8889 >> /home/dph/jupyter-lab.log &
  tail -10 /home/dph/jupyter-lab.log
}


