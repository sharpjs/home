" Vim Configuration
" Inspiration:
" - https://jamesdixon.dev/posts/a-minimal-vimrc/

" Plugins
" https://github.com/junegunn/vim-plug
if !has('win32unix')
  call plug#begin('~/.vim/plugged')
    Plug 'cespare/vim-toml'
    Plug 'junegunn/vim-easy-align'
    Plug 'rust-lang/rust.vim'
  call plug#end()
endif

" UI
set number                " Line numbers
set laststatus=2          " Always show status line
set showcmd               " Show normal-mode commands

set wildmenu                   " Show completion menu
set wildignorecase             " Use case-insensitive completion
set wildmode=longest:full,full " Use bash-like completion first, then menu

set statusline=\ #%n:\ %<%f%(\ %m%)%=%(%y\ %)[%{&ff}]\ %04l:%03c=U+%04B\ (%3p%%)\ 

" Syntax highlighting
syntax on                 " Use syntax highlighting
filetype plugin on        " Enable per-filetype plugins
filetype indent on        " Enable per-filetype indentation

" Encoding
set encoding=utf-8        " Prefer UTF-8
set fileformats=unix,dos  " Detect EOL types

" Indents
set tabstop=8             " What a \t is worth
set softtabstop=4         " What the TAB key does
set shiftwidth=4          " What the << >> commands do
set expandtab             " Insert spaces instead of tabs
set smarttab              " TAB key uses shiftwidth at BOL
set autoindent            " Indent next line the same
set smartindent           " Indent more for known code blocks
set nowrap                " Don't wrap lines

" Search
set hlsearch              " Highlight search results
set incsearch             " Search as each character is typed
set ignorecase            " Search case-insensitively
set smartcase             " ...unless searching for capital letters
set showmatch             " Highlight matching parens/braces/brackets

" Other
set modeline              " Interpret modelines
set modelines=3           " Look at three lines
set splitbelow            " Open splits below the current
set splitright            " Open vsplits to right of current
set visualbell            " Turns off annoying dings
set nobackup              " Do not write backup (foo~) files on save
set noswapfile            " Do not create swap (foo.swp) while editing

" Don't autocomplete these files
set wildignore=*.o,*~

autocmd FileType css,html,javascript,json,ruby,sh,vim,yaml
  \ setlocal softtabstop=2 shiftwidth=2 expandtab

if has('gui_running')
  set go-=m " Hide menu bar
  set go-=T " Hide toolbar
  set go-=r " Hide right scroll bar
  set go-=L " Hide left  scroll bar
  set columns=221 lines=80
  if has('gui_win32')
    set guifont=Iosevka_Lomen:h10:cDEFAULT:qCLEARTYPE
    set renderoptions=type:directx,geom:1,renmode:6
    " geom:1    => RGB subpixels
    " renmode:6 => use outlines directly, bypassing rasterizer
  elseif has('gui_gtk2') || has('gui_gtk3')
    set guifont=Iosevka\ Lomen\ 10
  elseif has('gui_macvim')
    set guifont=Iosevka_Lomen:h10
  endif
endif

if $COLORTERM ==? 'truecolor' || exists('$WT_SESSION')
  set termguicolors
endif

if has('gui_running') || &termguicolors
  colorscheme cgdark
  set cursorline
  set colorcolumn=81,101
endif

" Use system clipboard instead of unnamed register
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" Don't move 1 char left when exiting insert mode
autocmd InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

" Use jk instead of escape to exist insert mode
inoremap jk <Esc>

" Use Enter to insert new lines
nnoremap <S-Enter> O<Esc>j
nnoremap <CR> o<Esc>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Join/krack comma-separated lists
noremap <C-J> :s/,\?\s*\r\?\n.\@=/, /<CR>
noremap <C-K> :s/,\@<=\s*/\r/g<CR>

