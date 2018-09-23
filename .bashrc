# Bash Startup Script for Interactive or Remote Shells
# https://www.gnu.org/software/bash/manual/bash.html#Bash-Startup-Files

# Systemwide settings
[[ -r /etc/bashrc ]] && . /etc/bashrc

# For remote shells, bash runs .bashrc instead of .bash_profile.  Fix that.
if [[ -n $SSH_CONNECTION ]]; then
  [[ -r /etc/profile ]] && . /etc/profile
  [[ -r   ~/.profile ]] && .   ~/.profile
fi

# Rest of file is for interactive shells only
[[ $- == *i* ]] || return

# History
shopt -s histappend             # Append to history file instead of overwriting
shopt -s cmdhist                # Save multi-line commands as a single line
HISTFILESIZE=1000000            # Keep 1,000,000 entries in the history file
HISTSIZE=1000000                # Keep 1,000,000 entries in process memory
HISTCONTROL=ignoreboth          # Ignore duplicates and cmds starting with space
HISTIGNORE='ls:bg:fg:history'   # Ignore specific commands

# ls Colors
case "$(uname)" in
  FreeBSD|Darwin)
    export CLICOLOR=1
    alias ls='ls -F'
    alias la='ls -FA'
    alias ll='ls -FAl'
    ;;
  Linux|MINGW32*)
    eval "$(dircolors -b)"
    alias ls='ls -F --color'
    alias la='ls -FA --color'
    alias ll='ls -FAl --color'
    ;;
esac

# Password generator
mkpw() {
  LC_ALL=C tr -cd '\041-\176' < /dev/urandom | head -c ${1:-20} | tee >(pbcopy)
  echo
}

# Homebrew Stuff
if [ "$(uname)" = "Darwin" ]; then
  function brew-why {
    for f in $(brew list); do
      echo -n "$f:"
      for u in $(brew uses --installed --recursive --skip-build $f); do
        echo -n " $u"
      done
      echo
    done | column -t -s : 
  }
fi

# Completions
if [ ! "$CMPL_CARGO" ]; then
  CMPL_CARGO=/usr/local/etc/bash_completion.d/cargo
  [ -r "$CMPL_CARGO" ] && . "$CMPL_CARGO" && export CMPL_CARGO
fi
if [ ! "$CMPL_GIT" ]; then
  CMPL_GIT=/usr/local/etc/bash_completion.d/git-completion.bash
  [ -r "$CMPL_GIT" ] && . "$CMPL_GIT" && export CMPL_GIT
fi
bind 'set completion-ignore-case on'

# Git Stuff
_js_git_ps1() {
  local b="$(git symbolic-ref HEAD 2>/dev/null)"
  if [ -n "$b" ]; then
    echo "  (${b##refs/heads/})"
  fi
}

# Prompt
export PS1=\
'___________________________________________________________________________________________________\n'\
'\u@\h  \w`_js_git_ps1`  #\! (\j bg)\n\$ '

# Check SSH agent health
if [ ! "$SSH_AUTH_SOCK" ]; then
  # Agent not running
  need_ssh_agent=1
  need_ssh_add=1
else
  keys="$(ssh-add -l)"
  if [ $? -eq 2 ]; then
    # Agent broken
    need_ssh_agent=1
    need_ssh_add=1
  elif [ "$keys" = "The agent has no identities." ]; then
    # Agent running but has no identities
    need_ssh_add=1
  fi
fi

# Ensure SSH agent is running
if [ "$need_ssh_agent" ]; then
  echo "Starting new SSH agent."
  eval "$(ssh-agent)" > /dev/null
fi

# Ensure SSH agent has identities
if [ "$need_ssh_add" ]; then
  if [ "$(uname)" = "Darwin" ]; then
    ssh_add_args="-A" # Get keys from macOS keychain
  fi
  ssh-add $ssh_add_args
fi

# Source local startup script
[ -r ~/.bashrc_local ] && . ~/.bashrc_local

echo "Executed .bashrc"

