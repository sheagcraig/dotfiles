#!/bin/zsh

# Install homebrew if it's not here yet.
which brew &> /dev/null
if [[ $? -ne 0 ]]; then
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
            brew install gpg
        fi
        # Install gdrive if needed.
        if [[ ! -e "/Applications/Backup and Sync.app" ]]; then
            brew cask install google-backup-and-sync
        fi
        if [[ ! -e $SECRETS_SOURCE_DIR ]]; then
            open "/Applications/Backup and Sync.app"
            echo "Waiting for everything to finish syncing..."
            read -q "REPLY?Ready to continue?"
        fi

        # Start decrypting.
        if [[ ! -e $PWD/secrets/id_rsa ]]; then
            for f in "$SECRETS_SOURCE_DIR"/*; do
                gpg --output $PWD/secrets/$(basename $f) --decrypt "$f"
            done
            chmod -R 700 secrets
        fi
        ;;
    "brew")
	state="states/homebrew"
	sc
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

