# swap-buffers.vim

This Vim plugin provides a function to swap the current buffer with the
buffer in the neighbor window.

### swap\_buffers#swap(direction)

This function takes either "left", "right", "up" or "down" as argument.

Here is an example, which maps this function to meta-shift and one of the
direction keys:

```vim
nnoremap <silent> <Esc>H :call swap_buffers#swap('left')<CR>
nnoremap <silent> <Esc>J :call swap_buffers#swap('down')<CR>
nnoremap <silent> <Esc>L :call swap_buffers#swap('right')<CR>
nnoremap <silent> <Esc>K :call swap_buffers#swap('up')<CR>
```

## License

Released under the zlib license.
