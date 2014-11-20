" Copyright (c) 2014 Alexander Heinrich <alxhnr@nudelpost.de> {{{
"
" This software is provided 'as-is', without any express or implied
" warranty. In no event will the authors be held liable for any damages
" arising from the use of this software.
"
" Permission is granted to anyone to use this software for any purpose,
" including commercial applications, and to alter it and redistribute it
" freely, subject to the following restrictions:
"
"    1. The origin of this software must not be misrepresented; you must
"       not claim that you wrote the original software. If you use this
"       software in a product, an acknowledgment in the product
"       documentation would be appreciated but is not required.
"
"    2. Altered source versions must be plainly marked as such, and must
"       not be misrepresented as being the original software.
"
"    3. This notice may not be removed or altered from any source
"       distribution.
" }}}

if !has('windows')
  echomsg 'swap-buffers.vim: your Vim has no support for windows.'
  finish
endif

let s:directions = { 'left': 'h', 'down': 'j', 'up': 'k', 'right': 'l' }

" Sets various local variables in the current buffer, and returns a
" dictionary which can be used to restore these variables again. See
" 's:restore_buffer()'.
function! s:prepare_buffer() " {{{
  let l:restore_info =
    \ {
    \   'bufnr'         : bufnr('%'),
    \   'bufhidden'     : &l:bufhidden,
    \   'number'        : &l:number,
    \   'previewwindow' : &l:previewwindow,
    \   'winview'       : winsaveview(),
    \ }
  setlocal bufhidden=
  setlocal nopreviewwindow
  return l:restore_info
endfunction " }}}

" The counterpart to 's:prepare_buffer()'. Takes a dictionary as argument
" and restores various local variables.
function! s:restore_buffer(info) " {{{
  execute 'hide buffer ' . a:info['bufnr']
  execute 'setlocal bufhidden=' . a:info['bufhidden']
  execute 'let &l:number=' . a:info['number']
  execute 'let &l:previewwindow=' . a:info['previewwindow']
  call winrestview(a:info['winview'])

  if a:info['previewwindow']
    echo bufname(a:info['bufnr']) . ' is a preview window'
  endif
endfunction " }}}

function! swap_buffers#swap(dir) " {{{
  if !has_key(s:directions, a:dir)
    echoerr "swap-buffers.vim: invalid direction: '" . a:dir . "'."
    return
  endif

  let l:prev_winnr = winnr()
  let l:prev_info = s:prepare_buffer()
  execute 'normal! ' . s:directions[a:dir]

  " Return if there is no neighbor window.
  if winnr() == l:prev_winnr
    call s:restore_buffer(l:prev_info)
    return
  endif

  let l:next_info = s:prepare_buffer()
  call s:restore_buffer(l:prev_info)
  normal! p
  call s:restore_buffer(l:next_info)
  normal! p
endfunction " }}}
