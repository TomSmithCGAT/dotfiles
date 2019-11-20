# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -lah --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

mdcd() {
    mkdir "$@" && cd "$@"
}


# Variables for CGATPipelines
export TMPDIR='/home/PROT-FILESVR1/proteomics/tss38/scratch'
export SHARED_TMPDIR='/home/PROT-FILESVR1/proteomics/tss38/scratch'


# make crontab -e open in emacs
export EDITOR="emacs -nw"


########### Really should use modulefiles to add these to path
## - this is unsustainable

# add picard to the apps path
export PATH="/home/PROT-FILESVR1/proteomics/tss38/apps/bio/picard-2.8.2:$PATH"

# add java to the apps path
export PATH="/home/PROT-FILESVR1/proteomics/tss38/apps/bio/jre1.8.0_121/bin/:$PATH"

# add sratoolkit to the apps path
export PATH="/home/PROT-FILESVR1/proteomics/tss38/apps/bio/sratoolkit.2.8.1/bin/:$PATH"

# add igv to the apps path
export PATH="/home/PROT-FILESVR1/proteomics/tss38/apps/bio/IGV_2.3.91/:$PATH"

# add clustalo to the path
export PATH="/home/PROT-FILESVR1/proteomics/tss38/apps/bio/:$PATH"

# add featureCounts to the path
export PATH="~/apps/bio/subread-1.5.2-Linux-x86_64/bin/:$PATH"

# add CamProt to the python path
# remove this when setup.py develop in place and working
export PYTHONPATH="/home/PROT-FILESVR1/proteomics/tss38/git_repos/CamProt/camprot:$PYTHONPATH"


# add open MS to LD library path:
#http://ftp.mi.fu-berlin.de/pub/OpenMS/release-documentation/html/install_linux.html
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/PROT-FILESVR1/proteomics/tss38/git_repos/OpenMS-build/lib
export PATH=$PATH:/home/PROT-FILESVR1/proteomics/tss38/git_repos/OpenMS-build/bin

# activate conda env
export PATH=/home/PROT-FILESVR1/proteomics/tss38/cgat-install/conda-install/bin/:$PATH
#source /home/PROT-FILESVR1/proteomics/tss38/cgat-install/conda-install/bin/activate py36-v1
source /home/PROT-FILESVR1/proteomics/tss38/cgat-install/conda-install/etc/profile.d/conda.sh
conda activate cgat-development
