#!/bin/bash

#
# Create a python project in a virtual environment
# Step 2
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

# find the project name
s=$(pwd)/
s="${s%/*}"
projname=${s##*/}
echo $projname

# create module folders
echo -ne "enter a space-separated list of module names "
read -a module_names
for i in "${!module_names[@]}"; do
  printf "%s\t%s\n" "$i" "${module_names[$i]}"
  mkdir ${module_names[$i]}
  cd ${module_names[$i]}
  touch __init__.py
  cd ..
done

# create docs and test folders
mkdir test

mkdir docs


pip3 install sphinx

cd docs
sphinx-quickstart --sep --dot=_ --language=en --project=$projname -a "George Fisher" -v 1.0 \
--master=index --ext-autodoc --makefile --no-batchfile

find . -iname conf.py -exec sed -i "s/# import os/import os/g" {} \;
find . -iname conf.py -exec sed -i "s/# import sys/import sys/g" {} \;
find . -iname conf.py -exec sed -i "s?# sys.path.insert(0, os.path.abspath('.'))?sys.path.insert(0, os.path.abspath('../..'))?g" {} \;

cd docs
sphinx-apidoc -f -o source/ ../$projname/

