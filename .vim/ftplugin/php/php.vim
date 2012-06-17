" ========== PHP ========== "

" General
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

" Dictonary
setlocal dictionary+ = ~/.vim/dict/php_functions.dict

" SyntaxCheck
augroup syntaxcheck
    autocmd!
    autocmd BufWrite *.php w !php -l
augroup END

