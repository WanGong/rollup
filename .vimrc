set nocompatible              " be iMproved, required
filetype off                  " required

" 启用vundle来管理vim插件
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 安装插件写在这之后

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'valloric/youcompleteme'
Plugin 'godlygeek/tabular'
Plugin 'davidhalter/jedi-vim'
Plugin 'taglist.vim'
Plugin 'brookhong/cscope.vim'


" 安装插件写在这之前
call vundle#end()            " required
filetype plugin indent on    " required

" 常用命令
" :PluginList       - 查看已经安装的插件
" :PluginInstall    - 安装插件
" :PluginUpdate     - 更新插件
" :PluginSearch     - 搜索插件，例如 :PluginSearch xml就能搜到xml相关的插件
" :PluginClean      - 删除插件，把安装插件对应行删除，然后执行这个命令即可


" h: vundle         - 获取帮助

" vundle的配置到此结束，下面是你自己的配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ts=4
set expandtab
set number

syntax enable
syntax on " 代码高亮


set ruler " show the raw and col
set showcmd "show the current input command
set history=1000 "history command num

set autoindent "indent for c and c++
set cindent

set shiftwidth=4 "the space number of autoindent

set encoding=utf-8

"choice order for auto-choose-encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 

" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 设置跳转到方法/函数定义的快捷键 
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR> 

" 触发补全快捷键 
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>'] 
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>'] 
let g:ycm_auto_trigger = 1 
" 最小自动触发补全的字符大小设置为 3 
let g:ycm_min_num_of_chars_for_completion = 3 
" YCM的previw窗口比较恼人，还是关闭比较好 
set completeopt-=preview 


map <C-n> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>

"sudo apt-get install exuberant-ctags
"let Tlist_Ctags_Cmd='<path_to_ctags>
set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

"website:
"https://sourceforge.net/projects/cscope/?source=typ_redirect
"./configure
"make && sudo make install
