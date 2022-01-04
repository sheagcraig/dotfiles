#!/bin/zsh

# Install homebrew if it's not here yet.
if [[ $(arch) = arm64 ]]; then
        BREW='/opt/homebrew/bin/brew'
else
        BREW='/usr/local/Cellar/brew'
fi
if [[ ! -f $BREW ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Create/update minion config that points to this dir.
sed "s|{{ PWD }}|$PWD|" minion_template > $PWD/minion

function help() {
	echo "$0 accepts the following commands:"
	echo "bootstrap (install gpg, cloud secrets, and decrypt to dotfiles)"
	echo "brew (install brew and brew cask apps)"
	echo "-s <state> (runs one state instead of the entire highstate)"
	echo "go (run the Salt high state)"
}
function sc() {
        sudo /opt/salt/bin/salt-call \
            --config-dir=${PWD} \
            state.apply $state \
            pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$PWD/secrets'}" 
}

case "$1" in
    "-h" | "--help")
	help
	;;
    "bootstrap")
        # Decrypt secrets if needed
  
        # Change this to desired secret storage.
        SECRETS_SOURCE_DIR=$2
        # Ensure the secrets folder exists.
        if [[ ! -d $PWD/secrets ]]; then
            mkdir secrets
        fi
        # Install gpg if needed.
        if [[ ! -e "$(which gpg)" ]]; then
            $BREW install gpg
        fi
        # Install gdrive if needed.
        if [[ ! -e "/Applications/Backup and Sync.app" ]]; then
            $BREW cask install google-backup-and-sync
        fi
        if [[ ! -e $SECRETS_SOURCE_DIR ]]; then
            open "/Applications/Backup and Sync.app"
            echo "Waiting for everything to finish syncing..."
            read -q "REPLY?Ready to continue?"
        fi

        # Start decrypting.
        if [[ ! -e $PWD/secrets/id_rsa ]]; then
            for f in "$SECRETS_SOURCE_DIR"/*(D); do
		echo $f
                $BREW/gpg --output $PWD/secrets/$(basename $f) --decrypt "$f"
            done
            chmod -R 700 secrets
        fi
        ;;
    "brew")
	HOMEBREW_PKGS=(
            awscli
            cowsay
            dockutil
            enchant
            figlet
            fortune
            fzf
            go
            gpg
            joplin
            libdvdcss
            nethack
            nmap
            pandoc
	    pinentry-mac
            postgresql
            readline
            reattach-to-user-namespace
            sqlite
            tmux
            tree
            vim
            youtube-dl
            homebrew/cask/atom
            homebrew/cask/calibre
            homebrew/cask/chromedriver
            homebrew/cask/dwarf-fortress-lmp
            homebrew/cask/evernote
            homebrew/cask/grandperspective
            homebrew/cask/handbrake
            homebrew/cask/iterm2
            homebrew/cask/joplin
            homebrew/cask/openemu
            homebrew/cask/pacifist
            homebrew/cask/packages
            homebrew/cask/qlmarkdown
            homebrew/cask/skitch
            homebrew/cask/spotify
            homebrew/cask/steam
            homebrew/cask/suspicious-package
            homebrew/cask/trainerroad
            homebrew/cask/vlc
            homebrew/cask/wireshark)
	for pkg in $HOMEBREW_PKGS; do
	    $BREW/brew install $pkg
	done;
	;;
    "-s")
	state=$2
	sc
        ;;
    "go")
	state=""
	sc

        # Launch zsh if it's not already the shell.
        if [[ $(echo $SHELL) == '/bin/bash' ]]; then
            /bin/zsh
        fi
        ;;
    *)
	help
	;;
esac

