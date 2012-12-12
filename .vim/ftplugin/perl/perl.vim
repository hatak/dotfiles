" ========== Perl ========== "

" General
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

" Dictionary
setlocal dictionary+=~/.vim/dict/perl_functions.dict

" Perldoc settings
noremap K :Perldoc<CR>
setlocal iskeyword-=/
setlocal iskeyword+=:

" PerlTidy
map ,pt <ESC>:%! perltidy -se<CR>
map ,ptv <ESC>:%'<, '>! perltidy -se<CR>

inoremap <expr> = smartchr#loop(' = ', ' => ', ' == ', '=')

" Check package name
function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
        if line =~ mx
        return substitute(matchstr(line, mx), mx, '\1', '')
        endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします！"
        echomsg "ちゃんとなおしてください＞＜"
        echohl None
    endif
endfunction

au! BufWritePost *.pm call s:check_package_name()
