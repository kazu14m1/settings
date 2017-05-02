" Coloescheme
syntax on
" colorscheme mycolor
" colorscheme vividchalk

set number
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末でとまらないようにする
set cursorline
set backspace=indent,eol,start

" search
set ignorecase
set smartcase
set hlsearch
set wrapscan

set showmatch
set matchtime=2

" set tags=./tags,./TAGS,tags,TAGS,~/.ctags/*.tags

" StatusLine
set laststatus=2
set statusline=%{expand('%:p:t')}\ %<\(%{SnipMid(expand('%:p:h'),80-len(expand('%:p:t')),'...')}\)%=\ %m%r%y%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%3l,%3c]
function! SnipMid(str, len, mask)
  if a:len >= len(a:str)
      return a:str
  elseif a:len <= len(a:mask)
      return a:mask
  endif

  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head

  return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction

" Encoding
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,ucs-2le,ucs-2
setl fenc=utf-8
setl ff=unix
set fileformats=unix,dos,mac

" List
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<

set title
set showcmd

nnoremap <Esc><Esc> :<c-u>set nohlsearch<Return>
" tab
nnoremap <C-n> gt
nnoremap <C-p> gT
" j,kで表示行単位で移動するようにgj,gkと入れ替え
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

set nocompatible
filetype off
" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundleで管理するプラグインを書いていく
Bundle 'gmarik/vundle'

" github
Bundle 'Shougo/unite.vim'
" Bundle 'Shougo/vimfiler.vim'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'pangloss/vim-javascript'
Bundle '2072/PHP-Indenting-for-VIm'
Bundle 'vim-scripts/vim-tags'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/vimshell.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'mattn/emmet-vim'
Bundle 'fatih/vim-go'
Bundle 'editorconfig/editorconfig-vim'
" Bundle 'scrooloose/syntastic'

" vim.org
Bundle 'sudo.vim'
Bundle 'indenthtml.vim'
" Bundle 'DoxygenToolkit.vim'

filetype plugin on
filetype indent on

augroup FileTypeAu
    " FileType毎のautocmd
    autocmd!
    " autocmd FileType * match JpSpace /＿/
    autocmd BufRead,BufNewFile *.inc setlocal ft=php
    autocmd BufRead,BufNewFile *.svg setlocal ft=xml fenc=utf-8
    autocmd BufNewFile,BufRead *.js setlocal ft=javascript fenc=utf-8
    autocmd BufNewFile,BufRead *.ejs setlocal ft=html fenc=utf-8
    autocmd BufNewFile,BufRead *.smarty setlocal ft=html fenc=utf-8
    autocmd BufNewFile,BufRead *.rb setlocal ft=ruby fenc=utf-8
    autocmd BufNewFile,BufRead *.yicf setlocal ft=yicf fenc=utf-8
    autocmd BufNewFile *.yicf 0r ~/vim_skeleton/skel.yicf
    autocmd FileType * setlocal formatoptions-=ro
    autocmd FileType php :setlocal dictionary=~/.vim/dict/php.dict
    autocmd FileType php :imap <Nul> <c-x><c-k>
    autocmd FileType php inoremap <C-D> <Esc>:call PhpDocSingle()<CR>i
    autocmd FileType php nnoremap <C-D> :call PhpDocSingle()<CR>
    autocmd FileType php vnoremap <C-D> :call PhpDocSingle()<CR>
    autocmd FileType html :imap <Nul> <c-x><c-o>
    autocmd FileType html,xml,htm setlocal tabstop=2 shiftwidth=2 softtabstop=2 matchpairs+=<:>
    autocmd FileType xml setlocal ffs=unix
    autocmd BufRead,BufNewFile Makefile setlocal noexpandtab
    autocmd BufWritePre *.php,*.inc call RTrim()
augroup END

augroup VimrcAu
    autocmd!
    autocmd BufWritePost ~/.vimrc so ~/.vimrc
augroup END

" 保存時に行末の不要なスペースを削除
function! RTrim()
    %s/\s\+$//e
endfunction

" vimfiler
" let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_as_default_explorer = 1

" neadtree
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
vnoremap <silent> <C-e> :NERDTreeToggle<CR>
inoremap <silent> <C-e> :NERDTreeToggle<CR>

let g:NERDTreeShowHidden=1

" neocomplcache
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" 補完候補の数
let g:neocomplcache_max_list = 10
" 1番目の候補を自動選択
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_auto_completion_start_length = 3

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions',
            \ 'php' : $HOME.'/.vim/dict/php.dict'
            \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplcache_delimiter_patterns')
    let g:netcomplcache_delimiter_patterns = {}
endif
let g:netcomplcache_delimiter_patterns['php'] = ['->', '::', '\']

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p><C-n>"

" inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"


" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
