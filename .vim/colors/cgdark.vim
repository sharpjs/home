" CG Dark Color Scheme
"
" Author:  Jeff Sharp <>
" Updated: 2016-06-26 
" License: Public Domain
"
" To see all groups
" :so $VIMRUNTIME/syntax/hitest.vim 

" Preamble
set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "cgdark"

" Terminal Colors
"
"  0  Black
"  1  DarkBlue
"  2  DarkGreen
"  3  DarkCyan
"  4  DarkRed
"  5  DarkMagenta
"  6  Brown
"  7  Gray
"
"  8  DarkGray
"  9  Blue
" 10  Green
" 11  Cyan
" 12  Red
" 13  Magenta
" 14  Yellow
" 15  White

" General
hi        Normal          ctermfg=Gray        guifg=#fff9f4  ctermbg=NONE        guibg=#20252a  cterm=NONE  gui=NONE
hi        NonText         ctermfg=DarkGray    guifg=#333333  ctermbg=NONE        guibg=#20252a  cterm=NONE  gui=NONE
hi        Folded          ctermfg=DarkGray    guifg=#888888  ctermbg=NONE        guibg=#20252a  cterm=NONE  gui=NONE

" Cursor
hi        Cursor          ctermfg=NONE        guifg=NONE     ctermbg=NONE        guibg=#766B13  cterm=NONE  gui=NONE
hi        CursorLine      ctermfg=NONE        guifg=NONE     ctermbg=DarkGray    guibg=#2b2f34  cterm=NONE  gui=NONE
hi        CursorColumn    ctermfg=NONE        guifg=NONE     ctermbg=DarkGray    guibg=#2b2f34  cterm=NONE  gui=NONE

" Gutters
hi        LineNr          ctermfg=DarkGray    guifg=#888888  ctermbg=NONE        guibg=#2b2f34  cterm=NONE  gui=NONE
hi        CursorLineNr    ctermfg=Gray        guifg=#888888  ctermbg=NONE        guibg=#404348  cterm=NONE  gui=NONE
hi        StatusLine      ctermfg=Black       guifg=#888888  ctermbg=Gray        guibg=#2b2f34  cterm=NONE  gui=NONE
hi        StatusLineNC    ctermfg=Black       guifg=#777777  ctermbg=DarkGray    guibg=#2b2f34  cterm=NONE  gui=NONE
hi        VertSplit       ctermfg=Black       guifg=#2b2f34  ctermbg=DarkGray    guibg=#2b2f34  cterm=NONE  gui=NONE

" Messages
hi        ErrorMsg        ctermfg=Red         guifg=#FF0000  ctermbg=NONE        guibg=NONE
hi        WarningMsg      ctermfg=Yellow      guifg=#CCCC00  ctermbg=NONE        guibg=NONE
hi        MoreMsg         ctermfg=Green       guifg=#00FF00  ctermbg=NONE        guibg=NONE
hi! link  ModeMsg         WarningMsg

" ===== Syntax Style =====

hi        Comment         ctermfg=DarkGray    guifg=#7C7C7C     ctermbg=NONE      guibg=NONE
hi        SpecialComment  ctermfg=DarkGray    guifg=#666666     ctermbg=NONE      guibg=NONE

" Constants
hi        Constant        ctermfg=Magenta     guifg=#FF9BD0     gui=NONE
hi        String          ctermfg=DarkGreen   guifg=#8F9D6A     gui=NONE
"i! link  Character       String
hi        Number          ctermfg=Green       guifg=#78CF8A     gui=NONE
hi        Boolean         ctermfg=Brown       guifg=#DAD085     gui=NONE
"i! link  Float           Number

" Style for identifier and variable names
hi! link  Identifier      Normal
hi        Function        ctermfg=Yellow      guifg=#FFF39C     gui=NONE

" Style for statements
hi        Statement       ctermfg=Brown       guifg=#FFD183     gui=NONE
"i  link  Conditional     Statement
"i  link  Repeat          Statement
hi        Label           ctermfg=DarkMagenta guifg=#9999CC     gui=NONE
hi        Operator        ctermfg=Green       guifg=#FA8D6A     gui=NONE
hi        Keyword         ctermfg=DarkRed     guifg=#CDA869     gui=NONE
"i  link  Exception       Statement

" Style for generic preprocessor
hi        PreProc         ctermfg=Gray        guifg=#cda869     ctermbg=NONE      guibg=NONE
"i        Include         ctermfg=DarkRed     guifg=#C86432     ctermbg=NONE      guibg=NONE
"i  link  Define          Include
"i  link  Macro           Include
"i  link  PreCondit       Include

" Style for types and objects
hi        Type              ctermfg=Cyan      guifg=#aac6e3     gui=NONE
"i  link  StorageClass    Type
"i  link  Structure       Type
"i  link  Typedef         Type

" Style for special symbols
hi        Special           ctermfg=Yellow    guifg=#9b859d     gui=NONE
"i! link  SpecialChar       Special
"i! link  Tag               Special
hi        Delimiter         guifg=#24C2C7 gui=NONE
"i        SpecialComment  
"i        Debug           

" Style for other text
"i        Underlined 
"i        Ignore     

hi        Error             ctermbg=DarkRed ctermbg=White guifg=#D2A8A1 guibg=#482C4B gui=underline

hi! link  Todo              Preproc

