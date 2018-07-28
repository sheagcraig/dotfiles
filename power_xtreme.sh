# sudo salt-call \
# 	--config-dir=${PWD} \
# 	-l debug \
# 	saltutil.sync_modules 

sudo salt-call \
	--config-dir=${PWD} \
	-l debug \
	state.highstate \
	pillar="{'user': '$USER', 'home': '$HOME', 'secrets_dir': '$HOME/Developer/dotfiles/secrets'}" 
