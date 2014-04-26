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
      call s:JumpToLastWindow()
    elseif a:direction == 'j'
      execute 'tabfirst'
      call s:JumpToFirstWindow()
    elseif a:direction == 'k'
      execute 'tablast'
      call s:JumpToLastWindow()
    elseif a:direction == 'l'
      execute 'tabnext'
      call s:JumpToFirstWindow()
    endif
  endif
endfunction

" Jumps to the first window of the tab,
" where first window is the one in the
" top left corner.
function! s:JumpToFirstWindow()
  let first_window_number=1
  call s:JumpToWindowNr(first_window_number)
endfunction

" Jumps to the last window of the tab,
" where last window is the one in the
" bottom right corner.
function! s:JumpToLastWindow()
  let last_window_number = winnr('$')
  call s:JumpToWindowNr(last_window_number)
endfunction

function! s:JumpToWindowNr(nr)
  execute a:nr . "wincmd w"
endfunction

command! BorderlessLeft  call <SID>BorderlessNavigate('h')
command! BorderlessDown  call <SID>BorderlessNavigate('j')
command! BorderlessUp    call <SID>BorderlessNavigate('k')
command! BorderlessRight call <SID>BorderlessNavigate('l')

" determine whether borderless mappings should be used
function! s:UseBorderlessMappings()
  return !exists("g:borderless_deactivate_mappings") || !g:borderless_deactivate_mappings
endfunction

" use mappings only if they have not been deactivated
if s:UseBorderlessMappings()
  nnoremap <silent> <c-w>h :BorderlessLeft<cr>
  nnoremap <silent> <c-w>j :BorderlessDown<cr>
  nnoremap <silent> <c-w>k :BorderlessUp<cr>
  nnoremap <silent> <c-w>l :BorderlessRight<cr>
endif
