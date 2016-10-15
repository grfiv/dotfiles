#!/bin/bash

#
# Create a python project in a virtual environment
# Step 1
#
# > the environments are held in ~/.virtualenvs
# > each python project's code is in a folder under ~/Dropbox/python_dev
# (see .bash_aliases)
#
# This is broken into two steps because I couldn't get 'workon' to run in a script
#
# Step 1 creates the virtual environment and the project folder
# ... you are asked to enter workon <proj-name>
# Step 2 sets up module folders plus docs/ and test/, and sets up sphinx
#

echo -ne "\nEnter python_dev project name (folder name) "
read projname
echo ~/Dropbox/python_dev/$projname

rm -rf ~/Dropbox/python_dev/$projname 2> /dev/null

# create the project and virtual environment
# ==========================================
# location of virtual environments
export WORKON_HOME=$HOME/.virtualenvs
# default location of python development projects
export PROJECT_HOME=~/Dropbox/python_dev
# default python interpreter for virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3.5'
source /usr/local/bin/virtualenvwrapper.sh
rmvirtualenv $projname       2> /dev/null
mkproject $projname

echo -e "\n\nenter 'workon $projname' and run 'make_new_python_project_step2.sh'"
