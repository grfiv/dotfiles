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
echo $projname

rm -rf $projname

echo -e "\n to remove the virtual environment enter rmvirtualenv $projname\n"

# create the project and virtual environment
source /usr/local/bin/virtualenvwrapper.sh

rmvirtualenv $projname

mkproject $projname

echo -e "\n\nenter 'workon $projname' and run '../make_new_python_project_step2.sh'"

