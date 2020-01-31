#!/bin/zsh

# Change to desired secret storage.
SECRETS_SOURCE_DIR=~/Dropbox/boxen/encrypted

# Create a minion config that points to this dir.
sed "s|{{ PWD }}|$PWD|" minion_template > $PWD/minion

# Install homebrew
which brew &> /dev/null
if [[ $? -ne 0 ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Decrypt secrets if needed
# Ensure the secrets folder exists.
if [[ ! -d $PWD/secrets ]]; then
	mkdir secrets
fi
# Install gpg if needed.
if [[ ! $(which gpg) ]]; then
	brew install gpg
fi
# Install dropbox if needed.
#if [[ ! -e $SECRETS_SOURCE_DIR ]]; then
#	echo $SECRETS_SOURCE_DIR
#	brew cask install dropbox
#	open /Applications/Dropbox.app
#	read -q "REPLY?Ready to continue?"
#fi
# Start decrypting.
if [[ ! -e $PWD/secrets/id_rsa ]]; then
	for f in $SECRETS_SOURCE_DIR/*; do
		gpg --output $PWD/secrets/$f:t --decrypt $f
	done
	chmod -R 700 secrets
fi

# Sync all additional modules.
# Commented out as there are none needed at this time.
sudo /opt/salt/bin/salt-call \
	--config-dir=${PWD} \
	-l debug \
	saltutil.sync_modules

sudo /opt/salt/bin/salt-call \
	--config-dir=${PWD} \
	-l debug \
	state.apply \
	pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$PWD/secrets'}" 


brew cask install atom
brew cask install chromedriver
brew cask install dropbox
brew cask install dwarf-fortress-lmp
brew cask install evernote
brew cask install google-earth-pro
brew cask install google-hangouts
brew cask install grandperspective
brew cask install handbrake
brew cask install iterm2
brew cask install openemu
brew cask install pacifist
brew cask install packages
brew cask install qlmarkdown
brew cask install skitch
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install suspicious-package
brew cask install trainerroad
brew cask install vlc
brew cask install vmware-fusion
brew cask install wireshark

# Launch zsh if it's not already the shell.
if [[ $(echo $SHELL) == '/bin/bash' ]]; then
	/bin/zsh
fi
