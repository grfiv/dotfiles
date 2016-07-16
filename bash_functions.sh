#!/bin/bash

# collection of useful functions
# sourced from .bash_aliases

# ======================================================================
# ----------------------------------------------------------------------
# Command-line copy to the clipboard
# ==================================
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# see http://madebynathan.com/2011/10/04/a-nicer-way-to-use-xclip/

# Strings
# usage: pwd | cb    copy the output of pwd to the clipboard
#        cb pwd      copy the string 'pwd' to the clipboard (quote for blanks)

# Contents of files
# usage: cbf ~/.ssh/id_rsa.pub   copy the public key to the clipboard

cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
export -f cb

# Copy contents of a file
# -----------------------
function cbf() { cat "$1" | cb; } 
export -f cbf
# ----------------------------------------------------------------------
# ======================================================================


# ======================================================================
# ----------------------------------------------------------------------
# Extract many types of compressed packages
# Credit: http://nparikh.org/notes/zshrc.txt
# NOTE: there exists an extract: apt-cache show extract

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar -jxvf "$1"                        ;;
      *.tar.xz)   tar -Jxvf "$1"                        ;;
      *.tar.gz)   tar -zxvf "$1"                        ;;
      *.bz2)      bunzip2 "$1"                          ;;
      *.dmg)      hdiutil mount "$1"                    ;;
      *.gz)       gunzip "$1"                           ;;
      *.tar)      tar -xvf "$1"                         ;;
      *.tbz2)     tar -jxvf "$1"                        ;;
      *.tgz)      tar -zxvf "$1"                        ;;
      *.zip)      unzip "$1"                            ;;
      *.ZIP)      unzip "$1"                            ;;
      *.pax)      cat "$1" | pax -r                     ;;
      *.pax.Z)    uncompress "$1" --stdout | pax -r     ;;
      *.Z)        uncompress "$1"                       ;;
      *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
     echo "'$1' is not a valid file to extract"
  fi
}
export -f extract
# ----------------------------------------------------------------------
# ======================================================================

# ===================================================
# ---------------------------------------------------
function open_url {
    # open a URL in a browser
    #
    # usage: open_url http://www.google.com
    URL=$1 
    if which xdg-open > /dev/null
    then
      xdg-open $URL > /dev/null
    elif which gnome-open > /dev/null
    then
      gnome-open $URL > /dev/null
    fi
} 
export -f open_url
# ---------------------------------------------------
# ===================================================


# ===================================================
# ---------------------------------------------------
function pause() {
    # wait for input
    #
    # usage: pause
   echo -n "... press Enter "   
   read -p "$*"
}
export -f pause
# ---------------------------------------------------
# ===================================================


# ===================================================
# ---------------------------------------------------
function man2pdf {
    # convert a man page to a pdf file
    #
    # usage: man2pdf ls
    #        creates a file ls.pdf
    #
    # lpstat -p # lists all the available printers
    #
    # lpr -P <printer name> <file name> # prints a file
    #
    man -t $1 | ps2pdf - $1.pdf
}
export -f man2pdf
# ---------------------------------------------------
# ===================================================


# ===================================================
# ---------------------------------------------------
function display_timebar {
    
    # display an extending bar each 0.5 seconds for $1 seconds
    #    if $2 is provided it will be echoed prior to the bar being displayed
    #
    # credit: https://stackoverflow.com/questions/12498304/
    #               using-bash-to-display-a-progress-working-indicator
    #
    # usage: display_timebar 10 "wait 10 seconds"
    
    if [ ! -z "$2" ]; then
        echo $2
    fi
    count=0
    total=$(( 2 * $1 ))
    pstr="[=======================================================================]"

    while [ $count -lt $total ]; do
      sleep 0.5 # this is work
      count=$(( $count + 1 ))
      pd=$(( $count * 73 / $total ))
      printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
    done
}
export -f display_timebar
# ---------------------------------------------------
# ===================================================
