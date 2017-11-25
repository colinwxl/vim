source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Startup {{{
filetype indent plugin on

" vim 文件折叠方式为 marker
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END

"自动设当前编辑的文件所在目录为当前工作路径
exec 'cd ' .fnameescape('d:\vim')
set autochdir
" }}}

" General {{{ 
set nocompatible
set mouse=a " 启用鼠标 
set nu " 显示行号
set scrolloff=5 " 距离底部和底部5行
set pastetoggle=<F9>
set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" 禁止生成.un~文件
" set noundofile
" set nobackup
" set noswapfile
set undodir="C:/Users/colinwxl/.undodir"
" }}}

" Lang & Encoding {{{
" 设置编码自动识别, 中文引号显示 
"set fileencodings=utf-8,cp936,big5,euc-jp,euc-kr,latin1,ucs-bom 
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
" language messages zh_CN.UTF-8
" set ambiwidth=double
" }}}

" GUI {{{
" colorscheme Tomorrow-Night
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" Color scheme
set background=dark
colorscheme solarized
set cursorline
set hlsearch
set number
" 窗口大小
set lines=35
set columns=140
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
set nolist 
" set listchars=tab:\ ,eol:?,trail:·,extends:>,precedes:< 
set guifont=Inconsolata:h20:cANSI 
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0
" 文字字体格式和大小
" set guifont=Courier_new:h14:b:cDEFAULT
" }}}

" Format {{{
set autoindent
set smartindent
set tabstop=4
set expandtab
set softtabstop=4
set foldmethod=indent
set shiftwidth=4 
set backspace=2
set textwidth=79
syntax on
syntax enable
" }}}

" Vundle {{{
set nocompatible
filetype off 
" Plugins Management
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin()

" 可以在此次安装插件
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'alvan/vim-closetag'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'szw/vim-maximizer'
Plugin 'Yggdroot/indentLine'
Plugin 'dkprice/vim-easygrep'
Plugin 'scrooloose/nerdcommenter'
Plugin 'easymotion/vim-easymotion'
Plugin 'jlanzarotta/bufexplorer'
call vundle#end()
filetype plugin indent on
" }}}

" Plugin Setting {{{
" nerdTree
let NERDTreeWinPos='right'
let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>

" emmet
let g:user_emmet_expandabbr_key = '<c-tab>'
let g:user_emmet_settings = {'indentation': '    '}
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" ctrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*\\node_modules\\*,*.git*,*.svn*,*.zip*,*.exe* " 使用vim的忽略文件

" maximizer
nnoremap <silent><F3> :MaximizerToggle<CR>
vnoremap <silent><F3> :MaximizerToggle<CR>gv
inoremap <silent><F3> <C-o>:MaximizerToggle<CR>

" grep
" <leader>vv
nnoremap <c-f> :Grep<CR>

" nerdcommenter
let g:NERDSpaceDelims = 1
map <F4> <leader>ci <CR>

" bufexplorer
nnoremap <silent><F8> :BufExplorer<CR>

" taglist
map <silent> <F7> :TlistToggle<cr>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"tags
set tags=tags.exe

" winManager setting
let g:winManagerWindowLayout = "FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr>
"按f6打开左边格局
nmap <F6> :WMToggle<cr>

"Pydiction
filetype plugin on
let g:pydiction_location = 'E:\Program Files\Vim\vim80\ftplugin\complete-dict'

" w0rp/ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight ALEWarning ctermbg=DarkMagenta

" easymotion
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

au BufRead *.py map <buffer> <F5> :w<CR>:!python % <CR>

" }}}

" Function {{{
"按<F10>使用Firefox预览文件
nmap <F10> :call Preview()<CR>
func! Preview()
    if &filetype == 'markdown' || $filetype == 'md'
        exec "!firefox %"
    endif
endfunc
" }}}

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
