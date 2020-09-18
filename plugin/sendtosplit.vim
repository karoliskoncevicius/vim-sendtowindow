" vim-sendtowindow - Operator for sending text to adjacent windows.
" Maintainer: Karolis Koncevičius (karolis.koncevicius@gmail.com)
" Website: https://github.com/karoliskoncevicius/vim-sendtowindow


if exists("g:loaded_sendtowindow") || &compatible
  finish
endif
let g:loaded_sendtowindow = 1


function! s:SendToWindow(type, direction)

  let s:saved_register = @@
  let s:saved_registerK = @k
  let s:saved_pos = getpos(".")

  " Obtain wanted text
  if a:type == 'v' || a:type == 'V' || a:type == "\<C-V>"
    keepjumps normal! `<v`>y
    if a:type == 'V'
      let @@ = substitute(@@, '\n$', '', '')
    endif
    call setpos(".", getpos("'>"))
  elseif a:type ==# "char"
    keepjumps normal! `[v`]y
    call setpos(".", getpos("']"))
  elseif a:type ==# "line"
    keepjumps normal! `[V`]$y
    call setpos(".", getpos("']"))
  endif

  " Was the cursor at the end of line?
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif

  " Go to the wanted split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    call setpos(".", s:saved_pos)
    return
  endif

  " Insert text and ammend end of line charater based on buffer type
  if &buftype ==# "terminal"
    let @k = "\r"
    if has('nvim')
      normal! gp
      normal! "kp
    else
      call term_sendkeys('', @0)
      call term_sendkeys('', "\r")
    endif
  elseif s:endofline
    normal! gp
    let @k = "\n"
    normal! "kp
  else
    normal! gp
  endif
  wincmd p

  " Position the cursor for the next action
  if s:endofline
    normal! j0
  elseif a:type ==# "char"
    normal! l
  endif

  " Restore register
  let @@ = s:saved_register
  let @k = s:saved_registerK

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
  nmap <space>l <Plug>SendRight
  xmap <space>l <Plug>SendRightV
  nmap <space>h <Plug>SendLeft
  xmap <space>h <Plug>SendLeftV
  nmap <space>k <Plug>SendUp
  xmap <space>k <Plug>SendUpV
  nmap <space>j <Plug>SendDown
  xmap <space>j <Plug>SendDownV
endif

