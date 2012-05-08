# Profile
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:~/.bin

case `uname` in
  FreeBSD)
    umask 077
    ;;
  Darwin)
    PATH=~/.brew/bin:$PATH
    ;;
  MINGW32*)
    platform=win
    ;;
esac

export PATH

if which -s vim; then
  EDITOR=vim
  export EDITOR
fi

if which -s less; then
  PAGER=less
  export PAGER
fi

# Setup Ruby environment
if which -s rbenv; then
    eval "$(rbenv init -)"
fi

