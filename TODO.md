# Ansible Version
- Homebrew installation ends up being done as root, which brew then complains
  about when you try to actually brew anything.
	- Turns out brew doesn't support 10.13 yet; I have the role that is updated to work though. Hmmm.
	- Test soon, then document the solution (chown post-install?)
- First git init prompts to accept github cert.
	- Script no prompt auto accept of ssh?
	- Just deploy to trusted hosts?
- Break out linux stuff into separate playbook or avoid redundent distro== testing.
- Add interactive prompt for whether you want to git submodule update --remote too
- Audit submodules
- Ansible Galaxy doesn't verify SSL (expecting OpenSSL it seems like)
- Quick bootstrap script to:
	- Should be interactive since I won't need all of these all the time.
	- install python3 from python.org
	- install ansible
	- Commandline tools are installed after they are required for the bootstrap
- Show date in time menu bar.
- Add notification to prompt dark theme enablement until I can make it work.

# Outstanding issues
- Ansible won't install with stock macOS python. NBD because my python3 don't want none.
- Brew can't install an app if there's already one there, causing ansible errors.
- Dark theme setting doesn't activate.
