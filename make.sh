#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory
# to dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

# list of files/folders to symlink to from $HOME
# ================================================================
files="bash_aliases tmux.conf vimrc gitconfig"   
# ================================================================

##########

# create $olddir if it does not already exist
if [ ! -d "$olddir" ]; then
      echo "Creating $olddir for backup of any existing dotfiles in ~"
      mkdir -p $olddir
      echo -e "...done\n"
fi

# backup existing dot files  
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    # move only regular files, not symlinks
    if [ ! -h ~/.$file ]; then
        mv ~/.$file $olddir/
    fi
done
echo -e "contents of $olddir"
ls -AlF $olddir
echo -e "...done\n"
        
# create symlinks to dotfiles directory
echo "Creating symlinks to dot files in home directory"
for file in $files; do
    ln -s $dir/$file ~/.$file
done
#find ~ -maxdepth 1 -type l -ls
echo -e "symlink contents of $HOME"
ls -AlF ~ | grep ^l
echo -e "...done\n"

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
