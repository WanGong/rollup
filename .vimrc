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
"

let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-clangd'
\ ]

call plug#begin(has('nvim') ? '~/.config/nvim/plugged' : '~/.vim/plugged')
" snipets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips' " must before CompleteParameter.vim

" code complete
" Plug 'Valloric/YouCompleteMe'
" Plug 'tenfyzhong/CompleteParameter.vim'

" color mark
Plug 'vim-scripts/ingo-library'
Plug 'WanGong/vim-mark'  " require vim-scripts/ingo-library

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'  " require fugitive
Plug 'airblade/vim-gitgutter'

" color scheme
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

" auto brackets
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'

" highlight display
Plug 'w0rp/ale'
Plug 'vim-python/python-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'luochen1990/rainbow'
Plug 'ap/vim-css-color'

" move
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-fswitch'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" status line
Plug 'vim-airline/vim-airline'  " require vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" code format
Plug 'sbdchd/neoformat'
Plug 'maksimr/vim-jsbeautify'

" index
Plug 'lyuts/vim-rtags'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" display
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'

" comment
Plug 'preservim/nerdcommenter'

" markdown
Plug 'masukomi/vim-markdown-folding', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown' " require tabular
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
call plug#end()




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



"    ___  __          _        _____          ____
"   / _ \/ /_ _____ _(_)__    / ___/__  ___  / _(_)__ _
"  / ___/ / // / _ `/ / _ \  / /__/ _ \/ _ \/ _/ / _ `/
" /_/  /_/\_,_/\_, /_/_//_/  \___/\___/_//_/_//_/\_, /
"             /___/                             /___/
"
"


" for 'sbdchd/neoformat'
nnoremap ff :Neoformat<CR>


" for WanGong/vim-mark
nnoremap mm :MarkClear<CR>


" for leaderF
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_UseCache = 0
let g:Lf_ShowDevIcons = 0
nnoremap tt :LeaderfTag<CR>
nnoremap ta :ta<space>
let g:Lf_WildIgnore = {
      \ 'dir': ['.svn','.git','.hg','.clangd'],
      \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
      \}



" for derekwyatt/vim-fswitch
nnoremap <C-f> :FSHere<CR>
nnoremap <M-l> :FSSplitRight<CR>
nnoremap <M-h> :FSSplitLeft<CR>
au! BufEnter *.cc let b:fswitchdst = 'hh,h'
au! BufEnter *.h let b:fswitchdst = 'c,cpp,m,cc'


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


" for 'ludovicchabant/vim-gutentags'
" project root flag, stop to find in the parent dir
let g:gutentags_enabled = 0
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project', 'package.json']
" tag file name
let g:gutentags_ctags_tagfile = 'tags'
" push the tags into ~/.cache/tags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" tags parameter
let g:gutentags_ctags_extra_args = ['-R', '--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--language-force=C++']
" crate the dir if needed
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:gutentags_add_default_project_roots = 0
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" maybe also exclude 'build'
let g:gutentags_ctags_exclude = [
\  '*.git', '*.svn', '*.hg',
\  'cache', 'dist', 'bin', 'node_modules', 'bower_components',
\  '*-lock.json',  '*.lock',
\  '*.min.*',
\  'CMakeLists.txt',
\  '*.bak',
\  '*.zip',
\  '*.pyc',
\  '*.class',
\  '*.sln',
\  '*.csproj', '*.csproj.user',
\  '*.tmp',
\  '*.cache',
\  '*.vscode',
\  '*.pdb',
\  '*.pb',
\  '*.exe', '*.dll', '*.bin',
\  '*.mp3', '*.ogg', '*.flac',
\  '*.swp', '*.swo',
\  '.DS_Store', '*.plist',
\  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
\  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
\  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
\]


" for youcompleteme
" to support c++: 1. sudo apt-get install libc++-dev; 2. add '-isystem' '/usr/include/c++/v1/' to .ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '/home/jack/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-a>' " Manually invoke
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_python_interpreter = '/usr/bin/python3'

let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

let g:ycm_use_clangd = 1

" close ycm
let g:ycm_auto_trigger = 0
let g:loaded_youcompleteme = 1


" config for rtags, https://github.com/lyuts/vim-rtags
let g:rtagsUseDefaultMappings = 1
let g:rtagsUseLocationList = 0
let g:rtagsJumpStackMaxSize = 100
let g:rtagsAutoLaunchRdm = 1
let g:rtagsRdmCmd = "rdm -j 1"


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

nnoremap tb :TagbarToggle<CR>
nnoremap <C-n> :NERDTreeToggle<CR>


" for CompleteParameter.vim
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" to work with auto-pairs
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>


" for luochen1990/rainbow
let g:rainbow_active = 1


" for preservim/nerdcommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


" for ultisnips
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" for coc.nvim
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Recently vim can merge signcolumn and number column into one
" set signcolumn=yes "default to be auto

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd ColorScheme * highlight CocHighlightText ctermfg=LightMagenta guifg=LightMagenta cterm=bold gui=bold

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}





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
" config the following to enable git trust vim exitcode, quit with :cquit
" 4. git config --local  difftool.trustExitCode true
" 5. git config --local  mergetool.trustExitCode true
" usage:
" 1. git d for the vimdiff
" 2. :qa for exit current file;
" 3. :cq for interrupt the vimdiff
if &diff
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
else
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  set background=dark
  colorscheme gruvbox
endif


" when FileType python, create a mapping to execute the current buffer with python
" autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<CR>


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


" sudo apt-get install wmctrl, maximize gvim
autocmd GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)



"    ___           _       _____          ____
"   / _ )___ ____ (_)___  / ___/__  ___  / _(_)__ _
"  / _  / _ `(_-</ / __/ / /__/ _ \/ _ \/ _/ / _ `/
" /____/\_,_/___/_/\__/  \___/\___/_//_/_//_/\_, /
"                                           /___/

filetype plugin indent on

if has('termguicolors')
  set termguicolors
endif

let mapleader=";"

syntax enable
" syntax on "Highlight the code

" set nocsre " use absolute path in cscope.out, set csre
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
highlight Search ctermbg=LightYellow ctermfg=Red cterm=bold,italic guibg=LightYellow guifg=Red gui=bold,italic

set cursorline
set backspace=indent,eol,start
set matchpairs+=<:>
highlight MatchParen ctermbg=green ctermfg=blue guibg=green guifg=blue

" au FileType c,cpp,java set matchpairs+==:;

" code fold, za: on/off current fold, zM: off all folds, zR: on all folds
" set foldmethod=indent
set foldmethod=syntax
set nofoldenable " on/off

set colorcolumn=80 " for line length
highlight ColorColumn ctermbg=DarkGray guibg=LightGray
highlight clear SpellBad
highlight SpellBad cterm=underline,italic gui=underline,italic

set smartcase

" Backup config
set backup
set backupdir=~/.vim/backup/ "Where to store backups
set writebackup "Make backup before overwriting the current buffer
set backupcopy=yes "Overwrite the original backup file
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M") "Meaningful backup name, ex: filename@2015-04-05.14:59

" Vim terminal
set splitbelow
" set termwinsize=12x0

" fix crazy wrong code, ref to https://www.reddit.com/r/vim/comments/gv410k/strange_character_since_last_update_42m/fsmfxxv/
let &t_TI = ""
let &t_TE = ""



"    __ __           __  ___               _
"   / //_/__ __ __  /  |/  /__ ____  ___  (_)__  ___ ____
"  / ,< / -_) // / / /|_/ / _ `/ _ \/ _ \/ / _ \/ _ `(_-<
" /_/|_|\__/\_, / /_/  /_/\_,_/ .__/ .__/_/_//_/\_, /___/
"          /___/             /_/  /_/          /___/
"

nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>e :tabedit<CR>
nnoremap <leader>l :lclose<CR>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>s :AgSearch<CR>
nnoremap <leader>t :terminal<CR>
nnoremap <leader>u :LeaderfMru<CR>
nnoremap <leader>ve :Vexplore<CR>
nnoremap <leader>w :w!<CR>
inoremap qq <Esc>
nnoremap zz :%s/\s\+$// <CR> " delete unused space keys at the end of a line.
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR> " search the word under cursor
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR> " trigger self-defined AutoHighlightToggle()
nnoremap <C-b> :bNext<CR>

nnoremap <C-w>S :sp<CR>
nnoremap <C-w>V :vs<CR>
