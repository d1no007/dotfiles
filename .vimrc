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
Plugin 'avakhov/vim-yaml'
Plugin 'junegunn/fzf.vim'
call vundle#end()
filetype indent plugin on

"ripgrep find
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

"enable fzf within vim
"must be installed with brew
set rtp+=/usr/local/opt/fzf

"terraform syntax
let g:terraform_align=1

"compiler settings for leafgarland/typescript-vim
let g:typescript_compiler_binary='./node_modules/typescript/bin/tsc'

"auto-pairs
let g:AutoPairsFlyMode=1  
let g:AutoPairsShortcutBackInsert='<C-b>'

"line length and numbering
set textwidth=80
set number
set fo-=l

"scroll when there are 10 rows before bottom or top of screen
set scrolloff=10

"wrap markdown
au BufRead,BufNewFile *.md setlocal textwidth=120

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
