# swap-buffers.vim

This Vim plugin provides a function to swap the current buffer with the
buffer in a neighbor window: **swap\_buffers#swap()**. It takes exactly one
argument, which must be either "left", "right", "up" or "down".

Here is an example, which maps this function to control and one of the
direction keys.

```vim
nnoremap <silent> <C-h> :call swap_buffers#swap('left')<CR>
nnoremap <silent> <C-j> :call swap_buffers#swap('down')<CR>
nnoremap <silent> <C-k> :call swap_buffers#swap('up')<CR>
nnoremap <silent> <C-l> :call swap_buffers#swap('right')<CR>
```

## License

Released under the zlib license.
