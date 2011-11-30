# Bash Startup Script for Interactive Shells

# Systemwide Settings
[ -r /etc/bashrc ] && . /etc/bashrc

# Bash Options
shopt -s histappend

# Alias
alias ls='ls -F'
alias la='ls -FA'
alias ll='ls -FAl'

# Git Stuff
_git_ps1() {
  local b="$(git symbolic-ref HEAD 2>/dev/null)"
  if [ -n "$b" ]; then
    echo "  (${b##refs/heads/})"
  fi
}

# Prompt
export PS1='____________________________________________________________________________________________________\n\u@\h  \w$(_git_ps1)  #\! (\j bg)\n\$ '

