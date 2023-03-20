# Path to your oh-my-zsh installation.
export ZSH="/Users/shea/.oh-my-zsh"

ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	history-substring-search
	z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Enable vim line movement
bindkey -v
# But use emacs begin and end of line commands (old habits die hard)
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# Testing this out-up/down arrow substring search
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# Bash habit history search:
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
# Instead of up and down arrow
bindkey '^P' up-history
bindkey '^N' down-history
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias pcat='plutil -convert xml1 -o -'
alias json='python3 -m json.tool'
alias sc='sudo /opt/salt/bin/salt-call'
alias dsc='sudo /opt/salt/bin/salt-call --config-dir=/etc/salt-dev'
alias snowsql='/Applications/SnowSQL.app/Contents/MacOS/snowsql'
# alias sq='cd ~/Developer/sq/'


if [[ $(arch) = arm64 ]]; then
	BREW='/opt/homebrew/bin'
else
	BREW='/usr/local/Cellar'
fi
alias vim="$BREW/vim"
alias fv='$BREW/vim $(fzf)'
sn () {
	ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}'
}
snp () {
	sn | pbcopy
}
function sq {
	cd ~/Developer/sq/
	if [[ $1 != "" ]]; then
		cd $1
	fi
}


# Autorun ######################################################################
# Fortunes located at /usr/local/var/fortune
if [[ -z "$VIM" ]] && [[ -e $BREW/fortune ]]; then
	if [[ -e $BREW/cowsay ]]; then
		fortune | cowsay
	else
		fortune
	fi
fi

# Python Config

# Use ipdb as our debugger by default.
#export PYTHONBREAKPOINT="ipdb.set_trace"

# Choose the python _I want_
 
# Current (2022.11.13) brew does not have a python3 in the 3.11 bin.
# And worse, it does have the "brew" python3 aliased to 3.10. So for now
# I'll just do an alias for python3 and python to python3.11 and move
# the correct install to the front of my path.
# alias python3=python3.11
# alias python=python3.11
# alias pip=pip3.11
# alias pip3=pip3.11
export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/python3.11/lib"
export PKG_CONFIG_PATH="/opt/homebrew/opt/python@3.11/lib/pkgconfig"

# Go Config
export GOPATH=$HOME/Developer/go

# Environment ##################################################################
# If you don't know, now you know.
export GREP_OPTIONS='--color=auto'

# Allow gpg to prompt for a password when invoked by git.
GPG_TTY=$(tty)
export GPG_TTY

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
