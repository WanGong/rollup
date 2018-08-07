set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'taglist.vim'
" Plugin 'itchyny/lightline.vim'

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'brookhong/cscope.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/mru.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'tpope/vim-fugitive'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Bundle 'maksimr/vim-jsbeautify'

Bundle 'winmanager'

call vundle#end()


""""""""""""""""""""""""""""""""setting for plugins""""""""""""""""""""""""""""

" For ack.vim, basic manual: O for open and close Quickfix; go open file but
" return in Quickfix; t for open file in new tab
let g:ackprg = 'ag --nogroup --nocolor --column'
noremap <c-k> :Ack<space>
"noremap <Leader>a :Ack <cword><cr> " Search the word under cursor

nmap <C-F11> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:!rm -rf cscope.files <CR>
  \:cs reset<CR>


" Set default config file, add compile_commands.json
let g:ycm_global_ycm_extra_conf = '/home/jack/.vim/bundle/YouCompleteMe/python/ycm/tests/testdata/.ycm_extra_conf.py'
" Go to definition else declaration
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Manually invoke
let g:ycm_key_invoke_completion = '<C-a>'

map <F5> :call CurtineIncSw()<CR>

map <C-n> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>

set tags=tags;/ " The ';' is used to find tags in parent dir

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR>

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
: set nocsre

" Config for rtags, https://github.com/lyuts/vim-rtags
let g:rtagsUseDefaultMappings = 1
let g:rtagsUseLocationList = 0
let g:rtagsJumpStackMaxSize = 100


" For syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
let g:syntastic_cpp_cpplint_thres = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = '!'
let g:syntastic_style_warning_symbol = '?'

" For lightline.vim
if !has('gui_running')
  set t_Co=256
endif

" For mru
let MRU_Max_Entries = 1000
let MRU_Window_Height = 10
let MRU_Auto_Close = 0
" let MRU_Use_Current_Window = 1

" For buffer explore
map <leader>b :BufExplorer<CR>
map <leader>bh :BufExplorerHorizontalSplit<CR>
map <leader>bv :BufExplorerVerticalSplit<CR>

" For cpp highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1






""""""""""""""""""""""""""""""""setting for basic""""""""""""""""""""""""""""
filetype plugin indent on

set background=dark
colorscheme desert
"colorscheme solarized
"colorscheme molokai
"colorscheme phd

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

" Highlight search result
set hlsearch
set cursorline
" set cursorcolumn
hi Search ctermbg=LightYellow
hi Search ctermfg=Red

nnoremap <leader>c byw<CR>
nnoremap <leader>l :lclose<CR>
nnoremap <leader>t :tabNext<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>ve :Vexplore<CR>
nnoremap <leader>m :MRU<CR>

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
