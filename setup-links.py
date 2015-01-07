#!/usr/bin/python

import os
import shutil
import sys
import time


HOME_DOTFILES = [".bash_profile",
                 ".git-completion.sh",
                 ".git-prompt.sh",
                 ".gitconfig",
                 ".gitignore_global",
                 ".vim",
                 ".vimrc"]

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

# Check for files and move them to backup, then symlink.
for dotfile in HOME_DOTFILES:
    src = os.path.join(dotfilesd, dotfile)
    dst = os.path.join(os.getenv("HOME"), dotfile)
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
