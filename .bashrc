# Bash startup script for interactive or remote shells
# https://www.gnu.org/software/bash/manual/bash.html#Bash-Startup-Files
# https://gist.github.com/sharpjs/07a064cdbae74a13b1fc160c448a7f67

# Bash compiled with -DSYS_BASHRC will have sourced the systemwide bashrc.

# For remote shells, bash runs .bashrc instead of .bash_profile.  Fix that.
if [[ -n $SSH_CONNECTION ]]; then
  [[ -r /etc/profile ]] && . /etc/profile
  [[ -r   ~/.profile ]] && .   ~/.profile
fi

# Rest of file is for interactive shells only
[[ $- == *i* ]] || return

# Quality of life
shopt -s cdspell                # Correct minor spelling errors in cd command
shopt -s checkjobs              # Warn on exit if there are running jobs
shopt -s checkwinsize           # Update LINES and COLUMNS after each command
shopt -s progcomp_alias         # Show completions for expanded aliases

# Globbing
shopt -s dotglob                # Make * include .*
shopt -s extglob                # Enable ! @ ? * + extended globbing operators
shopt -s globstar               # Enable ** wildcard in pathname expansion

# History
shopt -s cmdhist                # Save multi-line commands as a single line
shopt -s histappend             # Append to history file instead of overwriting
shopt -s histverify             # Edit history substitution before executing
HISTFILESIZE=1000000            # Keep 1,000,000 entries in the history file
HISTSIZE=1000000                # Keep 1,000,000 entries in process memory
HISTCONTROL=ignorespace         # Ignore command lines starting with space
HISTIGNORE='ls:la:ll:bg:fg:history' # Ignore specific command lines
# TODO: multi-session history sync

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

# Clipboard
case "$(uname)" in
  Darwin)
    alias cb-set='pbcopy'
    alias cb-copy='tee >(pbcopy)'
    alias cb-paste='pbpaste'
    ;;
  Linux)
    if [ "$WAYLAND_DISPLAY" ] && which wl-copy >/dev/null 2>&1; then
      alias cb-set='wl-copy'
      alias cb-copy='tee >(wl-copy)'
      alias cb-paste='wl-paste'
    elif [ "$DISPLAY" ] && which xclip >/dev/null 2>&1; then
      alias cb-set='xclip -selection clipboard'
      alias cb-copy='tee >(xclip -selection clipboard)'
      alias cb-paste='xclip -selection clipboard -o'
    fi
    ;;
esac

# Completion
if ! shopt -oq posix; then
  if [ -n "$BASH_COMPLETION_VERSINFO" ]; then
    : # already loaded
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
  bind 'set completion-ignore-case on'
fi

# Better which
which() {
  { alias; declare -f; } | /usr/bin/which \
    --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}

# Git info in prompt
_js_git_ps1() {
  local b="$(git symbolic-ref HEAD 2>/dev/null)"
  if [ -n "$b" ]; then
    echo "  (${b##refs/heads/})"
  fi
}

# Prompt
export PS1=\
'───────────────────────────────────────────────────────────────────────────────────────────────────\n'\
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
unset need_ssh_agent
unset need_ssh_add

# Source local startup script
[ -r ~/.bashrc_local ] && . ~/.bashrc_local

echo "Executed .bashrc"

