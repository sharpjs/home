" Vim syntax file
" Language:     ColdFire MCF5307 Assembler + GAS + CPP
" Maintainer:   Jeff Sharp
" Last change:  2014 Sep 17
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

" Opcodes
syn match   asmcfOpcodeArea "\v(^|[;:])\s*\zs\a[a-z0-9._$]*\ze(\s|$)"
  \ contains=asmcfOpcode,asmcfDirective oneline

syn match   asmcfOpcode     "\v<\a[a-z0-9._$]*>"            contained

syn match   asmcfDirective  "\v(^|[;:])\s*\zs\.[a-z0-9\._$]*\ze(\s|$)"
  \ contains=asmcfMacro oneline

" Macro definition
syn match   asmcfMacro      "\.macro\>"     contained
syn match   asmcfMacro      "\.endm\>"      contained
" syn match asmcfMacroParam "\\[0-9]"

" Labels
syn match   asmcfLabel      "^\s*\zs[a-z_.][a-z0-9_.$]*\ze\s*:"
syn match   asmcfLabel      "^\s*\zsL([a-z0-9_$]\+)\ze\s*:"
syn match   asmcfLabel      "^\s*\zs\d\+$\?\ze\s*:"

" Numbers
syn match   decNumber       "\v<\d+>"
syn match   hexNumber       "\v<0x\x+>"
syn match   octNumber       "\v<0\o+>"
syn match   binNumber       "\v<0b[01]+>"

" Strings
syn region  asmcfString     start=/"/ skip=/\\./ end=/"/
syn match   asmcfCharacter  "'\\\?\_."

" Operators
syn match   asmcfOperator   "[-+*/%|&^!<>=#,\$]" " must come before
syn match   asmcfOperator   "[=!]=\|>[=>]\|<[=<>]\|&&\|||"

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
  " Constant  Boolean Character Number String
  " Identifier  Function
  " PreProc  Define Include Macro PreCondit
  " Special  Debug Delimiter SpecialChar SpecialComment Tag
  " Statement  Conditional Exception Keyword Label Operator Repeat
  " Type  StorageClass Structure Typedef

  HiLink asmcfComment       Comment
  HiLink asmcfCommentLine   Comment
  HiLink asmcfCommentBlock  Comment
  HiLink asmcfTodo          Todo
  HiLink hexNumber          Number          " Constant
  HiLink octNumber          Number          " Constant
  HiLink binNumber          Number          " Constant
  HiLink decNumber          Number          " Constant
 "HiLink asmcfImmediate     SpecialChar
 "HiLink asmcfSymbol        Constant
  HiLink asmcfString        String          " Constant
  HiLink asmcfCharacter     Character
  HiLink asmcfOpcodeArea    Error
  HiLink asmcfReg           Identifier
  HiLink asmcfOperator      Identifier
  HiLink asmcfInclude       Include         " PreProc
  HiLink asmcfMacro         Macro           " PreProc
  HiLink asmcfMacroParam    Keyword         " Statement
  HiLink asmcfDirective     Keyword
  HiLink asmcfPreCond       Special
  HiLink asmcfOpcode        Statement
  HiLink asmcfCond          Conditional     " Statement
  HiLink asmcfRepeat        Repeat          " Statement
  HiLink asmcfLabel         Type

  delcommand HiLink
endif

let b:current_syntax = "asmcf"

" vim: ts=8 sw=2

