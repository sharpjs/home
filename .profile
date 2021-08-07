# Profile for Bash and sh
# https://www.gnu.org/software/bash/manual/bash.html#Bash-Startup-Files
# https://gist.github.com/sharpjs/07a064cdbae74a13b1fc160c448a7f67

# Bash compiled with -DSYS_BASHRC will have sourced the systemwide profile.

# Perform OS-specific setup
case "$(uname)" in
  Darwin)
    ;;
  FreeBSD)
    PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
    umask 077
    ;;
  Linux)
    umask 077
    ;;
  MINGW32*)
    [ "`pwd | tr [:upper:] [:lower:]`" != /c/windows/system32 ] || cd
    ;;
esac

# Optional PATH: ~/bin
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Optional PATH: ~/.bin
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

# Optional PATH: ~/.local/bin
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Optional PATH: ~/.cargo/bin (for Rust)
if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

# Done with optional PATH entries
export PATH

# Choose editor
_vim="$(which vim)"
if [ "$_vim" ]; then
  EDITOR="$_vim"
  export EDITOR
fi
unset _vim

# Choose pager
_less="$(which less)"
if [ "$_less" ]; then
  PAGER="$_less"
  export PAGER
fi
unset _less

# Set up Ruby environment
if [ "$(which rbenv 2>/dev/null)" ]; then
    eval "$(rbenv init -)"
fi

