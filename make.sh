#!/bin/bash
##########################################
# make.sh
# This script creates symlinks
# from $HOME     to ~/dotfiles/dot_files
# and
# from $HOME/bin to ~/dotfiles/bin_files
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

# create $olddir if it does not already exist
# ===========================================
if [ ! -d "$olddir" ]; then
      echo "Creating $olddir for backup of any existing dotfiles in $HOME"
      mkdir -p $olddir
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


# change the gitconfig file to reflect current $HOME
# ==================================================
sed -i "s#.*excludesfile.*#\texcludesfile = $HOME/.gitignore_global#"  ~/dotfiles/dot_files/gitconfig


# create symlinks from ~/ to ~/dotfiles/dot_files/*
# =================================================
echo -e "\nCreating symlinks in $HOME & /root to dot files in $dir/dot_files"
for dot_file in $dir/dot_files/*
do
    dot_file_filename=$(basename $dot_file)
    ln -s      $dot_file $HOME/.$dot_file_filename
    sudo ln -s $dot_file /root/.$dot_file_filename
done

#ln -s      $dir/bash_functions.sh $HOME/.bash_functions.sh
#sudo ln -s $dir/bash_functions.sh /root/.bash_functions.sh

echo -e "\nsymlink contents of $HOME"
ls -AlF ~ | grep ^l

echo -e "\nsymlink contents of /root"
sudo ls -AlF /root | grep ^l

# load the new features
# =====================
echo -e "\nsource .bashrc to load new features"
source ~/.bashrc

# create symlinks from ~/Templates to ~/dotfiles/template_files/*
# ===============================================================
if [ -d "$HOME/Templates" ]; then
    echo -e "\nCreating symlinks in $HOME/Templates to $dir/template_files"
    for template_file in $dir/template_files/*
    do
        template_file_filename=$(basename $template_file)
        ln -s $template_file $HOME/Templates/$template_file_filename
    done

    echo -e "\nsymlink contents of $HOME/Templates"
    ls -AlF ~/Templates | grep ^l
fi


# if exists ~/.bin, it's added to PATH by ~/.profile
# ==================================================
# if not exists, create
[[ -d $HOME/bin ]] || mkdir $HOME/bin
[[ -d /root/bin ]] || sudo mkdir /root/bin

# create symlinks from ~/bin to ~/dotfiles/bin_files/*
# ====================================================
echo -e "\nCreating symlinks in $HOME/bin & /root/bin to *.sh files in $dir/bin_files"
for bin_file in $dir/bin_files/*
do
    bin_file_filename=$(basename $bin_file)
    ln -s      $bin_file $HOME/bin/$bin_file_filename
    sudo ln -s $bin_file /root/bin/$bin_file_filename
done

echo -e "\nsymlink contents of $HOME/bin"
ls -AlF ~/bin | grep ^l

echo -e "\nsymlink contents of /root/bin"
sudo ls -AlF /root/bin | grep ^l


# program installation
# ====================

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
