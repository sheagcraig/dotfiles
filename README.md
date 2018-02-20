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

To set up, you need to get Ansible. On a fresh macOS box you need pip first.
You'll also need the Xcode developer tools for installing Ansible.
1. `sudo python -m ensurepip && pip install --upgrade pip`
1. `sudo xcode-select --install`
1. `sudo pip install ansible`

I usually build my machine with the configuration management system I maintain,
so these dependencies are already installed. Also, I use python3 instead of the
Apple-provided system Python, so if it complains about finding pip3 or is
installing packages in "unexpected" places, keep this in mind.

To actually configure the Mac:
1. `cd <this project's folder>`
1. `ansible-galaxy install -r requirements.yml`
1. I use Dropbox to store my vault-encrypted SSH keys and other secrets. To
   install, `ansible-playbook -i inventory --ask-become-pass
   dropbox_install.yml`
1. Wait for Dropbox to sync the secrets folder.
1. Decrypt the secrets into place: `ansible-vault decrypt --ask-vault-pass
   --output=<secrets_dir>/ <secret_file>`
1. `ansible-playbook -i inventory --ask-become-pass power_xtreme.yml`

Here's what happens:
1. Symlinks dotfiles into place.
	- Some dotfiles are copied where symlinks are not allowed.
1. Installs all homebrew and cask apps on macOS.
1. Installs all yum packages on RHEL linuxes.
1. Git inits submodules
	- For this repo, this primarily consists of vim plugins and Emmet.
1. Installs the fonts used by Powerline/Airline
1. Instructs iTerm2 to use the preferences included in this project.

I used to install all of my common python packages, but since I do that in
virtualenvs these days, I no longer do so.

## Using your own stuff
This installs my dotfiles, brew packages, etc. If you would like to install
your own, you'll need to override the configuration variables.

Take a look at the config.yml file to see where all of the lists of packages
are configured.

The dotfiles are listed in the dotfiles role's defaults/main.yml only since I
don't feel the need to have them in two places. Specifying your desired
dotfiles in the main config.yml will override these. If anybody else wants to
use this, I'd be happy to add in a dotfile folder variable to join to these
prior to performing the linking/copying, otherwise it expects them to be in the
root of the project dir. Hit me with a GitHub Issue if you're interested and I
can add further documentation.

Some files are pulled from my Dropbox folder since they can't be included on a
public GitHub repo. Feel free to do the same for your own secrets. Just make
sure you encrypt anything that you put up there!

## References
My starting point was https://github.com/geerlingguy/mac-dev-playbook and the
associated roles included in that project. Look there for fancier stuff.

The kind of tricky iTerm2 config is based on
http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
Any changes to the iTerm profile must be saved back out to this file and
committed (although that's true of all the dotfiles).
