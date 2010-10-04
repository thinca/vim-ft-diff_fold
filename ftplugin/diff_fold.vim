setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)

function! DiffFold(lnum)
  let line = getline(a:lnum)
  let next = getline(a:lnum + 1)
  if line =~ '^[-=]\{3}'
    return 1
  elseif next =~ '^[-=]\{3}'
    return '<1'
  elseif line =~ '^@@'
    return 2
  elseif next =~ '^@@'
    return '<2'
  endif
  return '='
endfunction


if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl fdm< fde<'
