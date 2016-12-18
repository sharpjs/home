# Bash Startup Script for Interactive Shells

# Don't run twice
set | grep -q '\w$(_git_ps1)' && return

# Systemwide Settings
[ -r /etc/bashrc ] && . /etc/bashrc

# History
shopt -s histappend             # Append to history file instead of overwriting
shopt -s cmdhist                # Save multi-line commands as a single line
HISTFILESIZE=1000000            # Keep 1,000,000 entries in the history file
HISTSIZE=1000000                # Keep 1,000,000 entries in process memory
HISTCONTROL=ignoreboth          # Ignore duplicates and cms starting with space
HISTIGNORE='ls:bg:fg:history'   # Ignore specific commands

# Colors
export CLICOLOR=1

# Alias
alias ls='ls -F'
alias la='ls -FA'
alias ll='ls -FAl'

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

# Git Stuff
_js_git_ps1() {
  local b="$(git symbolic-ref HEAD 2>/dev/null)"
  if [ -n "$b" ]; then
    echo "  (${b##refs/heads/})"
  fi
}

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

# Prompt
export PS1='___________________________________________________________________________________________________\n\u@\h  \w`_js_git_ps1`  #\! (\j bg)\n\$ '

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

