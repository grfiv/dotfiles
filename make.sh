#!/bin/bash
##########################################
# make.sh
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
# ===========================================
if [ ! -d "$olddir" ]; then
      echo "Creating $olddir for backup of any existing dotfiles in $HOME"
      mkdir -p $olddir
      pause
fi

# backup existing dot files  
# =========================
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
# =====================================
echo -e "\nCreating symlinks in $HOME to dot files in $dir"
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

# what type of system are we running on?
python -mplatform | grep -qi ubuntu;ubuntu=$?
python -mplatform | grep -qi centos;centos=$?


# install tmux if needed
if [ ! -f /usr/bin/tmux ]; then
    echo -e "\nInstall tmux"
    echo -e "##################################"

    if [[ $ubuntu -eq 0 ]]
    then
        sudo apt-get update
        sudo apt-get install tmux -y
        
    elif [[ $centos -eq 0 ]]
    then
        sudo yum update
        sudo yum install tmux -y
        
    else
        echo "neither ubuntu nor centos system identified"
    fi
fi

# install setxkbmap if needed
#if [ ! -f /usr/bin/setxkbmap ]; then
#
#    if [[ $ubuntu -eq 0 ]]
#    then
#        sudo apt-get update
#        sudo apt-get install x11-xkb-utils -y
#        
#    elif [[ $centos -eq 0 ]]
#    then
#        sudo yum update
#        sudo yum install xorg-x11-xkb-utils -y
#        
#    else
#        echo "neither ubuntu nor centos system identified"
#    fi
#fi

# install vim if needed
if [ ! -f /usr/bin/vim ]; then
    echo -e "\nInstall vim"
    echo -e "##################################"
    
    if [[ $ubuntu -eq 0 ]]
    then
        sudo apt-get update
        sudo apt-get install -y vim-gnome vim-gnome-py2 vim-doc
        
    elif [[ $centos -eq 0 ]]
    then
        sudo yum update
        sudo yum install vim-enhanced -y
        
    else
        echo "neither ubuntu nor centos system identified"
    fi
fi

# install git if needed
if [ ! -f /usr/bin/git ]; then
    echo -e "\nInstall git"
    echo -e "##################################"
    
    if [[ $ubuntu -eq 0 ]]
    then
        sudo apt-get update
        sudo apt-get install git -y
        
    elif [[ $centos -eq 0 ]]
    then
        sudo yum update
        sudo yum install git -y
        
    else
        echo "neither ubuntu nor centos system identified"
    fi
fi

echo -e "\n... make.sh is finished"
