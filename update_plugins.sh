#!/bin/bash
# Update vim submodules for updating the git dotfiles project.
#git submodule foreach git pull origin master
git submodule foreach --recursive 'branch="$(git config -f .gitmodules submodule.$name.branch)"; git checkout $branch; git pull --rebase $branch'