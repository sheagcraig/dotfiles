# TODO
- git submodule init refuses to work from Salt; works just fine from me doing
  it. Move to power extreme if it's going to elude my grasp much longer.
- Zwift cask install triggers the app to actually run (it downloads the assets
  and whatnot) in a user session, and homebrew moves on and assumes it failed.
  (Commented out for now)
- pkg.latest doesn't work (homebrew). So I do a brew upgrade + brew cask
  upgrade after a pkg.installed.
	- This runs every time though; I think you can do an `onlyif`, and call
	  `brew outdated` to see if there are any updates. But I have to wait for
	  some new ones to become available to confirm.
