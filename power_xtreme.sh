sudo salt-call \
	--config-dir=${PWD} \
	-l info \
	state.highstate \
	pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$HOME/Developer/dotfiles/secrets'}" 
