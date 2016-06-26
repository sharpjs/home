" Vim syntax file
" Language:     ColdFire MCF5307 Assembler - ASPP/CPP/GAS toolchain
" Maintainer:   Jeff Sharp
" Last change:  2016 Jun 24
"
" This syntax file is based on the asm68k syntax file.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Registers
syn keyword asmcfReg        a0 a1 a2 a3 a4 a5 a6 a7 d0 d1 d2 d3 d4 d5 d6 d7
syn keyword asmcfReg        sp fp pc ccr sr vbr cacr acr0 acr1 rambar mbar bc
syn keyword asmcfReg        acc macsr mask

" " Macro definition
" syn match   asmcfMacro      "\.macro\>"     contained
" syn match   asmcfMacro      "\.endm\>"      contained
" syn match   asmcfMacroParam "\\[0-9]"

" Operands
syn region  asmcfOperands   start="\v(\r?\n|;|//)@!" skip="\\\r\?\n" end="\v$|;|(//)@="
    \                       contained contains=asmcfReg,asmcfOperator

" Numbers
syn match   asmcfDecNumber  "\v<\d+>"                       containedin=asmcfOperands
syn match   asmcfOctNumber  "\v<0\o+>"                      containedin=asmcfOperands
syn match   asmcfHexNumber  "\v<0x\x+>"                     containedin=asmcfOperands
syn match   asmcfBinNumber  "\v<0b[01]+>"                   containedin=asmcfOperands

" Strings
syn region  asmcfString     start=/"/ skip=/\\\_./ end=/"/  containedin=asmcfOperands
syn match   asmcfCharacter  "'\\\?\_."                      containedin=asmcfOperands

" Operators
syn match   asmcfOperator   "[-+*/%|&^!<>=,\$]"             containedin=asmcfOperands
syn match   asmcfOperator   "[=!]=\|>[=>]\|<[=<>]\|&&\|||"  containedin=asmcfOperands
syn match   asmcfImmediate  "#"                             containedin=asmcfOperands
syn match   asmcfAsppEscape "@"                             containedin=asmcfOperands

" Symbols
syn match   asmcfSymbol     "\v(\.|<[a-z_])[a-z0-9_.$]*"    containedin=asmcfOperands

" Mnemonics
syn match   asmcfMnemonic   "\v(\.|<[a-z_])[a-z0-9_.$]*"    nextgroup=asmcfOperands

" Labels
syn match   asmcfLabel      "\v(\.|<[a-z_])[a-z0-9_.$]*(::?|(\s+)?\=@=)"
syn match   asmcfLabel      "\v<\d+\$?:"

" Preprocessor
syn region  asmcfPreProc    start="^#" skip="\\\r\?\n" end="$"
    \                       contains=asmcfCommentLine,asmcfCommentBlock

" Comments
syn match   asmcfCommentLine    "//.*"                  contains=asmcfTodo
syn match   asmcfCommentLine    "^\*.*"                 contains=asmcfTodo
syn region  asmcfCommentBlock   start="/\*" end="\*/"   contains=asmcfTodo
syn keyword asmcfTodo           contained TODO

" Stuff

syn sync fromstart
syn sync maxlines=100
syn sync ccomment asmcfCommentBlock

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_asmcf_syntax_inits")
  if version < 508
    let did_asmcf_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  " Comment Constant Error Identifier PreProc Special Statement Todo Type
  "
  " Constant    Boolean Character Number String
  " Identifier  Function
  " PreProc     Define Include Macro PreCondit
  " Special     Debug Delimiter SpecialChar SpecialComment Tag
  " Statement   Conditional Exception Keyword Label Operator Repeat
  " Type        StorageClass Structure Typedef

  HiLink asmcfPreProc       PreProc

  HiLink asmcfLabel         Label

  HiLink asmcfMnemonic      Function

  HiLink asmcfBinNumber     Number
  HiLink asmcfOctNumber     Number
  HiLink asmcfDecNumber     Number
  HiLink asmcfHexNumber     Number
  HiLink asmcfString        String
  HiLink asmcfCharacter     Character

  HiLink asmcfReg           Keyword
  HiLink asmcfSymbol        Identifier

  HiLink asmcfOperator      Operator
  HiLink asmcfImmediate     SpecialChar
  HiLink asmcfAsppEscape    Exception

  HiLink asmcfComment       Comment
  HiLink asmcfCommentLine   Comment
  HiLink asmcfCommentBlock  Comment
  HiLink asmcfTodo          Todo

  delcommand HiLink
endif

let b:current_syntax = "asmcf"

" vim: ts=8 sw=2

