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
map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>

" toggle
"TrinityToggleAll
Tlist
