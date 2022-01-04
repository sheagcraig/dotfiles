# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/shea/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

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

# Python 3.8 + brew management
# export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/python3.8/lib"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/python@3.8/lib/pkgconfig"

# Go Config
export GOPATH=$HOME/Developer/go

# Environment ##################################################################
# If you don't know, now you know.
export GREP_OPTIONS='--color=auto'

# Allow gpg to prompt for a password when invoked by git.
GPG_TTY=$(tty)
export GPG_TTY

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
