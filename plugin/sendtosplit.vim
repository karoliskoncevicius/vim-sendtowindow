let g:sendtosplit_defaults=1

function! s:SendDirection(type, direction)
  let s:saved_register=@@
  let s:saved_registerK=@k
  " Obtain wanted text
  if a:type == 'v' || a:type=='V' || a:type=="\<C-V>"
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  elseif a:type ==# 'line'
    normal! `[V`]$y
  endif
  " Was the cursor at the end of line?
  normal! gv\<c-\>\<c-n>
  let s:endofline = 0
  if col(".") >= col("$")-1
    let s:endofline = 1
  endif
  " Go to the wanted split
  execute "wincmd " . a:direction
  " Insert text
  normal! gp
  " Ammend end of line charater based on buffer type
  if s:endofline && a:type ==# "char"
    if &buftype ==# "terminal"
      let @k="\r"
    else
      let @k="\n"
    endif
    normal! "kp
  endif
  wincmd p
  " Position the cursor for the next action
  if s:endofline
    normal! j0
  elseif a:type ==# 'char'
    normal! l
  endif
  " restore register
  let @@=s:saved_register
  let @k=s:saved_registerK
endfunction

function! s:SendRightOp(type)
  call s:SendDirection(a:type, 'l')
endfunction
function! s:SendLeftOp(type)
  call s:SendDirection(a:type, 'h')
endfunction
function! s:SendUpOp(type)
  call s:SendDirection(a:type, 'k')
endfunction
function! s:SendDownOp(type)
  call s:SendDirection(a:type, 'j')
endfunction

if g:sendtosplit_defaults
  nnoremap <silent> <c-l> :set operatorfunc=<sid>SendRightOp<CR>g@
  vnoremap <silent> <c-l> :<C-U>call <sid>SendRightOp(visualmode())<CR>
  nnoremap <silent> <c-h> :set operatorfunc=<sid>SendLeftOp<CR>g@
  vnoremap <silent> <c-h> :<C-U>call <sid>SendLeftOp(visualmode())<CR>
  nnoremap <silent> <c-k> :set operatorfunc=<sid>SendUpOp<CR>g@
  vnoremap <silent> <c-k> :<C-U>call <sid>SendUpOp(visualmode())<CR>
  nnoremap <silent> <c-j> :set operatorfunc=<sid>SendDownOp<CR>g@
  vnoremap <silent> <c-j> :<C-U>call <sid>SendDownOp(visualmode())<CR>
endif

