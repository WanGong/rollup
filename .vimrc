set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'ryanoasis/vim-devicons'
" Plugin 'sheerun/vim-polyglot'
" Plugin 'scrooloose/syntastic'
" Plugin 'jeaye/color_coded'
Plugin 'vim-scripts/mru.vim'
Plugin 'w0rp/ale'
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'brookhong/cscope.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'haya14busa/incsearch.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'airblade/vim-gitgutter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rhysd/vim-clang-format'


call vundle#end()


""""""""""""""""""""""""""""""""setting for plugins""""""""""""""""""""""""""""

" for clang-format
noremap <F9> :ClangFormat<cr>

" for mru
" MUST avoid to use <c-m>, Ctrl + m = Enter


" for ctrlp
noremap <c-b> :CtrlPBuffer<cr>


" for airline
let g:airline_theme="simple"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = '✗: '
let g:airline#extensions#ale#warning_symbol = '⚠ : '
let g:airline#extensions#ale#show_line_numbers = 0


" Disable color_coded in diff mode
" if &diff
"   let g:color_coded_enabled = 0
" endif


" For ack.vim, basic manual: O for open and close Quickfix; go open file but
" return in Quickfix; t for open file in new tab
let g:ackprg = 'ag --nogroup --nocolor --column'
noremap <c-k> :Ack<space>
"noremap <Leader>a :Ack <cword><cr> " Search the word under cursor


" Set default config file, add compile_commands.json
let g:ycm_global_ycm_extra_conf = '/home/jack/.vim/bundle/YouCompleteMe/python/ycm/tests/testdata/.ycm_extra_conf.py'
" Go to definition else declaration
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Manually invoke
let g:ycm_key_invoke_completion = '<C-a>'


noremap <F5> :call CurtineIncSw()<CR>


"  " Auto expand NERDTree when the file is open
"  " 1. Check if NERDTree is open or active
"  function! IsNERDTreeOpen()
"    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"  endfunction
"  " 2. Call NERDTreeFind iff NERDTree is active, current window contains a
"  " modifiable file, and we're not in vimdiff
"  function! SyncTree()
"    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"      NERDTreeFind
"      wincmd p
"    endif
"  endfunction
"  " 3. Highlight currently open buffer in NERDTree
"  autocmd BufEnter * call SyncTree()


set tags=tags;/ " The ';' is used to find tags in parent dir
noremap <F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR>


nnoremap <F7> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:!rm -rf cscope.files <CR>
  \:cs reset<CR>

" The following to auto find cscope.out in parent dir
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " Else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

" Use absolute path in cscope.out
" : set csre
set nocsre


" Config for rtags, https://github.com/lyuts/vim-rtags
let g:rtagsUseDefaultMappings = 1
let g:rtagsUseLocationList = 0
let g:rtagsJumpStackMaxSize = 100


" for ale
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
" let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ %d']
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}

" For syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1
" let g:syntastic_cpp_cpplint_exec = 'cpplint'
" let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
" let g:syntastic_cpp_cpplint_thres = 1
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol = "⚠"
" let g:syntastic_style_error_symbol = '!'
" let g:syntastic_style_warning_symbol = '?'
" let g:syntastic_loc_list_height = 5


" For mru
let MRU_Max_Entries = 200
let MRU_Window_Height = 10
let MRU_Auto_Close = 1
" let MRU_Use_Current_Window = 1


" For buffer explore
nnoremap <leader>bh :BufExplorerHorizontalSplit<CR>
nnoremap <leader>bv :BufExplorerVerticalSplit<CR>


" For cpp highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1



noremap <C-n> :NERDTreeToggle<CR>
noremap <F8> :TagbarToggle<CR>

" Combine NERDtree and tagbar
" Remove the first line help info
let NERDTreeMinimalUI=1
" Set width
let NERDTreeWinSize=28
" Does not highlight the cursor of current file
let NERDTreeHighlightCursorline=1
" Setting for current directory
let NERDTreeChDirMode = 2
" Auto quit NERDTree when vim is quited
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
" Auto open NERDTree when vim is opened
" autocmd vimenter * NERDTree
"nmap <F2> :NERDTreeToggle<CR>

" Combine NERDTree and tagbar
" let g:tagbar_vertical = 25
" Remove the first line help info
let g:tagbar_compact = 1
" Auto highlight tags when edit file
let g:tagbar_autoshowtag = 1
let g:tagbar_iconchars = ['▸', '▾']
"nmap <F3> :TagbarToggle<CR>
" Auto open NERDTree when vim is opened
" autocmd VimEnter * nested :TagbarOpen
" wincmd l
" If the following line does not exist, when open vim, the cursor will in NERDTree
autocmd VimEnter * wincmd l




""""""""""""""""""""""""""""""""setting for basic""""""""""""""""""""""""""""
filetype plugin indent on

set background=dark
colorscheme desert

set expandtab
set shiftwidth=2
set softtabstop=2

set number

syntax enable
syntax on "Highlight the code

set history=1000 "History command num

set autoindent
set cindent

set encoding=utf-8

let mapleader=";"

set clipboard=unnamed
noremap <F10> "+yy<CR>

" Highlight search result
set hlsearch
set incsearch
set cursorline
" set cursorcolumn
hi Search ctermbg=LightYellow
hi Search ctermfg=Red

nnoremap <leader>l :lclose<CR>
nnoremap <leader>t :tabNext<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>ve :Vexplore<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>Q :qall!<CR>
nnoremap <leader>n :NERDTreeFind<cr>
nnoremap <leader>b :buffers<CR>:buffer<Space>


" For line length
:set colorcolumn=80
highlight ColorColumn ctermbg=8

" Remove current file in vim
" nnoremap rm :call delete(expand('%')) \| bdelete!<CR>

" Code fold, za: on/off current fold, zM: off all folds, zR: on all folds
" Set foldmethod=indent
set foldmethod=syntax
set nofoldenable " on/off

" Define a hithlight group
:highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:match ExtraWhitespace /\s\+$/

nnoremap zz :%s/\s\+$// <CR> " Delete unused space keys at the end of a line.

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

set backspace=indent,eol,start


""""""""""""""""""""""""""""""""setting for script""""""""""""""""""""""""""""

" Highlight all instances of word under cursor, when idle. Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction


" Use ag replace grep, the Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" self defined command for ag search
function! AgSearch()
  let grep_term = input("/")
  if !empty(grep_term)
    execute 'silent grep' grep_term | copen
  else
    echo "Empty search term"
  endif
  redraw!
endfunction

command! AgSearch call AgSearch()
nnoremap <leader>s :AgSearch<CR>


