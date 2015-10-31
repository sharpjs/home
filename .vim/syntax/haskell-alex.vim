" Vim syntax file
" Language:     Alex (Haskell Lexer Generator)
" Maintainer:   Jeffrey Sharp
" Last Change:  3 October 2015
"
" Version:      0.3
" Changes:      forked from alex.vim by Nickolay Kudasov <false.developer@gmail.com>
"               Requires Vim >= 600

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Macro names start with $ or @.
" so we add this symbols to isident to make autocompletion work properly
set isident+=$
set isident+=@

syn sync fromstart
syn sync maxlines=100
syn case match

syn match   alexEscape      /\v\\(x\x+|o\o+|\d+|.)/ display
syn match   alexChar        /\v[\\\[\]^]@!\S/       display

syn region  alexString      start='\v\"' skip='\v\\.' end='\v\"' oneline display
syn region  alexStartCode   start="\v\<"              end="\v\>" oneline display
syn region  haskellCode     start="\v\{"              end="\v\}" fold contains=haskellCode

" Regular Expressions
syn match   alexRegOp       "\v[|*+?()]"                  display
syn match   alexRegRepeat   "\v\{\d+(,\d*)?\}"            display
syn match   alexRegMacro    "\v\@[a-zA-Z_][a-zA-Z0-9'_]*" display

" Character Sets
syn match   alexSetOp       "\v[-.#~]"                    display
syn region  alexSetUnion    start="\v\[\^?"rs=e+1 skip="\v\\." end="\v\]"re=s-1
  \ display oneline contains=alexChar,alexEscape,alexSetOp,alexSetUnion,alexSetMacro
syn match   alexSetMacro    "\v\$[a-zA-Z_][a-zA-Z0-9'_]*" display

" Comments
syn match   alexComment     /\v--.*/              display contains=alexTodo
syn match   alexTodo        /\v\cTODO|FIXME|XXX/  display contained

" Misc
syn match   alexSeparator   "\v:-"

" " Haskell code in alex file
" syn match haskellCommentLine  /--.*$/ contained contains=alexTodo,alexFixme
" syn match haskellChar /'[^\\]'\|'\\.'/ contained
" 
" syn region haskellString           start=/"/ skip=/\\"/ end=/"/        contained
" syn region haskellCommentBlock    start=/{-/ end=/-}/                 fold contained contains=haskellCommentBlock,alexTodo,alexFixme
" syn region haskellDirective        start=/{-#/ end=/#-}/               contained
" syn region haskellCode             start=/{/ skip=/'\\\?}'/ end=/}/    fold contains=haskellCommentLine,haskellCommentBlock,haskellString,haskellChar,haskellCode,haskellDirective

" Keywords
syn keyword alexKeywords wrapper tokens

hi link alexString      String
hi link alexChar        Character
hi link alexEscape      Character

hi link alexStartCode   Conditional

hi link alexComment     Comment
hi link alexTodo        Todo

hi link alexRegOp       Number
hi link alexRegRepeat   Number
hi link alexRegMacro    Function

hi link alexSetOp       Boolean
hi link alexSetUnion    Boolean
hi link alexSetMacro    Identifier

hi link alexSeparator   Special

"hi def link haskellCommentLine      Comment
"hi def link haskellCommentBlock     Comment
"hi def link haskellDirective        Special
"hi def link haskellChar             Character
"hi def link haskellString           String

" Register
let b:current_syntax = "haskell-alex"

" vim: ts=8 sw=2
