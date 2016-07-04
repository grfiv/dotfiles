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
files="bash_aliases tmux.conf vimrc"   

##########

# create dotfiles_old in homedir
if [ ! -d "$olddir" ]; then
	  # Control will enter here if $olddir doesn't exist.
      echo "Creating $olddir for backup of any existing dotfiles in ~"
      mkdir -p $olddir
      echo "...done"
fi


# change to the dotfiles directory
#echo "Changing to the $dir directory"
#cd $dir
#echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    mv ~/.$file $olddir/
done
ls -AlF $olddir
echo "...done"
        
echo "Creating symlinks to dot files in home directory"
for file in $files; do
    ln -s $dir/$file ~/.$file
done
#find ~ -maxdepth 1 -type l -ls
ls -AlF ~ | grep ^l
echo "...done"

# install tmux if it isn't already
if [ ! -f /usr/bin/tmux ]; then
    sudo apt-get update
    sudo apt-get install tmux -y
fi

# install vim if it isn't already
if [ ! -f /usr/bin/vim ]; then
    sudo apt-get update
    sudo apt-get install vim -y
fi
