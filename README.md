# vim-sendtowindow

Vim operator to send text from one window to another.

Main use case is sending code to and from the REPL running inside `:terminal` buffer.

## Demo ##

1. Sending lines

![demo1](https://i.imgur.com/qsB11um.gif)

## Installation ##

With your favorite plugin manager. In my case it's vim-plug:

`Plug 'KKPMW/vim-sendtowindow'`

Or manually copy the contents of the **plugin** folder to your
**./vim/plugin/** directory.

## Features ##

* Text can be defined by motions and text objects
* Tries to position the cursor in a convenient place after each call.
* Dot repeatable.

## Maps ##

By default it uses the following maps:

* `<space>l` sends to the left window
* `<space>k` sends to the top window
* `<space>j` sends to the bottom window
* `<space>h` sends to the right window

In order to change the above key maps add the following to you *vimrc*:

    let g:sendtowindow_use_defaults=0
    nmap L <Plug>SendRight
    xmap L <Plug>SendRightV
    nmap H <Plug>SendLeft
    xmap H <Plug>SendLeftV
    nmap K <Plug>SendUp
    xmap K <Plug>SendUpV
    nmap J <Plug>SendDown
    xmap J <Plug>SendDownV

This would map all the commands to L, H, K and J respectively.

