" Vundle
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()
" Edit {{{
  Bundle 'autodate.vim'
  Bundle 'smartchr'
  Bundle 'speeddating.vim'
  Bundle 'yanktmp.vim'
  Bundle 'bufexplorer.zip'
  " }}}
" Completion {{{
  Bundle 'Shougo/neocomplcache'
  Bundle 'Shougo/neocomplcache-snippets-complete'
" }}}
" Searching {{{
  Bundle 'eregex.vim'
" }}}
" Programming {{{
  Bundle 'errormarker.vim'
  Bundle 'Source-Explorer-srcexpl.vim'
  Bundle 'taglist.vim'
  Bundle 'The-NERD-tree'
  Bundle 'project.tar.gz'
  Bundle 'thinca/vim-quickrun'
  Bundle 'EasyMotion'
  Bundle 'petdance/vim-perl'
  Bundle 'ywatase/perldoc-vim'
  Bundle 'ywatase/flymake-perl.vim'
  Bundle 'ruby.vim'
  Bundle 'tpope/vim-rails'
" }}}
" Syntax {{{
  Bundle 'JavaScript-syntax'
  Bundle 'jQuery'
  Bundle 'nginx.vim'
  Bundle 'tpope/vim-markdown'
  Bundle 'bbommarito/vim-slim'
  Bundle 'groenewege/vim-less'
  Bundle 'vim-coffee-script'
" }}}
" Utility {{{
  Bundle 'DirDiff.vim'
  Bundle 'Gist.vim'
  Bundle 'fuenor/vim-statusline'
  Bundle 'Lokaltog/vim-powerline'
" }}}
" ColorSchema {{{
  Bundle 'desert256.vim'
" }}}
" Unite {{{
  Bundle 'Shougo/unite.vim'
" }}}
filetype on
