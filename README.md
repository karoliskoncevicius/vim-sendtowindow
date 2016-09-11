# vim-sendtosplit

Vim operator used to send text from one window split to another.

Main use case is sending code to and from the NeoVim's `:terminal` buffer.

## Installation ##

With your favorite plugin manager. In my case it's vim-plug:

`Plug 'KKPMW/vim-sendtosplit'`

Or manualluy copy the contents of the **plugin** folder to your
**./vim/plugin/** directory.

## Features ##

* Text can be defined by motions and text objects
* Tries to position the cursor in a convenient place after each call.
* Dot repeatable.

