# for python
# ----------
#export PYTHONSTARTUP=/home/george/Dropbox/Python/python_startup.py
export PYTHONPATH=$PYTHONPATH:/home/george/Dropbox/Python

# for nvcc
# --------
#PATH=$PATH:/usr/bin

# for maven (note the release, obviously this may change)
# ---------
#PATH=$PATH:/usr/local/apache-maven/apache-maven-3.3.3/bin
#export MAVEN_OPTS="-Xms256m -Xmx512m"

# for the MNIST handwritten digits
export MNIST=/home/george/Dropbox/MNIST/data

# for hyperopt
#export OMP_NUM_THREADS=1

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
# Command-line copy to the clipboard
# ==================================
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# see http://madebynathan.com/2011/10/04/a-nicer-way-to-use-xclip/
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

# usage: pwd | cb    copy the output of pwd to the clipboard
#        cb pwd      copy pwd itself to the clipboard (quote for blanks)

# Copy contents of a file
# =======================
function cbf() { cat "$1" | cb; } 
export -f cbf

# usage: cbf ~/.ssh/id_rsa.pub   copy the public key to the clipboard
# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

export PATH="/usr/lib/ccache:$PATH"

# AWS cli configurations
export AWS_CONFIG_FILE=$HOME/.aws/config

# for stock ticker 'mop' command
# see http://xmodulo.com/monitor-stock-quotes-command-line-linux.html
export GOPATH=$HOME/work
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

alias ticker='mop'  # note: there is a program called ticker which you may need someday

# vim is better than vi
alias vi='vim'
export MYVIMRC=~/.vimrc

# improve the ls command to provide color and append the file type
alias ls='ls --color=auto -F'
alias ll='ls -alFh'            # make ll human readable

# reduce sensitivity of a Synaptics touchpad
# see https://help.ubuntu.com/community/SynapticsTouchpad
# and http://www.mepis.org/docs/en/index.php?title=Configuring_the_touchpad_with_xinput
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Noise Cancellation" 20 20
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Finger" 50 80 257

