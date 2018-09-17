" Copyright 2018. All rights reserved.
"
"   _,_ /_      ,____,         _,     .  ,____,   ,_   __
" _(_/_/ (_   _/ / / (__(_/_    (_/__/__/ / / (__/ (__(_,_
"                       _/_
"                      (/
"
" oh my .vimrc, the chart is generated from patorjk.com/software/taag/ with
" JS Cursive and small slant front.



"  _   __             ____      ___  __          _
" | | / /_ _____  ___/ / /__   / _ \/ /_ _____ _(_)__  ___
" | |/ / // / _ \/ _  / / -_) / ___/ / // / _ `/ / _ \(_-<
" |___/\_,_/_//_/\_,_/_/\__/ /_/  /_/\_,_/\_, /_/_//_/___/
"                                         /___/
"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'ericcurtin/CurtineIncSw.vim'
" Plugin 'haya14busa/incsearch.vim'
" Plugin 'jeaye/color_coded'
" Plugin 'mileszs/ack.vim'
" Plugin 'ryanoasis/vim-devicons'
" Plugin 'scrooloose/syntastic'
" Plugin 'sheerun/vim-polyglot' " a powerful language pack
" Plugin 'skywind3000/asyncrun.vim'
" Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'WanGong/vim-mark'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/LeaderF'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'brookhong/cscope.vim'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'majutsushi/tagbar'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-python/python-syntax'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/ingo-library' " dependent by vim-mark
Plugin 'vim-scripts/mru.vim'
Plugin 'w0rp/ale'
call vundle#end()



"    ____    _____  ____        _      __
"   / __/__ / / _/ / __/_______(_)__  / /____
"  _\ \/ -_) / _/ _\ \/ __/ __/ / _ \/ __(_-<
" /___/\__/_/_/  /___/\__/_/ /_/ .__/\__/___/
"                             /_/
"

" highlight all instances of word under cursor, Type z/ to toggle highlighting on/off.
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


" use ag replace grep, the Silver Searcher
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " use ag in CtrlP for listing files. Lightning fast and respects .gitignore
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


" the following to auto find cscope.out in parent dir
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



"    ___  __          _        _____          ____
"   / _ \/ /_ _____ _(_)__    / ___/__  ___  / _(_)__ _
"  / ___/ / // / _ `/ / _ \  / /__/ _ \/ _ \/ _/ / _ `/
" /_/  /_/\_,_/\_, /_/_//_/  \___/\___/_//_/_//_/\_, /
"             /___/                             /___/
"

" for mru, MUST avoid to use <c-m>, Ctrl + m = Enter
let MRU_Max_Entries = 200
let MRU_Window_Height = 15
let MRU_Auto_Close = 1
" let MRU_Use_Current_Window = 1


" for ctrlp
let g:ctrlp_by_filename = 1


" for airline
let g:airline_theme="simple"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = '✗: '
let g:airline#extensions#ale#warning_symbol = '⚠ : '
let g:airline#extensions#ale#show_line_numbers = 0
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline_section_z=airline#section#create(['%4l%#__restore__#%#__accent_bold#/%L%']) " show curline/total_line
let g:airline_skip_empty_sections = 1


" to support c++: 1. sudo apt-get install libc++-dev; 2. add '-isystem' '/usr/include/c++/v1/' to .ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '/home/jack/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-a>' " Manually invoke
let g:ycm_autoclose_preview_window_after_insertion = 1


" config for rtags, https://github.com/lyuts/vim-rtags
let g:rtagsUseDefaultMappings = 1
let g:rtagsUseLocationList = 0
let g:rtagsJumpStackMaxSize = 100
let g:rtagsAutoLaunchRdm = 1


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


" for cpp highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1


" combine NERDtree and tagbar
let NERDTreeMinimalUI=1 " remove the first line help info
let NERDTreeWinSize=40  " set width
let NERDTreeHighlightCursorline=1 " does not highlight the cursor of current file
let NERDTreeChDirMode = 2 " setting for current directory
" Auto quit NERDTree when vim is quited
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
" Auto open NERDTree when vim is opened
" autocmd vimenter * NERDTree
" let g:tagbar_vertical = 25
let g:tagbar_compact = 1 " remove the first line help info
let g:tagbar_width = 30
let g:tagbar_autoshowtag = 1 " auto highlight tags when edit file
let g:tagbar_iconchars = ['▸', '▾']
" Auto open NERDTree when vim is opened
" autocmd VimEnter * nested :TagbarOpen
" wincmd l
autocmd VimEnter * wincmd l " if not exist, when open vim, the cursor will in NERDTree



"
"   _____                __          _____          ____
"  / ___/__  __ _  ___  / /____ __  / ___/__  ___  / _(_)__ _
" / /__/ _ \/  ' \/ _ \/ / -_) \ / / /__/ _ \/ _ \/ _/ / _ `/
" \___/\___/_/_/_/ .__/_/\__/_\_\  \___/\___/_//_/_//_/\_, /
"               /_/                                   /___/
"

" to config vimdiff for git, run the following commands:
" 1. git config --local  diff.tool vimdiff
" 2. git config --local  difftool.prompt false
" 3. git config --local  alias.d difftool
" config the following to enable git trust vim exitcode
" 4. git config --local  difftool.trustExitCode true
" 5. git config --local  mergetool.trustExitCode true
" usage:
" 1. git d for the vimdiff
" 2. :qa for exit current file;
" 3. :cq for interrupt the vimdiff
if &diff
  syntax off
  highlight DiffAdd    cterm=bold ctermfg=10 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 gui=none guifg=bg guibg=Red
else
  syntax enable
"  syntax on "Highlight the code
endif


" when FileType python, create a mapping to execute the current buffer with python
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>


" record the last postition, pulled from :help last-position-jump in vim
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif


autocmd InsertEnter * setlocal spell
autocmd InsertLeave * setlocal nospell
" autocmd BufRead,BufNewFile *.h setlocal spell


" define a hithlight group for extra white space
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+$/




"    ___           _       _____          ____
"   / _ )___ ____ (_)___  / ___/__  ___  / _(_)__ _
"  / _  / _ `(_-</ / __/ / /__/ _ \/ _ \/ _/ / _ `/
" /____/\_,_/___/_/\__/  \___/\___/_//_/_//_/\_, /
"                                           /___/

filetype plugin indent on

let mapleader=";"

set background=dark
colorscheme desert

set nocsre " use absolute path in cscope.out, set csre
set expandtab
set shiftwidth=2
set softtabstop=2

set number
set history=1000 " history command number

set autoindent
set cindent

set encoding=utf-8
set clipboard=unnamed
set tags=tags;/ " the ';' is used to find tags in parent dir

set incsearch
set hlsearch " highlight search result
highlight Search ctermbg=LightYellow ctermfg=Red cterm=bold,italic

set cursorline
set backspace=indent,eol,start
set matchpairs+=<:>
highlight MatchParen cterm=none ctermbg=green ctermfg=blue
" au FileType c,cpp,java set matchpairs+==:;

" code fold, za: on/off current fold, zM: off all folds, zR: on all folds
" set foldmethod=indent
set foldmethod=syntax
set nofoldenable " on/off

set colorcolumn=80 " for line length
highlight ColorColumn ctermbg=8

highlight clear SpellBad
highlight SpellBad cterm=underline,italic

set smartcase




"    __ __           __  ___               _
"   / //_/__ __ __  /  |/  /__ ____  ___  (_)__  ___ ____
"  / ,< / -_) // / / /|_/ / _ `/ _ \/ _ \/ / _ \/ _ `(_-<
" /_/|_|\__/\_, / /_/  /_/\_,_/ .__/ .__/_/_//_/\_, /___/
"          /___/             /_/  /_/          /___/
"

nnoremap <leader>e :tabedit<CR>
nnoremap <leader>l :lclose<CR>
nnoremap <leader>n :NERDTreeFind<cr>
nnoremap <leader>o :only<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>s :AgSearch<CR>
nnoremap <leader>t :tabNext<CR>
nnoremap <leader>u :MRU<CR>
nnoremap <leader>ve :Vexplore<CR>
nnoremap <leader>w :w!<CR>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR> " search the word under cursor
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR> " trigger self-defined AutoHighlightToggle()
nnoremap zz :%s/\s\+$// <CR> " delete unused space keys at the end of a line.
noremap <C-b> :bNext<cr>
noremap <C-n> :NERDTreeToggle<CR>
noremap <F2> :MarkClear<cr> " for vim-mark
noremap <F3> :YcmCompleter GetType<cr>
noremap <F4> :set spell!<cr>
noremap <F5> :A<CR>
noremap <F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR>
noremap <F8> :TagbarToggle<CR>
noremap <F9> :ClangFormat<cr> " for clang-format
noremap <F10> "+yy<CR>


nnoremap <F7> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:!rm -rf cscope.files <CR>
  \:cs reset<CR>



"    ___                            __         __
"   / _ \___ ___  _______ _______ _/ /____ ___/ /
"  / // / -_) _ \/ __/ -_) __/ _ `/ __/ -_) _  /
" /____/\__/ .__/_/  \__/\__/\_,_/\__/\__/\_,_/
"         /_/

" " auto expand NERDTree when the file is open
" " 1. Check if NERDTree is open or active
" function! IsNERDTreeOpen()
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction
" " 2. Call NERDTreeFind iff NERDTree is active, current window contains a
" " modifiable file, and we're not in vimdiff
" function! SyncTree()
"   if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"     NERDTreeFind
"     wincmd p
"   endif
" endfunction
" " 3. Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()


" for syntastic
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


" for buffer explore
" nnoremap <leader>bh :BufExplorerHorizontalSplit<CR>
" nnoremap <leader>bv :BufExplorerVerticalSplit<CR>
" nnoremap <leader>b :BufExplorer<cr>
" let g:bufExplorerDefaultHelp=0


" disable color_coded in diff mode
" if &diff
"   let g:color_coded_enabled = 0
" endif


" for ack.vim, basic manual: O for open and close Quickfix; go open file but
" return in Quickfix; t for open file in new tab
" let g:ackprg = 'ag --nogroup --nocolor --column'
" noremap <c-k> :Ack<space>
" noremap <Leader>a :Ack <cword><cr> " Search the word under cursor


" for skywind3000/asyncrun.vim
" let g:asyncrun_open = 8


" key mapping
" noremap <F5> :call CurtineIncSw()<CR>
" noremap <C-b> :CtrlPBuffer<cr> " for ctrlp




"   ____  __  __                              __  _  __     __
"  / __ \/ /_/ /  ___ _______   ___ ____  ___/ / / |/ /__  / /____ ___
" / /_/ / __/ _ \/ -_) __(_-<  / _ `/ _ \/ _  / /    / _ \/ __/ -_|_-<
" \____/\__/_//_/\__/_/ /___/  \_,_/_//_/\_,_/ /_/|_/\___/\__/\__/___/
"

" some resources:
" https://vimawesome.com/, a awesome vim plugins collection
"
