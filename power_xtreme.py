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

Must be run as root via sudo.

This script is named after the Centurions, near and dear to my 80's
television overindulged heart.

See here: http://en.wikipedia.org/wiki/The_Centurions_(TV_series)
and here: https://youtu.be/_xycHGdEB38
"""


import glob
import os
import shutil
import subprocess
import sys
import time

__version__ = "1.0.1"
HOME_DOTFILES = [".bash_profile",
                 ".git-completion.sh",
                 ".git-prompt.sh",
                 ".gitconfig",
                 ".gitignore_global",
                 ".vim",
                 ".vimrc"]

LUGGAGE_PATH = "/usr/local/share/luggage"
LUGGAGE_DOTFILES = ["luggage.local"]

FORTUNE = ["fortune"]
FORTUNE_PATH = "/usr/local/bin"
FORTUNES = ["fortunes"]
FORTUNES_PATH = "/usr/local/var"


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
    subprocess.check_call(["fonts/install.sh"])


def main():
    """Set up each dotfile resource."""
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
    check_and_link(HOME_DOTFILES, os.getenv("HOME"), backupd, user)

    # Set up git submodules.
    git_submodule_init()

    # Install powerline fonts.
    install_powerline_fonts()

    # Set up iTerm2
    check_and_link(["com.googlecode.iterm2.plist"], os.path.join(os.getenv("HOME"), "Library/Preferences"), backupd, user)

    # Setup luggage files.
    ensure_directory(LUGGAGE_PATH, user, "Luggage")
    check_and_link(LUGGAGE_DOTFILES, LUGGAGE_PATH, backupd, user)

    # fortune, cowsay
    ensure_directory(FORTUNE_PATH, user)
    ensure_directory(FORTUNES_PATH, user)
    check_and_link(FORTUNE, FORTUNE_PATH, backupd, user)
    check_and_link(FORTUNES, FORTUNES_PATH, backupd, user)

    if sys.platform == "darwin":
        cowsay = glob.glob("cowsay*.pkg")[0]
        output = subprocess.check_output(["installer", "-target", "/", "-pkg",
                                          cowsay])
        print output


if __name__ == "__main__":
    main()
