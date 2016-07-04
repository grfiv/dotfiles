#!/bin/bash
##########################################
# .make.sh
# This script creates symlinks from $HOME
# to dotfiles in ~/dotfiles
##########################################

function pause() {
    # wait for input
    #
    # usage: pause
   echo -n "... press Enter "   
   read -p "$*"
}

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

# list of files/folders to symlink to from $HOME
# ================================================================
files="bash_aliases tmux.conf vimrc gitconfig"   
# ================================================================


# create $olddir if it does not already exist
if [ ! -d "$olddir" ]; then
      echo "Creating $olddir for backup of any existing dotfiles in $HOME"
      mkdir -p $olddir
      pause
fi

# backup existing dot files  
echo -e "\nMoving any existing dotfiles from $HOME to $olddir"
for file in $files; do
    # move only regular files, not symlinks
    if [ ! -h ~/.$file ]; then
        mv ~/.$file $olddir/
    fi
done
echo -e "contents of $olddir"
ls -AlF $olddir
pause
        
# create symlinks to dotfiles directory
echo "Creating symlinks in $HOME to dot files in $dir"
for file in $files; do
    ln -s $dir/$file ~/.$file
done
echo -e "symlink contents of $HOME"
ls -AlF ~ | grep ^l
pause

# load the new features
echo -e "\nsource .bashrc to load new features"
source ~/.bashrc
pause

echo -e "\ninstall programs if missing"

# install tmux if needed
if [ ! -f /usr/bin/tmux ]; then
    sudo apt-get update
    sudo apt-get install tmux -y
fi

# install vim if needed
if [ ! -f /usr/bin/vim ]; then
    sudo apt-get update
    sudo apt-get install vim -y
fi

# install git if needed
if [ ! -f /usr/bin/git ]; then
    sudo apt-get update
    sudo apt-get install git -y
fi

echo -e "\n... make.sh is finished"
