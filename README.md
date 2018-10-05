```
@@@@@@@    @@@@@@   @@@@@@@  @@@@@@@@  @@@  @@@       @@@@@@@@   @@@@@@   
@@@@@@@@  @@@@@@@@  @@@@@@@  @@@@@@@@  @@@  @@@       @@@@@@@@  @@@@@@@   
@@!  @@@  @@!  @@@    @@!    @@!       @@!  @@!       @@!       !@@       
!@!  @!@  !@!  @!@    !@!    !@!       !@!  !@!       !@!       !@!       
@!@  !@!  @!@  !@!    @!!    @!!!:!    !!@  @!!       @!!!:!    !!@@!!    
!@!  !!!  !@!  !!!    !!!    !!!!!:    !!!  !!!       !!!!!:     !!@!!!   
!!:  !!!  !!:  !!!    !!:    !!:       !!:  !!:       !!:            !:!  
:!:  !:!  :!:  !:!    :!:    :!:       :!:   :!:      :!:           !:!   
 :::: ::  ::::: ::     ::     ::        ::   :: ::::   :: ::::  :::: ::   
:: :  :    : :  :      :      :        :    : :: : :  : :: ::   :: : :    
```                                                                          

These are my configs. They can make *your* life a lot better.

To set up, you need to get Salt. Go download and install it...
You'll also need the Xcode developer tools.
1. `sudo xcode-select --install`
1. `sudo xcodebuild -license`

I usually build my machine with the configuration management system I maintain,
so these dependencies are already installed. Also, I use python3 instead of the
Apple-provided system Python, so if it complains about finding pip3 or is
installing packages in "unexpected" places, keep this in mind.

To actually configure the Mac:
1. `cd <this project's folder>`
1. Decrypt the secrets needed into the secrets dir (you will have to create this).
1. Install Homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. Run `./power_extreme.sh`

I've definitely had to do a `rm -rf /var/cache/salt; sudo salt-call --config-dir=$PWD saltutil.sync_modules` to get the pending update to the Homebrew module to sync.

Also, there are some homebrew issues that are not resolved at this time. See the TODO.

Here's what happens:
1. Symlinks dotfiles into place.
	- Some dotfiles are copied where symlinks are not allowed.
1. Installs all homebrew and cask apps on macOS.
1. Git inits submodules
	- For this repo, this primarily consists of vim plugins and Emmet.
1. Installs the fonts used by Powerline/Airline
1. Instructs iTerm2 to use the preferences included in this project.

I used to install all of my common python packages, but since I do that in
virtualenvs these days, I no longer do so.

## Using your own stuff
This installs my dotfiles, brew packages, etc. If you would like to install
your own, you'll need to override the configuration variables and/or pillars.

Some files are pulled from my Dropbox folder since they can't be included on a
public GitHub repo. Feel free to do the same for your own secrets. Just make
sure you encrypt anything that you put up there!

## References
The kind of tricky iTerm2 config is based on
http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
Any changes to the iTerm profile must be saved back out to this file and
committed (although that's true of all the dotfiles).
