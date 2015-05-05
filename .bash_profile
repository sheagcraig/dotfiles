# Aliases######################################################################

# Builtin stuff
alias ls='ls -G'
# Note: This can cause problems for scripts!
alias grep='grep --color=always'
alias ll='ls -alG'
alias gs='git status'
alias ga='git add'

# My made up aliases
alias pcat='plutil -convert xml1 -o -'
alias slog='tail -f /var/log/system.log'

#Set lovely colors
#export LSCOLORS="gxfxcxdxbxegedabagacad"

# Path Manipulation############################################################

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.2
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.2/bin:${PATH}"
export PATH

# Apparently Python's Mac installer doesn't put in ALL of the required path items to use PyObjC
# Nor does it even HAVE PyObjC. That's available through the OS installed python though
export PYTHONPATH='/System/Library/Frameworks/Python.framework/Versions/Current/Extras/lib/python/PyObjC:/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python'

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
# For some reason I had a note which said "Fortunes located at
# /usr/share/terminfo/66/fortune", which is not the case.
if [ -e /usr/local/bin/fortune ]; then
	if [ -e /usr/local/bin/cowsay ]; then
		fortune | cowsay
	else
		fortune
	fi
fi

# Boxen currently disabled.
#[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
