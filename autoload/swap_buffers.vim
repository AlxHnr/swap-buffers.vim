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

function! swap_buffers#swap(dir) " {{{
  if !has_key(s:directions, a:dir)
    echoerr "swap-buffers.vim: invalid direction: '" . a:dir . "'."
    return
  endif

  let l:prev_winnr = winnr()
  let l:prev_view = winsaveview()
  execute 'normal! ' . s:directions[a:dir]

  if winnr() == l:prev_winnr
    return
  endif

  let l:new_bufnr = bufnr('%')
  let l:new_view = winsaveview()

  execute 'hide buffer ' . winbufnr(l:prev_winnr)
  call winrestview(l:prev_view)
  normal! p

  execute 'hide buffer ' . l:new_bufnr
  call winrestview(l:new_view)
  normal! p
endfunction " }}}
