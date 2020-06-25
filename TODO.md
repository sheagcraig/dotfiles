# TODO
- vim stuff
	- fzf
	- nerdtree?
	- vim-go setup
	- Solve folding
	- Color column is not red any more? And does it come on for all filetypes or just python (and vimrc?)
	- Think about wildmode more
- Have salt do the vim-plug install and plugin install
- Automatically install ipdb for brewed python.
- Zwift cask install triggers the app to actually run (it downloads the assets
  and whatnot) in a user session, and homebrew moves on and assumes it failed.
  (Commented out for now)
- pkg.latest doesn't work (homebrew). So I do a brew upgrade + brew cask
  upgrade after a pkg.installed.
- This runs every time though; I think you can do an `onlyif`, and call
  `brew outdated` to see if there are any updates. But I have to wait for
  some new ones to become available to confirm.
- https://github.com/saltstack/salt/pull/57030
- iTerm stuff needs to require homebrew, but it's commented out
- pypirc is not in the dotfiles any more?
- remove slack from homebrew (managed by work)
- since gpg was already installed, it was logged as a homebrew error (see brew PR)
- possibly think about removing update/upgrade from brew stuff since I don't really need to manage this stuff after the initial setup
- Need to run vim to kick off vim-plug download.
- New ssh key
