# Profile for bash and sh

case "$(uname)" in
  Darwin)
    PATH="$PATH:~/.bin"
    ;;
  FreeBSD)
    PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:~/.bin
    umask 077
    ;;
  Linux)
    PATH="$PATH:~/.bin"
    umask 077
    ;;
  MINGW32*)
    [ "`pwd | tr [:upper:] [:lower:]`" != /c/windows/system32 ] || cd
    PATH="$PATH:~/.bin"
    ;;
esac
export PATH

# Choose editor
if [ "$(which vim)" ]; then
  EDITOR=vim
  export EDITOR
fi

# Choose pager
if [ "$(which less)" ]; then
  PAGER=less
  export PAGER
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set up Rust environment
if [ -d ~/.cargo/bin ]; then
  PATH="~/.cargo/bin:$PATH"
  export PATH
fi

# Set up Ruby environment
if [ "$(which rbenv 2>/dev/null)" ]; then
    eval "$(rbenv init -)"
fi

