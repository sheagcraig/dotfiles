#                                          
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
# -S: Follow symbolic links in recursive mode.
# This causes annoying "recursive" messages when piping.
export GREP_OPTIONS='--color=auto --recursive -S'
# Python is messed up in OS X 10.11. Move my user site-packages up the list.
export PYTHONPATH="$HOME/Library/Python/2.7/lib/python/site-packages"

# Aliases######################################################################
# Builtin stuff
alias ga='git add'
alias gi='git commit'
alias gs='git status'
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
alias jss='python -i $HOME/Developer/python-jss/startup.py'

# Path Manipulation############################################################
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

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
