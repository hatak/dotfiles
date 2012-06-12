" ========== Basic  settings ========== "
scriptencoding urf-8

source <sfile>:h/.vim/bundles.vim

" General
set nocompatible     " running Vim mode
set viminfo+=!       " add '!' for YankRing plugin
set shellslash       " to use '/' for path delimiter in Windows
set modeline         " use modeline mode

" Tab character
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab   " use space instead of tab
set smartindent " smart indent

" Input support
set backspace=indent,eol,start " to delete everything with backspace key
set formatoptions+=m           " add multibyte support

" Command completion
set wildmenu                   " enhance command completion
set wildmode=list:longest,full " first 'list:lingest' and second 'full'

" Searching
set wrapscan   " search wrap around the end of the file
set ignorecase " ignore case
set smartcase  " override 'ignorecase' if the search pattern contains upper case
set incsearch  " incremental search
set hlsearch   " highlight searched words

" Reading and writing file
set nobackup   " don't backup
set autoread   " auto reload when file rewrite other application
set noswapfile " don't use swap file

" Display
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set wrap              " 画面幅で折り返す
set list              " 不可視文字表示
set listchars=tab:>\  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り
set nolinebreak       " 改行しない
set textwidth=0       " 改行しない

" カレントウィンドウのみラインを引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

" Folding
set foldmethod=marker
" 行頭でhを押すと折りたたみを閉じる
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" 折りたたみ上でlを押すと折りたたみを開く
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo' : 'l'
" 行頭でhを押すと選択範囲に含まれる折りたたみを閉じる
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" 折りたたみ上でlを押すと選択範囲に含まれる折りたたみを開く
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv' : 'l'

" Status line
set laststatus=2
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m

" File encoding
if has('mac')
    set encoding=utf-8
elseif has('win32')
    set encoding=japan
endif
set fileencodings=utf-8,euc-jp,cp932

" File Formats
set ffs=unix,dos,mac

" For multibyte characters, such as □, ○
set ambiwidth=double

" File type
syntax on " syntax coloring

" Highlight Zenkaku space
augroup highlightIdegraphicSpace
    autocmd!
    autocmd ColorScheme * highlight IdeoGraphicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" Highlight Hankaku space
augroup highlightWhitespaceEOL
    autocmd!
    autocmd ColorScheme * highlight WhitespaceEOL term=underline ctermbg=red guibg=red
    autocmd VimEnter,WinEnter * match WhitespaceEOL /\s\+$/
augroup END


set complete+=k    " to use dictionary for completion
filetype indent on " to use filetype indent
filetype plugin on " to use filetype plugin

"コンパイラの指定
autocmd FileType perl,cgi :compiler perl

" Dictionary
augroup Dictionary
    autocmd! Dictionary
    autocmd FileType php setlocal dictionary+=~/.vim/dict/php_functions.dict
    autocmd FileType perl setlocal dictionary+=~/.vim/dict/perl_functions.dict
augroup END

" Omni completion
set completeopt+=menuone " 補完表示設定

" TabでOmni補完及びポップアップメニューの選択
inoremap <silent> <expr> <CR> (pumvisible() ? "\<C-e>" : "") . "\<CR>"
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" color schema
colorscheme elflord

" ポップアップメニューの色変える
highlight Pmenu ctermbg=lightcyan ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=black
highlight PmenuSbar ctermbg=darkgray
highlight PmenuThumb ctermbg=lightgray

" Disable input methods
set iminsert=0
set imsearch=0

" help
set helplang=ja

" ========== KeyMap settings ========== "
" ==================== キーマップ ==================== "
" 表示行単位で移動
nnoremap j  gj
nnoremap k  gk
nnoremap gj j
nnoremap gk k
nnoremap 0  g0
nnoremap g0 0
nnoremap $  g$
nnoremap g$ $

vnoremap j  gj
vnoremap k  gk
vnoremap gj j
vnoremap gk k
vnoremap 0  g0
vnoremap g0 0
vnoremap $  g$
vnoremap g$ $

" Delete highlight
nnoremap <silent> gh :nohlsearch<CR>

" Expand path
cnoremap <expr> <C-x> expand('%:p:h') . "/"
cnoremap <expr> <C-z> expand('%:p:r')

" Copy and paste
" Command-C and Command-V are also available in MacVim
" Reference:
" http://subtech.g.hatena.ne.jp/cho45/20061010/1160459376
" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
"
" need  'set enc=utf-8' and
" below environment variable for UTF-8 characters
" export __CF_USER_TEXT_ENCODING='0x1F5:0x08000100:14'
"
" Vim(Mac)
if has('mac') && !has('gui')
    nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
    vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
    nnoremap <silent> <Space>p :r !pbpaste<CR>
    vnoremap <silent> <Space>p :r !pbpaste<CR>
" GVim(Mac & Win)
else
    noremap <Space>y "+y
    noremap <Space>p "+p
endif

" Enable mouse wheel
" In Mac, Only on iTerm.app, disable on Terminal.app
if has('mac')
    set mouse=a
    set ttymouse=xterm2
endif

" Binary (see :h xxd)
" vim -b :edit binary using xxd-format!
" reference: http://jarp.does.notwork.org/diary/200606a.html#200606021
augroup Binary
    autocmd! Binary
    autocmd BufReadPre   *.bin,*.swf let &bin=1
    autocmd BufReadPost  *.bin,*.swf if &bin | silent %!xxd -g 1
    autocmd BufReadPost  *.bin,*.swf set ft=xxd | endif
    autocmd BufWritePre  *.bin,*.swf if &bin | %!xxd -r
    autocmd BufWritePre  *.bin,*.swf endif
    autocmd BufWritePost *.bin,*.swf if &bin | silent %!xxd -g 1
    autocmd BufWritePost *.bin,*.swf set nomod | endif
augroup END

" ========== Plugin settings ========== "

" insert-statusline.vim
let hi_insert = 'hi StatusLine guifg=White guibg=DarkRed gui=none ctermfg=White ctermbg=DarkRed cterm=none'

" 拡張子設定
augroup filetypedetect
    au! BufRead,BufNewFile *.tt     setfiletype html.tt
    au! BufRead,BufNewFile *.tt2    setfiletype html.tt
    au! BufRead,BufNewFile *.psgi   setfiletype perl
    au! BufRead,BufNewFile *.ddl    setfiletype sql
augroup END

" autodate.vim
let autodate_keyword_pre    = "Last Change:  "
let autodate_keyword_post   = "."
let autodate_format         = "%Y/%m/%d %H:%M:%S "

" project.vim
" If you select a file, close the window immediately.
let g:proj_flags = "imstc"
" Toggle Project with \P key.
nmap <silent> <Leader>P <Plug>ToggleProject
" Open default Project with \p key.
nmap <silent> <Leader>p :Project<CR>
" Expand the folding when opened project.
autocmd BufAdd .vimprojects silent! %foldopen!

" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
let g:NeoComplCache_SnippetsDir = $HOME.'/.vim/snippets'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"inoremap <expr> = smartchr#loop(' = ', '=', ' == ')

" java
augroup Java
    autocmd FileType java setlocal tabstop=4 noexpandtab
augroup END

" Ruby
augroup Ruby
    autocmd! Ruby
    autocmd FileType ruby,eruby,yaml setlocal softtabstop=2 shiftwidth=2 tabstop=2
augroup END

" dbext
let dbext_default_profile=""
let dbext_default_type="MYSQL"
let dbext_default_user="root"
let dbext_default_passwd=""
let dbext_default_dbname=""
let dbext_default_host="localhost"
let dbext_default_buffer_lines=20

" ========== Load local settings ========== "

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
