set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'taglist.vim'

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
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'tpope/vim-fugitive'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'

Bundle 'winmanager'

call vundle#end()


""""""""""""""""""""""""""""""""setting for plugins""""""""""""""""""""""""""""

nmap <C-F11> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:!rm -rf cscope.files <CR>
  \:cs reset<CR>


" set default config file, add compile_commands.json
let g:ycm_global_ycm_extra_conf = '/home/jack/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" Go to definition else declaration
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" manually invoke
let g:ycm_key_invoke_completion = '<C-a>'

map <F5> :call CurtineIncSw()<CR>

map <C-n> :NERDTreeToggle<CR>

map <F8> :TagbarToggle<CR>

set tags=tags;/ " ; to find tags in parent dir

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR>

" the following to auto find cscope.out in parent dir
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable 
  elseif $CSCOPE_DB != "" 
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

" use absolute path in cscope.out
" : set csre
: set nocsre

" config for rtags, https://github.com/lyuts/vim-rtags
let g:rtagsUseDefaultMappings = 1
let g:rtagsUseLocationList = 0
let g:rtagsJumpStackMaxSize = 100

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
let g:syntastic_cpp_cpplint_thres = 1
" let syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = '!'
let g:syntastic_style_warning_symbol = '?'

" for lightline.vim
if !has('gui_running')
  set t_Co=256
endif

" for mru
let MRU_Max_Entries = 1000 
let MRU_Window_Height = 10
let MRU_Auto_Close = 0 " let MRU_Use_Current_Window = 1

" for buffer explore
map <leader>b :BufExplorer<CR>
map <leader>bh :BufExplorerHorizontalSplit<CR>
map <leader>bv :BufExplorerVerticalSplit<CR>

" for cpp highlight
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

set tabstop=4
set expandtab
set shiftwidth=2

set number

syntax enable
syntax on "highlight the code

set history=1000 "history command num

set autoindent
set cindent

set shiftwidth=4

set encoding=utf-8

let mapleader=";"

" highlight search result
set hlsearch
set cursorline
" set cursorcolumn
hi Search ctermbg=LightYellow
hi Search ctermfg=Red

map <leader>c byw<CR>
map <leader>l :lclose<CR>
map <leader>t :tabNext<CR>

" for line length
:set colorcolumn=80

" rm current file in vim
" nnoremap rm :call delete(expand('%')) \| bdelete!<CR>

" code fold, za: on/off current fold, zM: off all folds, zR: on all folds
"set foldmethod=indent
set foldmethod=syntax
set nofoldenable " on/off

" define a hithlight group
:highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:match ExtraWhitespace /\s\+$/



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


