#  @@@@@@@    @@@@@@    @@@@@@   @@@  @@@  
#  @@@@@@@@  @@@@@@@@  @@@@@@@   @@@  @@@  
#  @@!  @@@  @@!  @@@  !@@       @@!  @@@  
#  !@   @!@  !@!  @!@  !@!       !@!  @!@  
#  @!@!@!@   @!@!@!@!  !!@@!!    @!@!@!@!  
#  !!!@!!!!  !!!@!!!!   !!@!!!   !!!@!!!!  
#  !!:  !!!  !!:  !!!       !:!  !!:  !!!  
#  :!:  !:!  :!:  !:!      !:!   :!:  !:!  
#   :: ::::  ::   :::  :::: ::   ::   :::  
#  :: : ::    :   : :  :: : :     :   : :  
#
# Environment##################################################################
# If you don't know, now you know.
export EDITOR=/usr/bin/vim
export GREP_OPTIONS='--color=auto'

# Give me those tasty vi readline codes.
set -o vi

# Python#######################################################################
# Only allow Pip to run in a virtualenv
# export PIP_REQUIRE_VIRTUALENV=true
# But if you really want to install in global dir:
# gpip(){
# 	   PIP_REQUIRE_VIRTUALENV="" pip "$@"
# }

# Cache Pip downloads to speed up creating new venvs.
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Enable pip completion 
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip

# Aliases######################################################################
# Builtin stuff
alias ga='git add'
alias gi='git commit'
alias gs='git status'
alias gd='git diff'

if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -G'
    alias ll='ls -alG'
else
    alias ls='ls --color=auto'
    alias ll='ls -al --color=auto'
	alias tmux='tmux -2'
fi

# My made up aliases
alias pcat='plutil -convert xml1 -o -'
alias slog='tail -f /var/log/system.log'
# alias jss='python -i $HOME/Developer/python-jss/startup.py'

# Path Manipulation############################################################

# Git helpers##################################################################
source ~/.git-prompt.sh
source ~/.git-completion.sh
GIT_PS1_SHOWDIRTYSTATE=TRUE
GIT_PS1_SHOWSTASHSTATE=TRUE
GIT_PS1_SHOWUNTRACKEDFILES=TRUE
GIT_PS1_SHOWCOLORHINTS=TRUE
GIT_PS1_SHOWUPSTREAM=auto

# Prompt#######################################################################
#export PS1='[\!][\[\e[0;31m\u\e\][m@\h]:\w\$ '
#export PS1='[\!][\h]:\w\$ '
#export PS1='[\!][\h]:\w$(__git_ps1 " (%s)")\$ '
#PROMPT_COMMAND='__git_ps1 "[\!][\h]:\w\$" " "'

# Autorun######################################################################
# Fortunes located at /usr/local/var/fortune
if [[ -z "$VIM" ]] && [[ -e /usr/local/bin/fortune ]]; then
	if [[ -e /usr/local/bin/cowsay ]]; then
		fortune | cowsay
	else
		fortune
	fi
fi

source ~/.shell_prompt.sh

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.6/bin"
