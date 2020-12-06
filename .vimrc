"Vundle compatibility
set nocompatible
filetype off

"set the runtime path to include Vundle and initialize 
set rtp+=~/.vim/bundle/Vundle.vim

"Vundle plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'lifepillar/vim-mucomplete'
call vundle#end()
filetype indent plugin on

"line length and numbering
set textwidth=80
set fo-=l

"completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c   "shut off completion messages
set belloff+=ctrlg "if Vim beeps during completion

" enable automatic completion at startup
let g:mucomplete#enable_auto_at_startup = 1

"yanks to system clipboard
"paste with `p` or `cmd-v`
set clipboard=unnamed

"scroll when there are 10 rows before bottom or top of screen
set scrolloff=10

"wrap markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

"2-space tabs and indents
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

"2-space YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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
