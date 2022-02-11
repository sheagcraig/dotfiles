#!/bin/zsh


if [[ $(arch) = arm64 ]]; then
    BREW='/opt/homebrew/bin'
else
    BREW='/usr/local/Cellar'
fi


function help() {
    echo "$0 accepts the following commands:"
    echo "bootstrap (install homebrew and configure salt)"
    echo "decrypt (install gpg and decrypt to dotfiles project)"
    echo "brew (install brew and brew cask apps)"
    echo "go (run the Salt high state)"
    echo "-s <state> (runs one state instead of the entire highstate)"
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
        # Install homebrew if it's not here yet.
        if [[ ! -d $BREW ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        fi

        # Create/update minion config that points to this dir.
        sed "s|{{ PWD }}|$PWD|" minion_template > $PWD/minion
        ;;
    "decrypt")
        # Decrypt secrets if needed
  
        # Change this to desired secret storage.
        SECRETS_SOURCE_DIR=$2
        # Ensure the secrets folder exists.
        if [[ ! -d $PWD/secrets ]]; then
            mkdir secrets
        fi
        # Install gpg if needed.
        if [[ ! -e "$(which gpg)" ]]; then
            $BREW/brew install gpg
        fi

        # Start decrypting.
        if [[ ! -e $PWD/secrets/id_rsa ]]; then
            for f in "$SECRETS_SOURCE_DIR"/*(D); do
                echo $f
                read -q "Hit any key to decrypt"
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
            gh
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
            homebrew/cask/snowflake-snowsql
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

