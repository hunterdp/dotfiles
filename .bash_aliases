# Simple command alias that should be the same across all Un*x/*BSD/Linux
alias df='df -h'
alias v='vi'
alias vi='vim'
alias vis='sudo vim'

function dsh {
	ssh dph@"$1".home.dphtech.com
}

# Alias for sudo commands


