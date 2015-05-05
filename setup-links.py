#!/usr/bin/python

import glob
import os
import shutil
import subprocess
import sys
import time


HOME_DOTFILES = [".bash_profile",
                 ".git-completion.sh",
                 ".git-prompt.sh",
                 ".gitconfig",
                 ".gitignore_global",
                 ".vim",
                 ".vimrc"]

LUGGAGE_PATH = '/usr/local/share/luggage'
LUGGAGE_DOTFILES = ['luggage.local']

FORTUNE = ['fortune']
FORTUNE_PATH = '/usr/local/bin'
FORTUNES = ['fortunes']
FORTUNES_PATH = '/usr/local/var'


def check_and_link(files, destination, backupd):
    """Check for files and move them to backup, then symlink."""
    for dotfile in files:
        dst = os.path.join(destination, dotfile)
        if os.path.exists(dst):
            if os.path.islink(dst):
                print("Removing existing link: %s" % dst)
                os.remove(dst)
            else:
                print("File %s exists; copying to backup directory: %s" %
                    (dst, backupd))
                shutil.move(dst, backupd)

        os.symlink(dotfile, dst)
        print("Linked %s to %s" % (dotfile, dst))


def ensure_directory(target, title=""):
    """Make a directory if it doesn't already exist.

    Args:
        target: String path to a directory to ensure.
        title: String name of software which should have made the dir.
            Defaults to "". Useful as a warning about needing to set
            up other projects.
    """
    if not os.path.isdir(target):
        os.makedirs(target)
        if title:
            print "Warning: %s not installed!" % title


def git_clone(url, into):
    subprocess.check_call(["git", "clone", url, into])


def git_submodule_init():
    subprocess.check_call(["git", "submodule", "update", "--init"])


def install_powerline_fonts():
    subprocess.check_call(["fonts/install.sh"])


def main():
    """Set up each dotfile resource."""
    # Make a backup directory.
    backupd = os.path.join(os.getcwd(), "backup-%s" %
                           time.strftime("%Y%m%d-%H%M%S"))
    os.mkdir(backupd)

    # Get the location of the dotfiles and cd there.
    dotfilesd = os.path.realpath(os.path.dirname(sys.argv[0]))
    os.chdir(dotfilesd)
    print("Dotfiles directory: %s" % dotfilesd)

    # Setup dotfiles in the home.
    check_and_link(HOME_DOTFILES, os.getenv("HOME"), backupd)

    # Set up git submodules.
    git_submodule_init()

    # Install powerline fonts.
    install_powerline_fonts()

    # Setup luggage files.
    ensure_directory(LUGGAGE_PATH, 'Luggage')
    check_and_link(LUGGAGE_DOTFILES, LUGGAGE_PATH, backupd)

    # fortune, cowsay
    ensure_directory(FORTUNE_PATH)
    ensure_directory(FORTUNES_PATH)
    check_and_link(FORTUNE, FORTUNE_PATH, backupd)
    check_and_link(FORTUNES, FORTUNES_PATH, backupd)

    if  sys.platform == "darwin":
        cowsay = glob.glob('cowsay*.pkg')[0]
        output = subprocess.check_output(['installer', '-target', '/', '-pkg',
                                          cowsay])
        print(output)


if __name__ == "__main__":
    main()
