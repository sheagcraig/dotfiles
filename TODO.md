# TODO
- Automatically install ipdb for brewed python.
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
- iTerm stuff needs to require homebrew, but it's commented out
- fonts didn't install (see below)
```
----------
          ID: Init included submodules
    Function: module.run
      Result: False
     Comment: Module function Init included submodules is not available
     Started: 15:53:11.941856
    Duration: 1.541 ms
     Changes:  ˚
```
```
[INFO    ] Executing command '/Users/shea/Developer/dotfiles/files/fonts/install.sh' as user 'shea' in directory '/Users/shea'
[ERROR   ] Command 'su -l shea -c 'cd -- /Users/shea && { /Users/shea/Developer/dotfiles/files/fonts/install.sh
 }'' failed with return code: 127
[ERROR   ] stderr: zsh:1: no such file or directory: /Users/shea/Developer/dotfiles/files/fonts/install.sh
[ERROR   ] retcode: 127
[ERROR   ] {'pid': 17765, 'retcode': 127, 'stdout': '', 'stderr': 'zsh:1: no such file or directory: /Users/shea/Developer/dotfiles/files/fonts/install.sh'}
[INFO    ] Completed state [/Users/shea/Developer/dotfiles/files/fonts/install.sh] at time 15:53:15.636378 (duration_in_ms=3691.513)
```
- pypirc is not in the dotfiles any more?
- remove slack from homebrew (managed by work)
- since gpg was already installed, it was logged as a homebrew error (see brew PR)
- possibly think about removing update/upgrade from brew stuff since I don't really need to manage this stuff after the initial setup
- Need to run vim to kick off vim-plug download.
