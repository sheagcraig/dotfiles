alias ls='ls -G'
# Note: This can cause problems for scripts!
alias grep='grep --color=always'
alias ll='ls -laG'
alias slog='tail -f /var/log/system.log'
alias USS='ssh admin@usservices'
alias pcat='plutil -convert xml1 -o -'
export AUS='admin@usservices:~'
# Git helpers
source ~/.git-prompt.sh
source ~/.git-completion.sh
#export PS1='[\!][\[\e[0;31m\u\e\][m@\h]:\w\$ '
#export PS1='[\!][\h]:\w\$ '
export PS1='[\!][\h]:\w$(__git_ps1 " (%s)")\$ '

if [ -e /usr/local/bin/fortune ]; then
	fortune
fi

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH

# Apparently Python's Mac installer doesn't put in ALL of the required path items to use PyObjC
# Nor does it even HAVE PyObjC. That's available through the OS installed python though
#export PYTHONPATH='/System/Library/Frameworks/Python.framework/Versions/Current/Extras/lib/python/PyObjC:/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python'
