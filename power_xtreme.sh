#!/bin/zsh

# Change to desired secret storage.
SECRETS_SOURCE_DIR="~/Google Drive/boxen/encrypted"

# Create a minion config that points to this dir.
sed "s|{{ PWD }}|$PWD|" minion_template > $PWD/minion

# Install homebrew
which brew &> /dev/null
if [[ $? -ne 0 ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Decrypt secrets if needed
# Ensure the secrets folder exists.
if [[ ! -d $PWD/secrets ]]; then
	mkdir secrets
fi
# Install gpg if needed.
if [[ ! -e "$(which gpg)" ]]; then
	brew install gpg
fi
# Install gdrive if needed.
if [[ ! -e $SECRETS_SOURCE_DIR ]]; then
	echo $SECRETS_SOURCE_DIR
	brew cask install google-backup-and-sync
	open "/Applications/Google Backup and Sync.app"
	read -q "REPLY?Ready to continue?"
fi

# Start decrypting.
if [[ ! -e $PWD/secrets/id_rsa ]]; then
	for f in $SECRETS_SOURCE_DIR/*; do
		gpg --output $PWD/secrets/$f:t --decrypt $f
	done
	chmod -R 700 secrets
fi

# Get submodules set up so we can use them
# This fails if done by Salt :(
git submodule init
git submodule update --remote

sudo /opt/salt/bin/salt-call \
	--config-dir=${PWD} \
	state.apply \
	pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$PWD/secrets'}" 

# Launch zsh if it's not already the shell.
if [[ $(echo $SHELL) == '/bin/bash' ]]; then
	/bin/zsh
fi
