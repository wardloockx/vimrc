set hlsearch
set incsearch

" Set standard setting for PEAR coding standards
set tabstop=4
set shiftwidth=4

" Auto expand tabs to spaces
set expandtab

" Auto indent after a {
set autoindent
set smartindent

" Linewidth to endless
set textwidth=0

" Do not wrap lines automatically
set nowrap

" Show line numbers by default
set number

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Repair wired terminal/vim settings
set backspace=start,eol

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
"set dictionary-=/home/pookey/funclist.txt dictionary+=/home/pookey/funclist.txt
" Use the dictionary completion
"set complete-=k complete+=k
"

"Omni completion
filetype plugin on
au FileType php set omnifunc=phpcomplete#CompletePHP

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
"function InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction

function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
    return "\<Tab>"
    else
    return "\<C-n>"
    endif
    endfunction
    imap <Tab> <C-R>=SuperTab()<CR>

" Remap the tab key to select action with InsertTabWrapper
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

set list
set listchars=tab:>-,trail:-
" set listchars=tab:>-,trail:-,eol:$
set ignorecase                  " caseinsensitive searches
set showmode                    " always show command or insert mode
set ruler                      " show line and column information
set showmatch                  " show matching brackets
set formatoptions=tcqor
set whichwrap=b,s,<,>,[,]
syntax on

" php helpfuls
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1

colorscheme desert

" Set leader key
let mapleader = ","

" Taglist Variables {
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Use_Right_Window = 0 
let Tlist_Use_SingleClick = 1
let Tlist_Auto_Highlight_Tag = 0
let Tlist_Show_Menu = 1
let Tlist_Show_One_File = 1
let Tlist_php_settings = 'php;c:class;d:constant;f:function'
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
nnoremap tl <Esc>:TlistToggle<CR>

let g:ctags_statusline=1
" Override how taglist does javascript
let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'
" }


function! LoadCscope()
  let db = findfile("ctags", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "ctags$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
"au BufEnter /* call LoadCscope()
"

"Tags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"wiki
set nocompatible
filetype plugin on
map <Leader>wf <Plug>VimwikiFollowLink
au BufRead,BufNewFile *.wiki set ft=vimwiki

"Call generate ctags script
"function! generateTags()
"    silent! exec "r!bin/generateCtags.sh"
"endfunction

" PHP completion
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

imap <C-Space> <C-x><C-o>

nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

"nnoremap <silent>qq y:call generateTags()<cr>
"
"
map gC :'a,. s/^/ */^M:. s/\(.*\)/\1^V^V^M **************\//^M:'a "s/\(.*\)/\/**************^V^V^M\1/^M

"php folds
map <F5> <Esc>:EnableFastPHPFolds<Cr> 
map fa <Esc>:EnablePHPFolds<Cr> 
map fn <Esc>:DisablePHPFolds<Cr> 

nnoremap nw <C-w><C-w>

"PHP check
map <C-M> :w!<CR>:!/usr/bin/php %<CR>
