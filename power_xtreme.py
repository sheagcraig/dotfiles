#!/usr/bin/env python3
# Copyright (C) 2014-2017 Shea G Craig
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

This script is named after the Centurions, near and dear to my 80's
television overindulged heart.

See here: http://en.wikipedia.org/wiki/The_Centurions_(TV_series)
and here: https://youtu.be/_xycHGdEB38
"""


import datetime
import glob
import os
import shlex
import shutil
import subprocess
import sys
from pathlib import Path

import requests
import yaml


__version__ = "3.0.0"


def main():
    """Set up each dotfile resource."""
    backupd = get_backup_dir()

    # Get the location of the dotfiles and cd there.
    dotfilesd = Path(__file__).parent.resolve()
    os.chdir(dotfilesd)
    print(f'Dotfiles directory: {dotfilesd}')

    text = Path('config.yaml').read_text()
    config = yaml.load(text)

    link_dotfiles(config['dotfiles'], backupd)
    git_submodule_init()
    install_powerline_fonts()


def undone():
    pass
    # # Install and/or update all python packages.
    # for package in PYTHON_PACKAGES:
    #     pip_update(package)

    # # Nag me to add .pypirc if it's not here already
    # # Can't be in repo since it has secrets in it.
    # pypirc = os.path.join(dotfilesd, '.pypirc')
    # if not os.path.exists(pypirc):
    #     try:
    #         shutil.copy(
    #             os.path.join(home, 'Dropbox', 'boxen', 'pypirc'), pypirc)
    #     except:
    #         print 'Failed to copy pypirc from Dropbox; is it connected?'

    # if os.path.exists(pypirc):
    #     check_and_link(['.pypirc'], home, backupd, user)
    # else:
    #     print 'Please add the pypirc dotfile to repo and run again!'

    # # Manage Linux specific items. #####################################
    # if sys.platform.startswith("linux"):
    #     yum_install(YUM_PACKAGES)

    # # Manage OS X specific items. ######################################
    # if sys.platform == "darwin":

    #     # Configure pip on macOS
    #     pip_conf_path = os.path.join(home, PIP_CONF_PATH)
    #     ensure_directory(pip_conf_path, "")
    #     check_and_link([PIP_CONF], pip_conf_path, backupd, user)

    #     # Homebrew
    #     homebrew()

    #     # Set up iTerm2
    #     # Preferences should use copy rather than link because they tend
    #     # to change.  Arguably, it would be even better to iterate
    #     # through a plist object and defaults write each object or use
    #     # PyObjC to merge them in.
    #     check_and_copy(["com.googlecode.iterm2.plist"],
    #                    os.path.join(os.getenv("HOME"), "Library/Preferences"),
    #                    backupd, user)

    #     # Setup luggage files.
    #     ensure_directory(LUGGAGE_PATH, "Luggage")
    #     check_and_link(LUGGAGE_DOTFILES, LUGGAGE_PATH, backupd, user)

    # # Reload our bash profile.
    # source()


def get_backup_dir():
    """Make a timestamped backup directory."""
    now = datetime.datetime.utcnow()
    backupd = Path.cwd() / f'backup-{now}'
    backupd.mkdir()
    return backupd


def check_and_copy(files, destination, backupd, user):
    """Check for files and move them to backup, then copy."""
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

        if os.path.isdir(dotfile):
            shutil.copytree(dotfile, dst)
        else:
            shutil.copyfile(dotfile, dst)
        os.chown(dst, user[0], user[1])
        print("Copied %s to %s" % (dotfile, dst))
        # If the file is a plist, refresh the cached values after
        # linking by doing a defaults read.
        if dotfile.endswith(".plist"):
            defaults_read(dst)


def link_dotfiles(config, backupd):
    for dest, dotfiles in config.items():
        check_and_link(dotfiles, Path(dest).expanduser(), backupd)


def check_and_link(files, destination, backupd):
    """Check for files and move them to backup, then symlink."""
    ensure_directory(destination)
    for item in files:
        dotfile = Path(item)
        dst = destination / dotfile
        if dst.exists():
            if dst.is_symlink():
                print(f'Removing existing link: {dst}')
                dst.unlink()
            else:
                print(
                    f'File {dst} exists; copying to backup directory: '
                    f'{backupd}')
                dst.rename(backupd / dst.stem)

        dst.symlink_to(dotfile.resolve())
        print(f'Linked {dotfile} to {dst}')
        # If the file is a plist, refresh the cached values after
        # linking by doing a defaults read.
        if dotfile.suffix.upper() == '.PLIST':
            defaults_read(dst)


def ensure_directory(target: Path, title: str=None):
    """Make a directory if it doesn't already exist.

    Args:
        target: Directory to ensure exists.
        title: Name of software which should have made the dir.
            If provided, prints a warning.  Defaults to None. Useful as a
            warning about needing to set up other projects.
    """
    if not target.is_dir():
        target.mkdir()
        if title:
            print(f'Warning: {title} not installed!')


def defaults_read(path):
    """Renew cached preferences."""
    # Throw away output
    _ = subprocess.check_output(["defaults", "read", path])


def git_submodule_init():
    """Shortcut combination for init'ing submodules."""
    subprocess.check_call(
        ['git', 'submodule', 'update', '--init', '--recursive'])


def install_powerline_fonts():
    """Use the powerline font install script to add monospace fonts."""
    subprocess.check_call(["fonts/install.sh"])


def pip_update(package):
    """Attempt to run pip install -U."""
    if subprocess.call(["su", sudo_user(), "-c", "which pip"]) != 0:
        install_pip()

    print("Installing python package: %s" % package)
    # stdout = subprocess.check_output(["pip", "install", "-U", "--user",
    #                                   package])
    stdout = user_shell("pip install -U --user {}".format(package))
    print(stdout)


def install_pip():
    """Use easy_install to install pip."""
    stdout = user_shell("python -m ensurepip --user")
    print(stdout)


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
    response = requests.get(
        "https://raw.githubusercontent.com/Homebrew/install/master/install")
    homebrew_install = "/tmp/homebrew-install.rb"
    with open(homebrew_install, "w") as f:
        f.write(response.text)
    # Homebrew installer prompts you once to hit enter.
    p = subprocess.Popen(["su", sudo_user(), "-c", "ruby %s" %
                          homebrew_install], stdin=subprocess.PIPE)
    output = p.communicate("\n")
    print(output)


def homebrew():
    """Install homebrew if needed, then install packages."""
    if subprocess.call(["which", "brew"]) != 0:
        install_homebrew()
    else:
        # If brew is already installed, update brew and its formulae.
        brew_update()

    # Install missing formulae.
    for recipe in BREW_FORMULAS:
        output = user_shell("brew install %s" % recipe)
        print(output)

    # TODO: This currently fails
    # Now update already installed items.
    # output = user_shell("brew upgrade")
    # print output


def brew_update():
    output = user_shell("brew update")
    print(output)


def yum_install(packages):
    """yum install a list of packages."""
    output = subprocess.call(["yum", "-y", "install"] + packages)
    print(output)


if __name__ == "__main__":
    main()
