#!/usr/bin/python
# Copyright (C) 2014 Shea G Craig
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""
power_xtreme

Configure all managed dotfiles and dependencies by symlinking to git
repo. Many of the vim bundles and assorted projects are managed as git
submodules.

Must be run as root via sudo. This is to handle stuff that goes into
system directories.

This script is named after the Centurions, near and dear to my 80's
television overindulged heart.

See here: http://en.wikipedia.org/wiki/The_Centurions_(TV_series)
and here: https://youtu.be/_xycHGdEB38
"""


import glob
import os
import shlex
import shutil
import subprocess
import sys
import time

__version__ = "1.0.2"
HOME_DOTFILES = [".bash_profile",
                 ".git-completion.sh",
                 ".git-prompt.sh",
                 ".gitconfig",
                 ".gitignore_global",
                 ".pylintrc",
                 ".shell_prompt.sh",
                 ".tmux.conf",
                 ".tmuxlinesnap",
                 ".vim",
                 ".vimrc"]

LUGGAGE_PATH = "/usr/local/share/luggage"
LUGGAGE_DOTFILES = ["luggage.local"]

EASY_INSTALL = "/usr/local/bin/easy_install"
PIP = "/usr/local/bin/pip"
PYTHON_PACKAGES = ["matplotlib",
                   "ndg-httpsclient",
                   "nose",
                   "numpy",
                   "Pillow",
                   "pyOpenSSL",
                   "pyasn1",
                   "pygal",
                   "pylint",
                   "pypandoc",
                   "python-jss",
                   "requests",
                   "twine",
                   "wheel"]

BREW_FORMULAS = ["cowsay",
                 "fortune",
                 "tmux"]
YUM_PACKAGES = ["cowsay",
                "fortune",
                "freetype",
                "freetype-devel",
                "gcc",
                "gcc-c++",
                "libffi",
                "openssl-devel",
                "pandoc",
                "python-devel",
                "tmux",
                "tmux",
                "vim-common",
                "vim-enhanced"]


def check_and_copy(files, destination, backupd, user):
    """Check for files and move them to backup, then copy."""
    for dotfile in files:
        dst = os.path.join(destination, dotfile)
        if os.path.exists(dst):
            if os.path.islink(dst):
                print "Removing existing link: %s" % dst
                os.remove(dst)
            else:
                print  ("File %s exists; copying to backup directory: %s" %
                        (dst, backupd))
                shutil.move(dst, backupd)

        if os.path.isdir(dotfile):
            shutil.copytree(dotfile, dst)
        else:
            shutil.copyfile(dotfile, dst)
        os.chown(dst, user[0], user[1])
        print "Copied %s to %s" % (dotfile, dst)
        # If the file is a plist, refresh the cached values after
        # linking by doing a defaults read.
        if dotfile.endswith(".plist"):
            defaults_read(dst)


def check_and_link(files, destination, backupd, user):
    """Check for files and move them to backup, then symlink."""
    for dotfile in files:
        dst = os.path.join(destination, dotfile)
        if os.path.exists(dst):
            if os.path.islink(dst):
                print "Removing existing link: %s" % dst
                os.remove(dst)
            else:
                print  ("File %s exists; copying to backup directory: %s" %
                        (dst, backupd))
                shutil.move(dst, backupd)

        os.symlink(os.path.realpath(dotfile), dst)
        # Since we're dealing with symlinks, use lchown to operate on
        # the link and not its target.
        os.lchown(dst, user[0], user[1])
        print "Linked %s to %s" % (dotfile, dst)
        # If the file is a plist, refresh the cached values after
        # linking by doing a defaults read.
        if dotfile.endswith(".plist"):
            defaults_read(dst)


def ensure_directory(target, user, title=""):
    """Make a directory if it doesn't already exist.

    Args:
        target: String path to a directory to ensure.
        title: String name of software which should have made the dir.
            Defaults to "". Useful as a warning about needing to set
            up other projects.
    """
    if not os.path.isdir(target):
        os.makedirs(target)
        os.chown(target, user[0], user[1])
        if title:
            print "Warning: %s not installed!" % title


def defaults_read(path):
    """Renew cached preferences."""
    subprocess.check_call(["defaults", "read", path])


def git_submodule_init():
    """Shortcut combination for init'ing submodules."""
    subprocess.check_call(["git", "submodule", "update", "--init"])


def install_powerline_fonts():
    """Use the powerline font install script to add monospace fonts."""
    #subprocess.check_call(["su", os.getenv("SUDO_USER"), "-c",
    #                       "fonts/install.sh"])
    user_shell("fonts/install.sh")


def pip_update(package):
    """Attempt to run pip install -U."""
    if subprocess.call(["which", "pip"]) != 0:
        install_pip()

    print "Installing python package: %s" % package
    stdout = subprocess.check_output(["pip", "install", "-U", package])
    print stdout


def install_pip():
    """Use easy_install to install pip."""
    stdout = subprocess.check_output(["easy_install", "-U", "pip"])
    print stdout


def source():
    """Source our bash profile to refresh."""
    #subprocess.check_call(["su", os.getenv("SUDO_USER"),"-c",
    #                       "source ~/.bash_profile"])
    user_shell("source ~/.bash_profile")


def sudo_user():
    return os.getenv("SUDO_USER")


def user_shell(cmd):
    """Execute a shell command as the admin user who ran this sudo."""
    return subprocess.check_output(["su", sudo_user(), "-c", cmd])


def install_homebrew():
    import requests
    response = requests.get(
        "https://raw.githubusercontent.com/Homebrew/install/master/install")
    homebrew_install = "/tmp/homebrew-install.rb"
    with open(homebrew_install, "w") as f:
        f.write(response.text)
    # Homebrew installer prompts you once to hit enter.
    p = subprocess.Popen(["su", sudo_user(), "-c", "ruby %s" %
                          homebrew_install], stdin=subprocess.PIPE)
    output = p.communicate("\n")
    print output


def homebrew():
    """Install homebrew if needed, then install packages."""
    if subprocess.call(["which", "brew"]) != 0:
        install_homebrew()

    for recipe in BREW_FORMULAS:
        # su's -c argument wants its args as a single token. I think.
        #output = subprocess.check_output(["su", os.getenv("SUDO_USER"), "-c",
        #                                  "brew install %s" % recipe])
        output = user_shell("brew install %s" % recipe)
        print output


def yum_install(packages):
    """yum install a list of packages."""
    output = subprocess.call(["yum", "-y", "install"] + packages)
    print output


def main():
    """Set up each dotfile resource."""
    # Prepare information about user.
    if os.geteuid() != 0:
        print "Please sudo run this script."
        sys.exit(1)

    uid = int(os.getenv("SUDO_UID"))
    gid = int(os.getenv("SUDO_GID"))
    user = (uid, gid)

    # Make a backup directory.
    backupd = os.path.join(os.getcwd(), "backup-%s" %
                           time.strftime("%Y%m%d-%H%M%S"))
    os.mkdir(backupd)
    os.chown(backupd, uid, gid)

    # Get the location of the dotfiles and cd there.
    dotfilesd = os.path.realpath(os.path.dirname(sys.argv[0]))
    os.chdir(dotfilesd)
    print "Dotfiles directory: %s" % dotfilesd

    # Setup dotfiles in the home.
    check_and_link(HOME_DOTFILES, os.path.expanduser(
        "~%s" % sudo_user()), backupd, user)

    # Set up git submodules.
    git_submodule_init()

    # Install powerline fonts.
    install_powerline_fonts()

    ## Install and/or update all python packages.
    for package in PYTHON_PACKAGES:
        pip_update(package)

    # Manage Linux specific items. #####################################
    yum_install(YUM_PACKAGES)

    # Manage OS X specific items. ######################################
    if sys.platform == "darwin":

        # Homebrew
        homebrew()

        # Set up iTerm2
        # Preferences should use copy rather than link because they tend
        # to change.  Arguably, it would be even better to iterate
        # through a plist object and defaults write each object or use
        # PyObjC to merge them in.
        check_and_copy(["com.googlecode.iterm2.plist"],
                    os.path.join(os.getenv("HOME"), "Library/Preferences"),
                    backupd, user)

        # Setup luggage files.
        ensure_directory(LUGGAGE_PATH, user, "Luggage")
        check_and_link(LUGGAGE_DOTFILES, LUGGAGE_PATH, backupd, user)

    # Reload our bash profile.
    source()


if __name__ == "__main__":
    main()
