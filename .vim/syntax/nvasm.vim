" Vim syntax file
" Language:     ColdFire assembly, nasm > nasm2gas > vasm_std toolchain
" Maintainer:   Jeff Sharp
" Last change:  2017 May 28

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

" Comment autoformatting
setlocal comments=:;
setlocal formatoptions=croqj

" Chars in symbols, directives, and \k
setlocal iskeyword=@,48-57,$,.,_

" Comments
syn match   nvasmComment    "\v;.*"         keepend contains=nvasmTodo
syn match   nvasmComment    "\v^#.*"        keepend contains=nvasmTodo
syn match   nvasmTodo       "\v(TODO|FIXME|HACK|NOTE):" contained

" " Macro definition
" syn match   nvasmMacro      "\.macro\>"     contained
" syn match   nvasmMacro      "\.endm\>"      contained

" " Operands
" syn region  nvasmOperands   start="\v(\r?\n|;|//)@!" skip="\\\r\?\n" end="\v$|;|(//)@="
"     \                       contained contains=nvasmReg,nvasmOperator

" Numbers
syn match   nvasmDecNumber  "\v-?<\d+>"                       "containedin=nvasmOperands
syn match   nvasmOctNumber  "\v-?<0\o+>"                      "containedin=nvasmOperands
syn match   nvasmHexNumber  "\v-?<0x\x+>"                     "containedin=nvasmOperands
syn match   nvasmBinNumber  "\v-?<0b[01]+>"                   "containedin=nvasmOperands

" Strings
syn region  nvasmString     start=/"/ skip=/\\\_./ end=/"/  "containedin=nvasmOperands
syn match   nvasmCharacter  "\v'\\?\_."                     "containedin=nvasmOperands

" Operators
syn match   nvasmOperator   "[+*/%|&^!<>=\$]\|-\d\@!"             "containedin=nvasmOperands
syn match   nvasmOperator   "[=!]=\|>[=>]\|<[=<>]\|&&\|||"  "containedin=nvasmOperands
syn match   nvasmImmediate  "#"                             "containedin=nvasmOperands
syn match   nvasmAsppEscape "@"                             "containedin=nvasmOperands
syn match   nvasmDelimiter  "[()\[\],]"                      "containedin=nvasmOperands

" syn match   nvasmMacroParam "\v\\(\(\)|(\.|[a-z_])[a-z0-9_.$]*)"   containedin=nvasmOperands

" Identifiers
syn match   nvasmSymbol     "\v<\u@!\K\k*>"
syn match   nvasmType       "\v<\u\k*>"
syn match   nvasmDirective  "\v^\s*\zs\.\K\k*>:@!"
syn match   nvasmMnemonic   "\v^\s*\zs\.@!\K\k*>:@!"
syn match   nvasmLabel      "\v^\s*\zs\K\k*\ze::?"
syn match   nvasmSymbol     "\v^\s*\zs\u@!\K\k*\ze\s*\="
syn match   nvasmConstant   "\v<(\u|_)(\u|\d|_)*>"
syn match   nvasmMacroParam "\v\%([%$]|\?\??|00?|1\d+>|\K\k*>)?"
syn match   nvasmComment    "\v<_\(.{-}\)" keepend " Put last to get priority

" Registers
syn case    ignore
syn match   nvasmReg        "\v<([ad][0-7]|s[pr]|fp|pc|ca?cr)>"
syn match   nvasmReg        "\v<(vbr|ac(c|ro[01])|rambar|m(a(csr|sk)|bar)|bc)>"
syn case    match

"exec 'syn match   nvasmSymbol     "\v'.s:id.'"'
                                                 " containedin=nvasmOperands contains=nvasmMacroParam'
" exec 'syn match   nvasmMnemonic   "\v'.s:id.'"   nextgroup=nvasmOperands contains=nvasmMacroParam'
" exec 'syn match   nvasmLabel      "\v'.s:id.'(::?|(\s+)?\=@=)"           contains=nvasmMacroParam'
" exec 'syn match   nvasmLabel      "\v<\d+\$?:"'

" Preprocessor
syn region  nvasmPreProc    start="\v^\s*\%" skip="\v\\\r?\n" end="$"
    \                       contains=nvasmComment,nvasmString

" Stuff

syn sync maxlines=1
syn sync linecont "\v\\$"

"syn case match

" Define the default highlighting.
"
" The default methods for highlighting.  Can be overridden later
" Comment Constant Error Identifier PreProc Special Statement Todo Type
"
" Constant    Boolean Character Number String
" Identifier  Function
" PreProc     Define Include Macro PreCondit
" Special     Debug Delimiter SpecialChar SpecialComment Tag
" Statement   Conditional Exception Keyword Label Operator Repeat
" Type        StorageClass Structure Typedef

" hi link nvasmPreProc      PreProc
" hi link nvasmMacroParam   Macro
" 
" hi link nvasmLabel        Label
" 
" hi link nvasmMnemonic     Statement
"                                " Function
" 
" hi link nvasmBinNumber    Number
" hi link nvasmOctNumber    Number
" hi link nvasmDecNumber    Number
" hi link nvasmHexNumber    Number
" hi link nvasmString       String
" hi link nvasmCharacter    Character
" 
" hi link nvasmReg          Function
" hi link nvasmSymbol       Identifier
" hi link nvasmConstant     Type
" 
" hi link nvasmOperator     Exception
" hi link nvasmImmediate    Constant
" hi link nvasmAsppEscape   Exception
" hi link nvasmDelimiter    Delimiter
" 
" hi link nvasmComment      Comment
" hi link nvasmTodo         Todo
"
hi link nvasmPreProc      PreProc
hi link nvasmMacroParam   Macro

hi link nvasmLabel        Label

hi link nvasmDirective    Statement
hi link nvasmMnemonic     Function

hi link nvasmBinNumber    Number
hi link nvasmOctNumber    Number
hi link nvasmDecNumber    Number
hi link nvasmHexNumber    Number
hi link nvasmString       String
hi link nvasmCharacter    Character

hi link nvasmReg          Keyword
hi link nvasmSymbol       Normal
hi link nvasmConstant     Constant

hi link nvasmOperator     Special
hi link nvasmImmediate    Delimiter
hi link nvasmAsppEscape   Exception
hi link nvasmDelimiter    Special

hi link nvasmComment      Comment
hi link nvasmTodo         Todo

let b:current_syntax = "nvasm"

" vim: ts=8 sw=2

