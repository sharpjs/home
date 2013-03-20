" VIM Configuration

colorscheme desert " jeffdark
syntax on          " Use syntax highlighting
set number         " Line numbers
set laststatus=2   " Always show status line

set statusline=\ #%n:\ %<%f%(\ %m%)%=%(%y\ %)[%{&ff}]\ %04l:%03c=%02Bh\ (%3p%%)\ 

filetype plugin on " Enable per-filetype plugins
filetype indent on " Enable per-filetype indentation

set tabstop=8      " What a \t is worth
set softtabstop=4  " What the TAB key does
set shiftwidth=4   " What the << >> commands do
set expandtab      " Insert spaces instead of tabs
set autoindent     " Indent next line the same
set smartindent    " Indent more for known code blocks
set smarttab       " TAB key uses shiftwidth at BOL
set modeline       " Interpret modelines
set modelines=3    " Look at five lines

autocmd FileType html setlocal softtabstop=2 shiftwidth=2

if has('gui_running')
  set go-=T " Hide toolbar
  set go-=r " Hide right scroll bar
  set go-=L " Hide left  scroll bar
  if v:version > 700
    set cursorline   " Cursor crosshairs
    set cursorcolumn " Cursor crosshairs
  endif
endif

