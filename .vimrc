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
call vundle#end()
filetype indent plugin on

"auto-pairs
let g:AutoPairsFlyMode = 1  
let g:AutoPairsShortcutBackInsert = '<C-b>'

"line length and numbering
set textwidth=80
set number
set fo-=l

"4-space tabs and indents 
set expandtab 
set tabstop=2
set shiftwidth=2
set autoindent

"aesethetic
syntax enable 
set background=dark
colorscheme solarized
