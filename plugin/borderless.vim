" Maps <C-w>h/j/k/l to switch splits in the given direction
" as usual. But if the direction encounters a border in left (h) or right (l)
" direction, it switches to the previous/next tab instead of doing nothing.
" info: this is heavily inspired by vim-tmux-navigator:
" https://github.com/christoomey/vim-tmux-navigator/

" load borderless only once
if exists("g:loaded_borderless") || v:version < 700
  finish
endif
let g:loaded_borderless = 1

" navigate around...
function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echoerr 'E11: Invalid in cmd-line win; <CR> executes, CTRL-C quits'
  endtry
endfunction

" Navigate and jump to tabs if end is reached
function! s:BorderlessNavigate(direction)
  " Navigate and register if end is reached
  let win_number = winnr()
  call s:VimNavigate(a:direction)
  let last_split = win_number == winnr()

  " jump to tab if end was reached
  if last_split
    if a:direction == 'h'
      execute 'tabprevious'
    elseif a:direction == 'l'
      execute 'tabnext'
    endif
  endif
endfunction

command! BorderlessLeft  call <SID>BorderlessNavigate('h')
command! BorderlessRight call <SID>BorderlessNavigate('l')

" determine whether borderless mappings should be used
function! s:UseBorderlessMappings()
  return !exists("g:borderless_deactivate_mappings") || !g:borderless_deactivate_mappings
endfunction

" use mappings only if they have not been deactivated
if s:UseBorderlessMappings()
  nnoremap <silent> <c-w>h :BorderlessLeft<cr>
  nnoremap <silent> <c-w>l :BorderlessRight<cr>
endif
