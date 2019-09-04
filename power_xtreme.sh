if [[ ! $(which brew) ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

sudo /opt/salt/bin/salt-call \
	--config-dir=${PWD} \
	-l debug \
	saltutil.sync_modules

sudo /opt/salt/bin/salt-call \
	--config-dir=${PWD} \
	-l debug \
	state.apply \
	pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$HOME/Developer/dotfiles/secrets'}" 

