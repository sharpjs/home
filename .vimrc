" Vim Configuration

" Plugins
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
  Plug 'cespare/vim-toml'
  Plug 'chriskempson/base16-vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'lsdr/monokai'
  Plug 'rust-lang/rust.vim'
  Plug 'vim-scripts/alex.vim'
  Plug 'vim-scripts/happy.vim'
call plug#end()

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
set nowrap         " Don't wrap lines
set modeline       " Interpret modelines
set modelines=3    " Look at three lines
set splitbelow     " Open splits below the current
set splitright     " Open vsplits to right of current
set visualbell     " Turns off annoying dings
set nobackup       " Do not write backup (foo~) files on save
set noswapfile     " Do not create swap (foo.swp) while editing

autocmd FileType html setlocal softtabstop=2 shiftwidth=2
autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2
autocmd FileType sh   setlocal softtabstop=2 shiftwidth=2
autocmd FileType vim  setlocal softtabstop=2 shiftwidth=2

if has('gui_running')
  set go-=m " Hide menu bar
  set go-=T " Hide toolbar
  set go-=r " Hide right scroll bar
  set go-=L " Hide left  scroll bar
  set guifont=SF\ Mono\ Medium\ 11
endif

if exists('$ConEmuBuild')
  set termguicolors
endif

if has('gui_running') || &termguicolors
  colorscheme cgdark
  set cursorline
  set colorcolumn=81,101
endif

" Don't autocomplete these files
set wildignore=*.o,*.hi,*~,*.hi,Lexer.hs,Parser.hs

" Use system clipboard instead of unnamed register
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" Don't move 1 char left when exiting insert mode
au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

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

