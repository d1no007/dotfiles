"Vundle compatibility
set nocompatible
filetype off

"yanks to system clipboard
"paste with `p` or `cmd-v`
set clipboard=unnamed

"set the runtime path to include Vundle and initialize 
set rtp+=~/.vim/bundle/Vundle.vim

"Vundle plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype indent plugin on

"line length and numbering
set textwidth=80
set number
set fo-=l

"scroll when there are 10 rows before bottom or top of screen
set scrolloff=10

"wrap markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

"4-space tabs and indents
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

"aesthetic
syntax enable
colorscheme default

"remove trailing whitespace
fun! TrimWhitespace()
    let l:save=winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

"2-space YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
