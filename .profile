# Profile
#

case "$(uname)" in
  FreeBSD)
    PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:~/.bin
    umask 077
    ;;
  Darwin)
    PATH=~/.brew/bin:$PATH:~/.bin
    ;;
  MINGW32*)
    [ "`pwd | tr [:upper:] [:lower:]`" != /c/windows/system32 ] || cd
    PATH=$PATH:~/.bin
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

# Set up Ruby environment
if [ "$(which rbenv)" ]; then
    eval "$(rbenv init -)"
fi

