# Ansible Version
- Homebrew installation ends up being done as root, which brew then complains about when you try to actually brew anything.
	- Turns out brew doesn't support 10.13 yet; I have the role that is updated to work though. Hmmm.
	- Test soon, then document the solution (chown post-install?)
- First git init prompts to accept github cert.
	- Script no prompt auto accept of ssh?
	- Just deploy to trusted hosts?
- Set up so that it can be run locally or as a push
- Break out linux stuff into separate playbook?
- Add interactive prompt for whether you want to git submodule update --remote too
- lint and clean
- Audit submodules
- Add bootstrapping code
	- Install python3 from python.org
	- install certifi and link
		- Do I need certifi?
	- Setup venv and activate.
		- Why did I put this here?

- Ansible won't install with stock macOS python
- Ansible Galaxy doesn't verify SSL (expecting OpenSSL it seems like)
- Homebrew blows up and does nothing.
- Commandline tools are installed after they are required for the bootstrap
- Dark theme setting still doesn't activate
- Show date in time menu bar.

- update syntax to use include_role include_playbook, etc
- Reorder so brew stuff comes last
- but check for dependencies first
- fix pip setup (breaks enrollment package because of our pypiserver.

