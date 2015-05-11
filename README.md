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
                                                                          

These are my configs. They can make *your* life a lot better.

To set up, run ```sudo power_xtreme.py```. It does the following:
- Backup any dotfiles which are included in this project in case you want to save them.
- Softlink the dotfiles into place.
- The vim modules are managed as git submodules, and will be init/updated.
- Copy all plist files and read them (to force preference caching to update).
- Install brew packages. 
- pip install python packages.
- Source the (newly linked) .bash_profile so it takes effect immediately.

I need to split some of this stuff off. Namely, power_xtreme should set up dotfiles. Something else should be in charge of initial package installation.

### TODO
- Break package management into another script.
- Migrate fortune/cowsay to brew.
- Brew is OS X only. Add similar for yum.
- Exclude from non OS X stuff like the luggage.
