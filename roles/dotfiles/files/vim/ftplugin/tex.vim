setlocal shiftwidth=2
setlocal tabstop=2
setlocal autoindent
setlocal spell spelllang=en_gb

let g:vimtex_view_method = 'skim'

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
