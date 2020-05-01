"Tenebrae's .vimrc file | date: 28.04.2020

set nocompatible              " required
filetype off                  " required

"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree'            " Project and file navigation
Bundle 'lpenz/vimcommander'
"------------------=== Colors ===----------------------
Plugin 'flazz/vim-colorschemes' "Themes pack
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes' " Lean & mean status/tabline for vim
"------------------=== Other ===----------------------
"Plugin 'rosenfeld/conque-term'      	" Consoles as buffers
Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
Plugin 'ervandew/supertab'
"---------------=== Languages support ===-------------
" --- Python ---
Bundle 'Valloric/YouCompleteMe'
Plugin 'klen/python-mode'               " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
"Plugin 'scrooloose/syntastic'
Plugin 'easymotion/vim-easymotion'
"Plugin 'davidhalter/jedi-vim'           " Jedi-vim autocomplete plugin
"Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

call vundle#end()                       " required
filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
" General settings
"=====================================================
colorscheme molokai " Тема оформления
let g:airline_theme='molokai' " Тема статусной строки
set cursorline " Подсвечивает строку с курсором
syntax on " Подсвечивать синтаксис
set showcmd " Показывает последнюю команду в правом углу
set noeb vb t_vb= " отключаем пищалку и мигание
set ruler " Показывать курсор все время
"set mouse=a
"set mousemodel=popup
"set mousehide
"  при переходе за границу в 80 символов в Python/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,c,cpp match Excess /\%80v.*/
    autocmd FileType python,c,cpp set nowrap
augroup END
" Настройка курсора ----------------------------------
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
\ if v:insertmode == 'i' |
\   silent execute '!echo -ne "\e[6 q"' | redraw! |
\ elseif v:insertmode == 'r' |
\   silent execute '!echo -ne "\e[4 q"' | redraw! |
\ endif
au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif
"-----------------------------------------------------
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"=============Search================================
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set smartcase
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
"====================================================
set showmatch "Показывает парные скобки
set number "Номера строк
"=====================================================
" User hotkeys
"=====================================================

" показать NERDTree на F3
map <F3> :NERDTreeToggle<CR>
"игноррируемые файлы с расширениями
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" проверка кода в соответствии с PEP8 через <leader>8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
" запускаем вим коммандер на ф9
noremap <silent> <F9> :cal VimCommanderToggle()<CR>

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
let g:pymode_lint_ignore = "E501,C0110,W0102,F0401,C0301"
" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = '<F1>'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" replace pdb to ipdb
iab ipdb import ipdb; ipdb.set_trace()


