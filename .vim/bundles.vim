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
  Bundle 'Shougo/neosnippet'
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
  Bundle 'vim-ruby/vim-ruby'
  Bundle 'tpope/vim-bundler'
  Bundle 'tpope/vim-rails'
  Bundle 'mitechie/pyflakes-pathogen'
  Bundle 'nvie/vim-flake8'
  Bundle 'lua-support'
" }}}
" Syntax {{{
  Bundle 'JavaScript-syntax'
  Bundle 'jQuery'
  Bundle 'nginx.vim'
  Bundle 'nagios-syntax'
  Bundle 'tpope/vim-markdown'
  Bundle 'RST-Tables-CJK'
  Bundle 'slim-template/vim-slim'
  Bundle 'groenewege/vim-less'
  Bundle 'vim-coffee-script'
" }}}
" Utility {{{
  Bundle 'DirDiff.vim'
  Bundle 'mattn/webapi-vim'
  Bundle 'mattn/gist-vim'
  Bundle 'fuenor/vim-statusline'
  Bundle 'Lokaltog/powerline'
  Bundle 'mattn/webapi-vim'
  Bundle 'mattn/mkdpreview-vim'
" }}}
" ColorSchema {{{
  Bundle 'desert256.vim'
" }}}
" Unite {{{
  Bundle 'Shougo/unite.vim'
" }}}
filetype on
