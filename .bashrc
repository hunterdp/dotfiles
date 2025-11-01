# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Prompt definition
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# Alias definitions.
# Put all alias additions into a separate file ~/.bash_aliases.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If the mpich mount is mounted, then add it to the path
if [ -d /net/mpich ]; then
  export PATH=/net/mpich/mpich-install/bin:$PATH
fi

# Add the ~/.local/bin to path if it exists
if [ -d $HOME/.local/bin ]; then
  export PATH=/home/dph/.local/bin:$PATH
fi

# Add CUDA  paths if installed
if [ -f /usr/local/cuda/bin/nvcc ]; then
  export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}
  export LD_LIBRARY_PATH=usr/local/cuda-12.3//lib64/${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}}
  export CUDA_HOME=/usr/local/cuda
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi

# conda initialize if installed
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dph/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dph/miniconda/etc/profile.d/conda.sh" ]; then
      . "/home/dph/miniconda/etc/profile.d/conda.sh"  # commented out by conda initialize  # commented out by conda initialize  # commented out by conda initialize
    else
      export PATH="/home/dph/miniconda/bin:$PATH"  # commented out by conda initialize  # commented out by conda initialize  # commented out by conda initialize
    fi
# Add my API Keys if available
# DEMO OpenAI API Key
if [ -f ~/.bash_apikeys ]; then
    . ~/.bash_apikeys
fi

# Setup cargo if installed
if [ -d $HOME/.cargo ]; then
  . "$HOME/.cargo/env"
# Add .cargo to $PATH\nexport PATH="~/.cargo/bin:$PATH"
fi

# Display xxxfetch information on the terminal 
if [ -f /usr/bin/fastfetch ]; then
  /usr/bin/fastfetch
elif [ -f /usr/bin/neofetch ]; then
  /usr/bin/neofetch
fi

# Enable command line completion for kubectl
if [ -f /usr/local/bin/kubectl ]; then
  source <(kubectl completion bash)
fi

# If brew package manager installed
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# If KVM is installed, always connect to the system qemu vs user
if command -v virsh &> /dev/null; then
    export PATH=$PATH:~/.local/bin
    export LIBVIRT_DEFAULT_URI=qemu:///system
fi
