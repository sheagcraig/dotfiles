# Ansible Version
- luggage stuff needs become, but my role cannot yet account for that.
- Homebrew installation ends up being done as root, which brew then complains about when you try to actually brew anything.
	- Turns out brew doesn't support 10.13 yet; I have the role that is updated to work though. Hmmm.
- First git init prompts to accept github cert.
- My github key had wrong permissions. I've fixed it, but the dotfiles role doesn't check and fix. Also, it did it wrong initially (private had 600, got 644)
- Set up so that it can be run locally or as a push
- Break out linux stuff into separate playbook?
- Add interactive prompt for whether you want to git submodule update --remote too
- lint and clean
- Audit submodules
- Add bootstrapping code
	- Install python3 from python.org
	- install certifi and link
	- Setup venv and activate.


- ANsible won't install with stock macOS python
- Ansible Galaxy doesn't verify SSL (expecting OpenSSL it seems like)
- Homebrew blows up and does nothing.
- Commandline tools are installed after they are required for the bootstrap
- Dark theme setting still doesn't activate
- Show date in time menu bar.

- update syntax to use include_role include_playbook, etc
- Reorder so brew stuff comes last
- but check for dependencies first
- Fix perms given to "special" dot files
- fix pip setup (breaks enrollment package because of our pypiserver.

