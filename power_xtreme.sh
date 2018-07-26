sudo salt-call \
	--config-dir=${PWD} \
	state.highstate \
	pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$HOME/Developer/dotfiles/secrets'}" 
