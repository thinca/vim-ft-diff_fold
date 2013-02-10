" Folding setting for diff.
" Version: 0.2.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl fdm< fde<'


if exists('*DiffFold')
  finish
endif

let s:file_pat = '^\%(Index:\|diff\) '
function! DiffFold(lnum)
  let line = getline(a:lnum)
  let next = getline(a:lnum + 1)
  if line =~ '^[-=]\{3} ' && getline(a:lnum - 2) !~# s:file_pat
    return 1
  elseif next =~ '^[-=]\{3} ' && getline(a:lnum - 1) !~# s:file_pat
    return '<1'
  elseif line =~ s:file_pat
    return 1
  elseif next =~ s:file_pat
    return '<1'
  elseif line =~ '^@@ '
    return 2
  elseif next =~ '^@@ '
    return '<2'
  endif
  return '='
endfunction
