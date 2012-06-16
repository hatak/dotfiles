" ========== Perl ========== "

" General
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

" Perldoc settings
noremap K :Perldoc<CR>
setlocal iskeyword-=/
setlocal iskeyword+=:

" PerlTidy
map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>

