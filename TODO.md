# TODO
- git submodule init refuses to work from Salt; works just fine from me doing
  it. Move to power extreme if it's going to elude my grasp much longer.
- Zwift install triggers the download in a user session, and homebrew moves on
  and assumes it failed. (Commented out for now)
- Dock gets killed every time
- Start zsh after installing.
- Move power_extreme secrets setup to a state.
- Make sure the secrets dir has no access to external folks, and is gitignored.
- Add "stuff you have to do manually" docs
	- Install Salt...
	- Decrypt secrets into dotfiles folder (Dropbox/boxen/, Ansible vault
	  encrypted.).
	- Safari develop menu
	- Enable messages in iCloud
	- Turn on favicons in Safari
	- System Preferences/Security & Privacy/General/Allow your Apple Watch to
	  unlock your Mac
	- System Preferences/General/Appearance/Dark mode
	- Add Finder sidebar shortcuts.
- pkg.latest doesn't work (homebrew). So I do a brew upgrade + brew cask
  upgrade after a pkg.installed.
	- This runs every time though; I think you can do an `onlyif`, and call
	  `brew outdated` to see if there are any updates. But I have to wait for
	  some new ones to become available to confirm.
