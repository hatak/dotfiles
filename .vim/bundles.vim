" Vundle
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()
" Edit {{{
  Bundle 'autodate.vim'
  Bundle 'smartchr'
  Bundle 'speeddating.vim'
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
  Bundle 'project.tar.gz'
  Bundle 'taglist.vim'
  Bundle 'thinca/vim-quickrun'
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
