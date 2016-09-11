let g:sendtosplit_use_defaults=1

function! s:SendToSplit(type, direction)
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
  if s:endofline
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
  elseif a:type ==# "char"
    normal! l
  endif
  " Restore register
  let @@=s:saved_register
  let @k=s:saved_registerK
endfunction

function! s:SendSplitRight(type)
  call s:SendToSplit(a:type, 'l')
endfunction
function! s:SendSplitLeft(type)
  call s:SendToSplit(a:type, 'h')
endfunction
function! s:SendSplitUp(type)
  call s:SendToSplit(a:type, 'k')
endfunction
function! s:SendSplitDown(type)
  call s:SendToSplit(a:type, 'j')
endfunction

nnoremap <silent> <Plug>SendUp    :<C-U> set operatorfunc=<SID>SendSplitUp<CR>g@
nnoremap <silent> <Plug>SendDown  :<C-U> set operatorfunc=<SID>SendSplitDown<CR>g@
nnoremap <silent> <Plug>SendRight :<C-U> set operatorfunc=<SID>SendSplitRight<CR>g@
nnoremap <silent> <Plug>SendLeft  :<C-U> set operatorfunc=<SID>SendSplitLeft<CR>g@

vnoremap <silent> <Plug>SendUpV    :<C-U> call <SID>SendSplitUp(visualmode())<CR>
vnoremap <silent> <Plug>SendDownV   :<C-U> call <SID>SendSplitDown(visualmode())<CR>
vnoremap <silent> <Plug>SendRightV :<C-U> call <SID>SendSplitRight(visualmode())<CR>
vnoremap <silent> <Plug>SendLeftV  :<C-U> call <SID>SendSplitLeft(visualmode())<CR>

if g:sendtosplit_use_defaults
  nmap <c-l> <Plug>SendRight
  xmap <c-l> <Plug>SendRightV
  nmap <c-h> <Plug>SendLeft
  xmap <c-h> <Plug>SendLeftV
  nmap <c-k> <Plug>SendUp
  xmap <c-k> <Plug>SendUpV
  nmap <c-j> <Plug>SendDown
  xmap <c-j> <Plug>SendDownV
endif

