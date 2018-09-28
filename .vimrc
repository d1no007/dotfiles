set nocompatible
filetype off 

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"vundle plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'junegunn/goyo.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'altercation/vim-colors-solarized'
Plugin 'gsiano/vmux-clipboard'
Plugin 'hashivim/vim-terraform'
Plugin 'ekalinin/Dockerfile.vim'
call vundle#end()
filetype indent plugin on

"terraform syntax
let g:terraform_align=1

"compiler settings for leafgarland/typescript-vim
let g:typescript_compiler_binary='./node_modules/typescript/bin/tsc'

"auto-pairs
let g:AutoPairsFlyMode=1  
let g:AutoPairsShortcutBackInsert='<C-b>'

"line length and numbering
set textwidth=120 
set number
set fo-=l

"4-space tabs and indents 
set expandtab 
set tabstop=2
set shiftwidth=2
set autoindent

"aesthetic
syntax enable 
set background=light
colorscheme solarized

"remove trailing whitespace
fun! TrimWhitespace()
    let l:save=winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
