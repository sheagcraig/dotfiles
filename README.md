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
so these dependencies are already installed.

To actually configure the Mac:
1. `cd <this project's folder>`
1. Run `./power_extreme.sh`
1. And probably run it a few more times. It never seems to get everything the
   first time...

Alas, one truism of dotfiles is that you spend at least as much time screwing
around with them every time you build a new machine as you would spend just
doing things by hand. The TODO file includes all of the known broken stuff and
planned future management.

Here's what happens:
1. Installs brew if needed
1. Installs Dropbox and opens it to sign in and begin syncing.
1. Decrypts secrets from Dropbox into place.
1. Symlinks dotfiles into place.
	- Some dotfiles are copied where symlinks are not allowed.
1. Installs all homebrew and cask apps on macOS.
1. Git inits submodules
	- For this repo, this primarily consists of vim plugins and Emmet.
1. Installs the fonts used by Powerline/Airline
1. Instructs iTerm2 to use the preferences included in this project.

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

## Stuff you have to setup manually
Some stuff I haven't figured out how to automate yet. So here's the checklist
so I don't forget next time.
- Install Salt...
- Safari/Preferences/Advanced/Develop menu
- Safari/Prefernces/Tabs/Turn on favicons in Safari
- Messages/Preferences/iMessage/Enable messages in iCloud
- System Preferences/Security & Privacy/General/Allow your Apple Watch to
  unlock your Mac
- System Preferences/General/Appearance/Dark mode
- Add Finder sidebar shortcuts.
- System Preferences/Date & Time/Clock/Date options: Show date
- Menubar/Power/Show percentage
- System Preferences/Sound/Show volume in menu bar
- Add Play Pause button to touchbar (removing Siri)
- Add iCloud button to Safari toolbar.
- Turn off Outlook sounds and notifications.
