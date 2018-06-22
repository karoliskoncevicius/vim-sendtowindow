function! s:SendToWindow(type, direction)
  let s:saved_register=@@
  let s:saved_registerK=@k
  " Obtain wanted text
  if a:type == 'v' || a:type=='V' || a:type=="\<C-V>"
    normal! `<v`>y
  elseif a:type ==# "char"
    normal! `[v`]y
  elseif a:type ==# "line"
    normal! `[V`]$y
  endif
  " Was the cursor at the end of line?
  call setpos(".", getpos("'>"))
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif
  " Go to the wanted split
  execute "wincmd " . a:direction
  " Insert text
  normal! gp
  " Ammend end of line charater based on buffer type
  if &buftype ==# "terminal"
    let @k="\r"
    normal! "kp
  elseif s:endofline
    let @k="\n"
    normal! "kp
  endif
  wincmd p
  " Position the cursor for the next action
  if s:endofline
    normal! j0
  elseif a:type ==# "char"
    normal! l
  endif
  " Restore register
  let @@=s:saved_register
  let @k=s:saved_registerK
endfunction

function! s:SendRight(type)
  call s:SendToWindow(a:type, 'l')
endfunction
function! s:SendLeft(type)
  call s:SendToWindow(a:type, 'h')
endfunction
function! s:SendUp(type)
  call s:SendToWindow(a:type, 'k')
endfunction
function! s:SendDown(type)
  call s:SendToWindow(a:type, 'j')
endfunction

nnoremap <silent> <Plug>SendUp    :<C-U> set operatorfunc=<SID>SendUp<CR>g@
nnoremap <silent> <Plug>SendDown  :<C-U> set operatorfunc=<SID>SendDown<CR>g@
nnoremap <silent> <Plug>SendRight :<C-U> set operatorfunc=<SID>SendRight<CR>g@
nnoremap <silent> <Plug>SendLeft  :<C-U> set operatorfunc=<SID>SendLeft<CR>g@

vnoremap <silent> <Plug>SendUpV    :<C-U> call <SID>SendUp(visualmode())<CR>
vnoremap <silent> <Plug>SendDownV  :<C-U> call <SID>SendDown(visualmode())<CR>
vnoremap <silent> <Plug>SendRightV :<C-U> call <SID>SendRight(visualmode())<CR>
vnoremap <silent> <Plug>SendLeftV  :<C-U> call <SID>SendLeft(visualmode())<CR>

if !exists("g:sendtowindow_use_defaults") || g:sendtowindow_use_defaults
  nmap <c-l> <Plug>SendRight
  xmap <c-l> <Plug>SendRightV
  nmap <c-h> <Plug>SendLeft
  xmap <c-h> <Plug>SendLeftV
  nmap <c-k> <Plug>SendUp
  xmap <c-k> <Plug>SendUpV
  nmap <c-j> <Plug>SendDown
  xmap <c-j> <Plug>SendDownV
endif

