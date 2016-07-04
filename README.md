# Dot Files   

dot files (file names that begin with a period) in the home directory contain the configurations of certain programs. They are kept in this repo so that they can easily be installed on a new Linux system and/or synchronized across several systems.   

Run *./make.sh* to back up any existing of the list of dot files to be installed and then create symlinks to the ones contained here.   

*.bash_aliases* is sourced from *.bashrc* to help keep personalization separate from the system-provided functions; *.bash_aliases* itself sources other files in the *dotfiles* directory for the sake of orderliness.   

*./make.sh* contains *apt-get* installation instructions for an Ubuntu system (tested on 16.04).   


```bash   
cd ~
git clone git@github.com:grfiv/dotfiles.git
cd dotfiles
chmod +x make.sh
./make.sh
```





