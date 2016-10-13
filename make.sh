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
# ========================================================================================
files="bash_aliases tmux.conf vimrc gitconfig bash_functions.sh gitignore_global pylintrc"
# ========================================================================================

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


# change the gitconfig file to reflect current $HOME
# ==================================================
sed -i "s#.*excludesfile.*#\texcludesfile = $HOME/.gitignore_global#"  ~/dotfiles/gitconfig


# create symlinks to dotfiles directory
# =====================================
echo -e "\nCreating symlinks in $HOME & /root to dot files in $dir"
for file in $files; do
    ln -s $dir/$file ~/.$file
    sudo ln -s $dir/$file /root/.$file
done
echo -e "\nsymlink contents of $HOME"
ls -AlF ~ | grep ^l
pause

echo -e "\nsymlink contents of /root"
sudo ls -AlF /root | grep ^l
pause

# load the new features
# =====================
echo -e "\nsource .bashrc to load new features"
source ~/.bashrc
pause

echo -e "\ninstall programs if missing"

# what type of system are we running on?
python -mplatform | grep -qi ubuntu;ubuntu=$?
python -mplatform | grep -qi centos;centos=$?

# if exists ~/.bin, it's added to PATH by ~/.profile
# ==================================================
[[ -d $HOME/bin ]] || mkdir $HOME/bin

# sym links from ~/.bin to ~/dotfiles/bin_files/*
for bin_file in $dir/bin_files/*
do
    bin_file_filename=$(basename $bin_file)
    ln -s $bin_file $HOME/bin/$bin_file_filename
done


# program installation
# ====================

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

echo -e "\n... make.sh is finished"
