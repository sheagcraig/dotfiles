#######################################################
# load Square specific zshrc; please don't change this bit.
#######################################################
source ~/Developer/sq/config_files/square/zshrc
#######################################################

###########################################
# Feel free to make your own changes below.
###########################################

# uncomment to automatically `bundle exec` common ruby commands
# if [[ -f "$SQUARE_HOME/config_files/square/bundler-exec.sh" ]]; then
#   source $SQUARE_HOME/config_files/square/bundler-exec.sh
# fi

# load the aliases in config_files files (optional)
source ~/Developer/sq/config_files/square/aliases

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -f "$HOME/.localaliases" ]] && source "$HOME/.localaliases"

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
alias dsc='sudo /opt/salt/salt-call --config-dir=/etc/salt-dev'
alias snowsql='/Applications/SnowSQL.app/Contents/MacOS/snowsql'
# alias sq='cd ~/Developer/sq/'


if [[ $(arch) = arm64 ]]; then
	BREW='/opt/homebrew/bin'
else
	BREW='/usr/local/Cellar'
fi
export PATH="$PATH:/opt/homebrew/bin"
alias vim="$BREW/vim"
alias fv='$BREW/vim $(fzf)'
sn () {
	ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}'
}
snp () {
	ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{printf "%s",$(NF-1)}' | pbcopy
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

 
# export PATH="/opt/homebrew/opt/python@3.11/bin:/Users/shea/.local/bin:$PATH"
# Choose the python _I want_
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/python3.12/lib"
export PKG_CONFIG_PATH="/opt/homebrew/opt/python@3.12/lib/pkgconfig"

# Go Config
export GOPATH=$HOME/Developer/go

# Rust config
export PATH="/Users/shea/.cargo/bin:$PATH"

# Environment ##################################################################
# If you don't know, now you know.
export GREP_OPTIONS='--color=auto'

# Allow gpg to prompt for a password when invoked by git.
GPG_TTY=$(tty)
export GPG_TTY

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export SSH_AUTH_SOCK="/Users/shea/Library/Application Support/beyond-ssh-agent/agent.sock"
export SSH_AUTH_SOCK=/Users/shea/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
# export SSH_AUTH_SOCK="$(brew --prefix)/var/run/yubikey-agent.sock"

# Created by `pipx` on 2024-06-05 20:22:21
export PATH="$PATH:/Users/shea/.local/bin"
