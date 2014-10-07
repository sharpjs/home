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
syn match   asmcfOpcodeArea "\v(^|[;]) *\zs\a[a-z0-9\._]*\ze(\s|$)"
  \ contains=asmcfOpcode,asmcfDirective oneline

syn match   asmcfOpcode     "\v<add[aiqx]?(\.?l)?>"         contained
syn match   asmcfOpcode     "\v<andi?(\.?l)?>"              contained
syn match   asmcfOpcode     "\v<as[lr](\.?l)?>"             contained
syn match   asmcfOpcode     "\v<bc[cs](\.?[bsw])?>"         contained
syn match   asmcfOpcode     "\v<b(eq|ne)(\.?[bsw])?>"       contained
syn match   asmcfOpcode     "\v<bg[et](\.?[bsw])?>"         contained
syn match   asmcfOpcode     "\v<bh[is](\.?[bsw])?>"         contained
syn match   asmcfOpcode     "\v<bl[est](\.?[bsw])?>"        contained
syn match   asmcfOpcode     "\v<b(mi|pl)(\.?[bsw])?>"       contained
syn match   asmcfOpcode     "\v<b(ra|sr)(\.?[bsw])?>"       contained
syn match   asmcfOpcode     "\v<bv[cs](\.?[bsw])?>"         contained
syn match   asmcfOpcode     "\v<bc(hg|lr)(\.?[bl])?>"       contained
syn match   asmcfOpcode     "\v<b(se|ts)t(\.?[bl])?>"       contained
syn match   asmcfOpcode     "\v<clr(\.?[bwl])?>"            contained
syn match   asmcfOpcode     "\v<cmp[ai]?(\.?l)?>"           contained
syn match   asmcfOpcode     "\v<cpushl>"                    contained
syn match   asmcfOpcode     "\v<div[su](\.?[wl])?>"         contained
syn match   asmcfOpcode     "\v<div[su]l(\.?l)?>"           contained
syn match   asmcfOpcode     "\v<eori?(\.?l)?>"              contained
syn match   asmcfOpcode     "\v<extb(\.?l)?>"               contained
syn match   asmcfOpcode     "\v<ext(\.?[wl])?>"             contained
syn match   asmcfOpcode     "\v<halt>"                      contained
syn match   asmcfOpcode     "\v<illegal>"                   contained
syn match   asmcfOpcode     "\v<jmp>"                       contained
syn match   asmcfOpcode     "\v<jsr>"                       contained
syn match   asmcfOpcode     "\v<lea(\.?l)?>"                contained
syn match   asmcfOpcode     "\v<link(\.?w)?>"               contained
syn match   asmcfOpcode     "\v<ls[lr](\.?l)?>"             contained
syn match   asmcfOpcode     "\v<macl?(\.?[wl])?>"           contained
syn match   asmcfOpcode     "\v<movea(\.?[wl])?>"           contained
syn match   asmcfOpcode     "\v<move[cmq](\.?l)?>"          contained
syn match   asmcfOpcode     "\v<move(\.?[bwl])?>"           contained
syn match   asmcfOpcode     "\v<msacl?(\.?[wl])?>"          contained
syn match   asmcfOpcode     "\v<mul[su](\.?[wl])?>"         contained
syn match   asmcfOpcode     "\v<negx?(\.?l)?>"              contained
syn match   asmcfOpcode     "\v<nop>"                       contained
syn match   asmcfOpcode     "\v<not(\.?l)?>"                contained
syn match   asmcfOpcode     "\v<ori?(\.?l)?>"               contained
syn match   asmcfOpcode     "\v<pea(\.?l)?>"                contained
syn match   asmcfOpcode     "\v<pulse>"                     contained
syn match   asmcfOpcode     "\v<rem[su](\.?l)?>"            contained
syn match   asmcfOpcode     "\v<rt[es]>"                    contained
syn match   asmcfOpcode     "\v<sc[cs](\.?b)?>"             contained
syn match   asmcfOpcode     "\v<s(eq|ne)(\.?b)?>"           contained
syn match   asmcfOpcode     "\v<sg[et](\.?b)?>"             contained
syn match   asmcfOpcode     "\v<sh[is](\.?b)?>"             contained
syn match   asmcfOpcode     "\v<sl[est](\.?b)?>"            contained
syn match   asmcfOpcode     "\v<s(mi|pl)(\.?b)?>"           contained
syn match   asmcfOpcode     "\v<s[ft](\.?b)?>"              contained
syn match   asmcfOpcode     "\v<sv[cs](\.?b)?>"             contained
syn match   asmcfOpcode     "\v<stop(\.?w)?>"               contained
syn match   asmcfOpcode     "\v<sub[aiqx]?(\.?l)?>"         contained
syn match   asmcfOpcode     "\v<swap(\.?w)?>"               contained
syn match   asmcfOpcode     "\v<tpf(\.?[wl])?>"             contained
syn match   asmcfOpcode     "\v<trap>"                      contained
syn match   asmcfOpcode     "\v<tst(\.?[bwl])?>"            contained
syn match   asmcfOpcode     "\v<unlk>"                      contained
syn match   asmcfOpcode     "\v<wddata(\.?[bwl])?>"         contained
syn match   asmcfOpcode     "\v<wdebug(\.?l)?>"             contained

" Pseudo Opcodes
syn match   asmcfOpcode     "\v<(arg|var)(\.?[bwlx])?>"     contained
syn match   asmcfOpcode     "\v<andid(\.?l)?>"              contained
syn match   asmcfOpcode     "\v<cmpid(\.?l)?>"              contained
syn match   asmcfOpcode     "\v<endf>"                      contained
syn match   asmcfOpcode     "\v<enter>"                     contained
syn match   asmcfOpcode     "\v<func>"                      contained
syn match   asmcfOpcode     "\v<leave>"                     contained
syn match   asmcfOpcode     "\v<out>"                       contained
syn match   asmcfOpcode     "\v<pop>"                       contained
syn match   asmcfOpcode     "\v<push>"                      contained
syn match   asmcfOpcode     "\v<regs>"                      contained

syn match   asmcfOpcode     "\v<byte>"                      contained
syn match   asmcfOpcode     "\v<word>"                      contained
syn match   asmcfOpcode     "\v<long>"                      contained
syn match   asmcfOpcode     "\v<string>"                    contained

syn match   asmcfDirective  "\v(^|[;:]) *\zs\.[a-z0-9\._]*\ze(\s|$)"
  \ contains=asmcfMacro oneline

" Macro definition
syn match   asmcfMacro      "\.macro\>"     contained
syn match   asmcfMacro      "\.endm\>"      contained
" syn match asmcfMacro  "\<LOCAL\s"
" syn match asmcfMacro  "\<MEXIT\>"
" syn match asmcfMacro  "\<ENDM\>"
" syn match asmcfMacroParam "\\[0-9]"

" Labels
syn match   asmcfLabel      "^\s*\zs[a-z_.][a-z0-9_$]*\ze\s*:"
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
syn match   asmcfOperator   "[-+*/%|&^!<>=#,]" " must come before
syn match   asmcfOperator   "[=!]=\|>[=>]\|<[=<>]\|&&\|||"

" Comments
syn match   asmcfCommentLine    "//.*"                  contains=asmcfTodo
syn match   asmcfCommentLine    "^\*.*"                 contains=asmcfTodo
syn region  asmcfCommentBlock   start="/\*" end="\*/"   contains=asmcfTodo
syn keyword asmcfTodo           contained TODO

" Directives

" " Include
" syn match asmcfInclude  "\<INCLUDE\s"
" 
" " Standard macros
" syn match asmcfCond  "\<IF\(\.[BWL]\)\=\s"
" syn match asmcfCond  "\<THEN\(\.[SL]\)\=\>"
" syn match asmcfCond  "\<ELSE\(\.[SL]\)\=\>"
" syn match asmcfCond  "\<ENDI\>"
" syn match asmcfCond  "\<BREAK\(\.[SL]\)\=\>"
" syn match asmcfRepeat  "\<FOR\(\.[BWL]\)\=\s"
" syn match asmcfRepeat  "\<DOWNTO\s"
" syn match asmcfRepeat  "\<TO\s"
" syn match asmcfRepeat  "\<BY\s"
" syn match asmcfRepeat  "\<DO\(\.[SL]\)\=\>"
" syn match asmcfRepeat  "\<ENDF\>"
" syn match asmcfRepeat  "\<NEXT\(\.[SL]\)\=\>"
" syn match asmcfRepeat  "\<REPEAT\>"
" syn match asmcfRepeat  "\<UNTIL\(\.[BWL]\)\=\s"
" syn match asmcfRepeat  "\<WHILE\(\.[BWL]\)\=\s"
" syn match asmcfRepeat  "\<ENDW\>"
" 
" 
" " Conditional assembly
" syn match asmcfPreCond  "\<IFC\s"
" syn match asmcfPreCond  "\<IFDEF\s"
" syn match asmcfPreCond  "\<IFEQ\s"
" syn match asmcfPreCond  "\<IFGE\s"
" syn match asmcfPreCond  "\<IFGT\s"
" syn match asmcfPreCond  "\<IFLE\s"
" syn match asmcfPreCond  "\<IFLT\s"
" syn match asmcfPreCond  "\<IFNC\>"
" syn match asmcfPreCond  "\<IFNDEF\s"
" syn match asmcfPreCond  "\<IFNE\s"
" syn match asmcfPreCond  "\<ELSEC\>"
" syn match asmcfPreCond  "\<ENDC\>"
" 
" " Loop control
" syn match asmcfPreCond  "\<REPT\s"
" syn match asmcfPreCond  "\<IRP\s"
" syn match asmcfPreCond  "\<IRPC\s"
" syn match asmcfPreCond  "\<ENDR\>"
" 
" " Directives
" syn match asmcfDirective "\<ALIGN\s"
" syn match asmcfDirective "\<CHIP\s"
" syn match asmcfDirective "\<COMLINE\s"
" syn match asmcfDirective "\<COMMON\(\.S\)\=\s"
" syn match asmcfDirective "\<DC\(\.[BWLSDXP]\)\=\s"
" syn match asmcfDirective "\<DC\.\\[0-9]\s"me=e-3 " Special use in a macro def
" syn match asmcfDirective "\<DCB\(\.[BWLSDXP]\)\=\s"
" syn match asmcfDirective "\<DS\(\.[BWLSDXP]\)\=\s"
" syn match asmcfDirective "\<END\>"
" syn match asmcfDirective "\<EQU\s"
" syn match asmcfDirective "\<FEQU\(\.[SDXP]\)\=\s"
" syn match asmcfDirective "\<FAIL\>"
" syn match asmcfDirective "\<FOPT\s"
" syn match asmcfDirective "\<\(NO\)\=FORMAT\>"
" syn match asmcfDirective "\<\.globa\?l\>"
" syn match asmcfDirective "\<IDNT\>"
" syn match asmcfDirective "\<\(NO\)\=LIST\>"
" syn match asmcfDirective "\<LLEN\s"
" syn match asmcfDirective "\<MASK2\>"
" syn match asmcfDirective "\<NAME\s"
" syn match asmcfDirective "\<NOOBJ\>"
" syn match asmcfDirective "\<OFFSET\s"
" syn match asmcfDirective "\<OPT\>"
" syn match asmcfDirective "\<ORG\(\.[SL]\)\=\>"
" syn match asmcfDirective "\<\(NO\)\=PAGE\>"
" syn match asmcfDirective "\<PLEN\s"
" syn match asmcfDirective "\<REG\s"
" syn match asmcfDirective "\<RESTORE\>"
" syn match asmcfDirective "\<SAVE\>"
" syn match asmcfDirective "\<SECT\(\.S\)\=\s"
" syn match asmcfDirective "\<SECTION\(\.S\)\=\s"
" syn match asmcfDirective "\<SET\s"
" syn match asmcfDirective "\<SPC\s"
" syn match asmcfDirective "\<TTL\s"
" syn match asmcfDirective "\<\.text\>"
" syn match asmcfDirective "\<XCOM\s"
" syn match asmcfDirective "\<XDEF\s"
" syn match asmcfDirective "\<XREF\(\.S\)\=\s"

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
