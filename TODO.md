# TODO
- Install dropbox before dotfiles; set up require
- Plan out how to make highstate run despite individual state errors.
	- I think it does this by default, unless you set failhard=True
- I forgot about decrypting secrets!
	- Be careful, because the dropbox ones are ansible vault encrypted!
	- I have decrypted copies in the dotfiles secrets dir for now.
	- So I need to create a way to get the secrets from Dropbox and decrypt them either on-the-fly or into the secrets dir.
	- Make sure the secrets dir has no access to external folks, and is gitignored.

# Questions
- I don't like the fact that the highstate top file is in the file root, but I
  then have to either add states/<statename> for each state I want to run, or
  have a single state which then lives at the root of the states dir and does
  the _actual_ association by using includes.
- Figure out what to do about submodules; they're moving into the salt/files
  dir here, which probably means that I need to update the .gitmodules file
  and/or remove and re-add them? Test on a clean repo.
	- This includes, what do I do about VC these?

# Future ideas
- Dynamically specify file roots in minion config
	- This would be a sed line in the power_xtreme script.
- Probably need a way to grab and install salt.


# Ansible Version
- Ansible Galaxy cert is not verifiable out of the box. (had to -c ignore)
- Brew fails the first time; a brew doctor or brew list seems to resolve magically. Then run again.
- Homebrew choked on a man folder not being owned properly
- Dock kill didn't happen.
- Auto-arrange desktop.
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
- Dark theme setting doesn't activate.
