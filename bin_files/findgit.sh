#!/bin/bash

# locate all the git repositories under the ~/ tree

find ~/ -type d -name .git 2>/dev/null
