" ========== Basic  settings ========== "
scriptencoding utf-8

source <sfile>:h/.vim/bundles.vim

" General
set nocompatible        " running Vim mode
set viminfo+=!          " add '!' for YankRing plugin
set shellslash          " to use '/' for path delimiter in Windows
set modeline            " use modeline mode
"set clipboard+=unnamed  " share clipboard
"set clipboard+=autoselect
set vb t_vb=                     " ビープをならさない
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする

" Tab character
set expandtab       " use space instead of tab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set smartindent

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
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

set termencoding=utf-8
set encoding=utf8

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

filetype indent on " to use filetype indent
filetype plugin on " to use filetype plugin

" color schema
set t_Co=256
colorscheme desert256

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

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" ========== Plugin settings ========== "
" 拡張子設定
augroup filetypedetect
    au! BufRead,BufNewFile *.tt     setfiletype html.tt
    au! BufRead,BufNewFile *.tt2    setfiletype html.tt
    au! BufRead,BufNewFile *.psgi   setfiletype perl
    au! BufRead,BufNewFile *.t      setfiletype perl
    au! BufRead,BufNewFile *.ddl    setfiletype sql
    au! BufRead,BufNewFile *.m      setfiletype objc
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
if getcwd() != $HOME
    if filereadable(getcwd().'/.vimprojects')
        exec 'Project .vimprojects'
    endif
endif

" neocomplcache + neosnippet
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Not use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 0
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum cpmpletion length.
let g:neocomplcache_auto_completion_start_length = 1

" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Set overwrite completefunc (Issue #276)
let g:neocomplcache_force_overwrite_completefunc = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'perl'       : $HOME.'/.vim/dict/perl_functions.dict',
    \ 'php'        : $HOME.'/.vim/dict/php_functions.dict',
    \ 'ruby'       : $HOME.'/.vim/dict/ruby_functions.dict'
    \ }

let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" <TAB>: completion.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ?
  \ "\<C-n>"
  \: neosnippet#jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" taglist.vim
set tags=tags
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Show_One_File = 1 " show only current file
let Tlist_Exit_OnlyWindow = 1 " close vim if taglist is last window
let Tlist_Use_Right_Window = 1
"let Tlist_Auto_Open = 1
let Tlist_Auto_Update = 1
nmap <F10>  :Tlist<CR>

" cscope
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" srcexpl
let g:SrcExpl_updateTagsCmd = "/usr/local/bin/ctags --sort=foldcase -R ."
let g:SrcExpl_refreshTime = 100   " auto reflesh
let g:SrcExpl_isUpdateTags  = 0   " disable auto update
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
"let g:SrcExpl_RefreshMapKey = "<F8>"
let g:SrcExpl_searchLocalDef = 1
let g:SrcExpl_updateTagsKey = "<F12>"
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <F11>  :SrcExplToggle<CR>

" NERD Tree
let g:NERDTreeWinPos = "left"
nmap <F9>  :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" tanktmp
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr>
let g:yanktmp_file = '/tmp/yanktmp'

" quickrun
nmap <Leader>r <plug>(quickrun)

augroup quickfixopen
  autocmd!
  autocmd QuickfixCmdPost make cw
augroup END

" Perl
augroup Perl
    autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
    autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt

    function! s:pm_template()
        let path = substitute(expand('%'), '.*lib/', '', 'g')
        let path = substitute(path, '[\\/]', '::', 'g')
        let path = substitute(path, '\.pm$', '', 'g')

        call append(0, 'package ' . path . ';')
        call append(1, 'use strict;')
        call append(2, 'use warnings;')
        call append(3, 'use utf8;')
        call append(4, '')
        call append(5, '')
        call append(6, '')
        call append(7, '1;')
        call cursor(6, 0)
        " echomsg path
    endfunction
    autocmd BufNewFile *.pm call s:pm_template()
augroup END

" java
augroup Java
    autocmd FileType java setlocal tabstop=4 noexpandtab
augroup END

" Ruby
augroup Ruby
    autocmd! Ruby
    autocmd FileType ruby,eruby,yaml setlocal softtabstop=2 shiftwidth=2 tabstop=2
augroup END

" ========== Load local settings ========== "
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
