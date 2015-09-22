" Vim Configuration

set nocompatible    " Required for Vundle
filetype off        " Required for Vundle

" Vundle
if finddir("~/.vim/bundle/Vundle.vim") != ''
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim' " Required
  Plugin 'lsdr/monokai'
  Plugin 'rust-lang/rust.vim'
  Plugin 'vim-scripts/alex.vim'
  Plugin 'vim-scripts/happy.vim'

  call vundle#end()
else
  echoerr "Vundle is not installed."
endif

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
set modelines=3    " Look at three lines

autocmd FileType html setlocal softtabstop=2 shiftwidth=2
autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2
autocmd FileType vim  setlocal softtabstop=2 shiftwidth=2

if has('gui_running')
  colorscheme slate " or jeffdark
  set go-=T " Hide toolbar
  set go-=r " Hide right scroll bar
  set go-=L " Hide left  scroll bar
  if v:version > 700
    " set cursorline   " Cursor crosshairs
    " set cursorcolumn " Cursor crosshairs
  endif
endif

" Don't move 1 char left when exiting insert mode
au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

" Use jk instead of escape to exist insert mode
inoremap jk <Esc>

" Use Enter to insert new lines
nnoremap <S-Enter> O<Esc>j
nnoremap <CR> o<Esc>

" Join/krack comma-separated lists
noremap <C-J> :s/,\?\s*\r\?\n.\@=/, /<CR>
noremap <C-K> :s/,\@<=\s*/\r/g<CR>

