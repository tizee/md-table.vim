scriptencoding utf-8

if exists('loaded_mdtable_vim') 
 finish
endif

let g:loaded_mdtable_vim = 1

function! s:draw_header(cols)
  let s:row_line = "|"
  let s:head_line = "|"
  for i in range(0, a:cols)
      let s:row_line = s:row_line .   "     | "
      let s:head_line = s:head_line . " --- | "
  endfor
  let s:failed = append(line('.'),[s:row_line,s:head_line])
endfunction

function! s:draw_row(cols)
  let s:row_line = "|"
  for i in range(0, a:cols)
    let s:row_line = s:row_line .   "     | "
  endfor
  let s:failed = append(line('.'),s:row_line)
endfunction
function! s:create_table(...)
  let args = a:000
  if len(args) > 2
    echom "Only first two arguments would be used as width and height"
    return
  endif 
  let [s:width,s:height] = args
  if s:width <= 0 || s:height <=0
   echoe "Invalid width or height"
   return
  endif 
  for i in range(0, s:height-1)
     call s:draw_row(s:width-1)
  endfor
  call s:draw_header(s:width-1)
endfunction

" width x height
if !exists(":MDTable")
  command! -nargs=+ -bang MDTable call <SID>create_table(<f-args>)
endif 
