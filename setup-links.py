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

def check_and_link(files, destination):
    """Check for files and move them to backup, then symlink."""
    for dotfile in files:
        src = os.path.join(dotfilesd, dotfile)
        dst = os.path.join(destination, dotfile)
        if os.path.exists(dst):
            if os.path.islink(dst):
                print("Removing existing link: %s" % dst)
                os.remove(dst)
            else:
                print("File %s exists; copying to backup directory: %s" %
                    (dst, backupd))
                shutil.move(dst, backupd)
        os.symlink(src, dst)
        print("Linked %s to %s" % (src, dst))


def ensure_directory(target, title=''):
    if not os.path.isdir(target):
        os.makedirs(target)
        if title:
            print("Warning: %s not installed!" % title)


def git_clone(url, into):
    subprocess.check_call(["git", "clone", url, into])


if len(sys.argv) != 2:
    if os.path.basename(os.getcwd()) == 'dotfiles':
        dotfilesd = os.getcwd()
    else:
        sys.exit("Please provide path to dotfiles as an argument.")
else:
    dotfilesd = os.path.realpath(sys.argv[1])

print("Dotfiles directory: %s" % dotfilesd)

# Make a backup directory.
backupd = os.path.join(os.getcwd(), 'backup-%s' %
                       time.strftime('%Y%m%d-%H%M%S'))
os.mkdir(backupd)

# Setup dotfiles in the home.
check_and_link(HOME_DOTFILES, os.getenv("HOME"))

# Setup luggage files.
ensure_directory(LUGGAGE_PATH, 'Luggage')
check_and_link(LUGGAGE_DOTFILES, LUGGAGE_PATH)

# fortune, cowsay
ensure_directory(FORTUNE_PATH)
ensure_directory(FORTUNES_PATH)
check_and_link(FORTUNE, FORTUNE_PATH)
check_and_link(FORTUNES, FORTUNES_PATH)

cowsay = glob.glob(os.path.join(dotfilesd, 'cowsay*.pkg'))[0]
output = subprocess.check_output(['installer', '-target', '/', '-pkg', cowsay])
print(output)

# Powerline fonts.
git_clone("https://github.com/powerline/fonts", "/tmp/powerline-fonts")
subprocess.check_call(["/tmp/powerline-fonts/install.sh"])
