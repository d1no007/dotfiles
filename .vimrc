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
call vundle#end()
filetype indent plugin on

"line length and numbering
set textwidth=80
set number

"4-space tabs and indents 
set expandtab 
set tabstop=2
set shiftwidth=2
set autoindent

"enable color 
syntax on
