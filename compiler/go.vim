" Copyright 2013 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" compiler/go.vim: Vim compiler file for Go.

if exists("current_compiler")
  finish
endif
let current_compiler = "go"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C
if filereadable("makefile") || filereadable("Makefile")
    CompilerSet makeprg=make
else
    CompilerSet makeprg=go\ build
endif

" Define the patterns that will be recognized by QuickFix when parsing the output of GoRun.
" More information at http://vimdoc.sourceforge.net/htmldoc/quickfix.html#errorformat
CompilerSet errorformat =%-G#\ %.%#                   " Ignore lines beginning with '#' ('# command-line-arguments' line sometimes appears?)
CompilerSet errorformat+=%-G%.%#panic:\ %m            " Ignore lines containing 'panic: message'
CompilerSet errorformat+=%Ecan\'t\ load\ package:\ %m " Start of multiline error string is 'can\'t load package'
CompilerSet errorformat+=%A%f:%l:%c:\ %m              " Start of multiline unspecified string is 'filename:linenumber:columnnumber:'
CompilerSet errorformat+=%A%f:%l:\ %m                 " Start of multiline unspecified string is 'filename:linenumber:'
CompilerSet errorformat+=%C%*\\s%m                    " Continuation of multiline error message is indented
CompilerSet errorformat+=%-G%.%#                      " All lines not matching any of the above patterns are ignored

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:ts=4:sw=4:et
