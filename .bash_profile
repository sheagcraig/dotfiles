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
export GREP_OPTIONS='--color=auto'

# Aliases######################################################################
# Builtin stuff
alias ga='git add'
alias gi='git commit'
alias gs='git status'
alias ls='ls -G'
alias ll='ls -alG'

# My made up aliases
alias pcat='plutil -convert xml1 -o -'
alias slog='tail -f /var/log/system.log'

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
PROMPT_COMMAND='__git_ps1 "[\!][\h]:\w\$" " "'

# Autorun######################################################################
# Fortunes located at /usr/local/var/fortune
if [[ -z "$VIM" ]] && [[ -e /usr/local/bin/fortune ]]; then
	if [[ -e /usr/local/bin/cowsay ]]; then
		fortune | cowsay
	else
		fortune
	fi
fi
