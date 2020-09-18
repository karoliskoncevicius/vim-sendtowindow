# vim-sendtowindow

Vim operator to send text from one window to another.

Main use case is sending code to and from the REPL running inside `:terminal` buffer.

## Demo ##

1. Sending lines using motions

![demo1](https://i.imgur.com/qsB11um.gif)

2. Sending parts of a line using motions

![demo2](https://i.imgur.com/wSzV7nV.gif)

3. Sending paragraphs using text objects

![demo3](https://i.imgur.com/gmJ6mow.gif)

4. Sending text using visual selections

![demo4](https://i.imgur.com/mp6F160.gif)

5. Sending commands back - from REPL to script

![demo5](https://i.imgur.com/jhEcq7g.gif)

## Installation ##

With your favorite plugin manager. In my case it's vim-plug:

`Plug 'karoliskoncevicius/vim-sendtowindow'`

Or manually copy the contents of the **plugin** folder to your
**./vim/plugin/** directory.

## Features ##

* Can send text between any two adjacent vim windows.
* Text can be defined by visual selection, motions and text objects.
* Tries to position the cursor in a convenient place after each call.
* Dot repeatable.

## Maps ##

By default it uses the following maps:

* `<space>l` sends to the right window
* `<space>k` sends to the top window
* `<space>j` sends to the bottom window
* `<space>h` sends to the left window

In order to change the above key maps add the following to your *vimrc*:

    let g:sendtowindow_use_defaults=0

And then remap the commands as you see fit.
For example this would map all the commands to L, H, K and J respectively:

    nmap L <Plug>SendRight
    xmap L <Plug>SendRightV
    nmap H <Plug>SendLeft
    xmap H <Plug>SendLeftV
    nmap K <Plug>SendUp
    xmap K <Plug>SendUpV
    nmap J <Plug>SendDown
    xmap J <Plug>SendDownV

## See Also ##

If instead you are looking for a plugin with more features and auto-magic, here is a list to choose from:

- [jpalardy/vim-slime](https://github.com/jpalardy/vim-slime)
- [jgdavey/tslime.vim](https://github.com/jgdavey/tslime.vim)
- [Vigemus/iron.nvim](https://github.com/Vigemus/iron.nvim)
- [kassio/neoterm](https://github.com/kassio/neoterm)
- [benmills/vimux](https://github.com/benmills/vimux)
- [esamattis/slimux](https://github.com/esamattis/slimux)
- [jebaum/vim-tmuxify](https://github.com/jebaum/vim-tmuxify)
- [ervandew/screen](https://github.com/ervandew/screen)
- [sillybun/vim-repl](https://github.com/sillybun/vim-repl)
- [khorser/vim-repl](https://github.com/khorser/vim-repl)
- [rhysd/reply.vim](https://github.com/rhysd/reply.vim)
- [habamax/vim-sendtoterm](https://github.com/habamax/vim-sendtoterm)
- [urbainvaes/vim-ripple](https://github.com/urbainvaes/vim-ripple)
- [axvr/zepl.vim](https://github.com/axvr/zepl.vim)

