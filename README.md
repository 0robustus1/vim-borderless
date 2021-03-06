# borderless

This plugin was created to allow the vim user to move
across *borders*. Usually when you move around in your
splits and you hit the wall of your actual *terminal* or
*gui* window, vim just stops and does nothing. Wouldn't
it be nice, to just move to the next or previous tab
instead of rethinking and using your `:tabn`/`:tabp`
keybindings?

borderless does just that...

## How it works

The standard way to move around splits in vim
is analogue to the *h/j/k/l* pattern:

- `<Ctrl-w>h` to move left
- `<Ctrl-w>j` to move down
- `<Ctrl-w>k` to move up
- `<Ctrl-w>l` to move right

Borderless just extends their functionality by allowing
`<Ctrl-w>h` and `<Ctrl-w>l` to move to the previous
or next tab, if there is no split left to move to in the
specified direction.

For lack of other use (currently), `<Ctrl-w>j` maps
to the first tabpage (unless there is a split to navigate to)
and `<Ctrl-w>k` maps to the last tabpage.

When actually moving to another tab through these mappings,
you should jump to a sensible/natural location in the resulting
tab.

This means that, when moving from a tab to the lefthand tab
(`<Ctrl-w>h`) you shall land on the righthand window
(and also to the *bottom* when windows are additionally horizontally stacked).

And when moving from a tab to the righthand tab (`<Ctrl-w>l`)
you shall land on the lefthand window
(and also to the *top* when windows are additionally horizontally stacked).

## Configure

borderless should work out of the box, and if you use
a vim plugin manager like [pathogen][1] or [vundle][2]
it should be quite easy to install.

But if you don't like the default keybindings (and don't
want to use the mappings you use instead) you can configure
borderless by placing specific settings in you **.vimrc**.

- `let g:borderless_deactivate_mappings = 1`  
  will deactivate the default mappings.

To configure everything yourself you can use these commands
instead:

- `:BorderlessLeft`
- `:BorderlessDown`
- `:BorderlessUp`
- `:BorderlessRight`


[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/gmarik/vundle
