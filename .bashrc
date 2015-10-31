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
if complete | grep -qv _git_; then
  GIT_COMPLETIONS=/usr/local/etc/bash_completion.d/git-completion.bash
  [ -r "$GIT_COMPLETIONS" ] && . "$GIT_COMPLETIONS"
  unset GIT_COMPLETIONS
fi
bind 'set completion-ignore-case on'

# Prompt
export PS1='___________________________________________________________________________________________________\n\u@\h  \w`_js_git_ps1`  #\! (\j bg)\n\$ '

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
  echo "Initializing new SSH agent..."
  # spawn ssh-agent
  ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
  echo succeeded
  chmod 600 "$SSH_ENV"
  . "$SSH_ENV" > /dev/null
  ssh-add
}

# test for identities
function test_identities {
  # test whether standard identities have been added to the agent already
  ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $? -eq 0 ]; then
    ssh-add
    # $SSH_AUTH_SOCK broken so we start a new proper agent
    if [ $? -eq 2 ];then
      start_agent
    fi
  fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ "$(uname)" = "Darwin" ]; then
  : # OS X uses Keychain instead of ssh-agent; do nothing here
elif [ -n "$SSH_AGENT_PID" ]; then
  ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
  if [ $? -eq 0 ]; then
    test_identities
  fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
  if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
  fi
  ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
  if [ $? -eq 0 ]; then
    test_identities
  else
    start_agent
  fi
fi

# Source local startup script
[ -r ~/.bashrc_local ] && . ~/.bashrc_local

echo 'Executed .bashrc'

