set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'repeat.vim'
Plugin 'surround.vim'
Plugin 'SuperTab'
Plugin 'file-line'
Plugin 'grep.vim'
Plugin 'Tabular'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Syntastic'
Plugin 'The-NERD-tree'
Plugin 'EasyMotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'rainbow_parentheses.vim'
Plugin 'Solarized' " color-scheme
Plugin 'vimlatex'
Plugin 'OmniCppComplete'
" Plugin 'godlygeek/tabular' " for markdown
Plugin 'plasticboy/vim-markdown' " for markdown
" Plugin 'spellcheck.vim'

" Plugin 'ntpeters/vim-better-whitespace'

" tComment
Plugin 'tComment'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let mapleader=','
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" inoremap <C-U> <C-G>u<C-U>
" noremap j gj
" noremap k gk

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " The following to are have Vim jump to the last position when
  " reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  autocmd FileType text setlocal textwidth=78
else
  set autoindent    " always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <C-h> gT
nnoremap <C-l> gt
set nu

" map <F3> :execute "noautocmd vimgrep /" . expand("<cword>") . "/gj **/*." .  expand("%:e") <Bar> cw<CR>
map <F3> :execute "noautocmd vimgrep /" . expand("<cword>") . "/gj **/*." .  expand("%:e") <Bar> cw

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    "call CmdLine("noautocmd vimgrep " . '/'. l:pattern . '/gj' . ' **/*')
    "execute "noautocmd vimgrep " . '/'. l:pattern . '/gj' . ' **/*'
    execute "Rgrep -i " . l:pattern
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSearch('b')<CR>
vnoremap <silent> # :call VisualSearch('f')<CR>
vnoremap <silent> gv :call VisualSearch('gv') <Bar> cw<CR>

" set undodir=~/.vim/undodir
" set undofile
" set undolevels=1000 "maximum number of changes that can be undone
" set undoreload=10000 "maximum number lines to save for undo on a buffer reload

map <Tab> :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
set tabstop=2
set shiftwidth=2
set expandtab

set nobackup

autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

"nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>
nmap <Leader><space> :StripWhitespace<CR>

" map <leader>cc :botright cope<cr>
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
let g:Powerline_symbols = 'unicode'

autocmd QuickFixCmdPost *grep* cwindow
au FileType python  set tabstop=4 shiftwidth=4 textwidth=140 softtabstop=4

" cursor lines
set cursorcolumn
set cursorline

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

"Enable switching between buffers without having to save modifications
set hidden

" Solarized options
syntax enable
set background=dark
colorscheme solarized

" Add highlighting for function definition in C++
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()

" C++ omnicmpletion
au BufNewFile,BufRead,BufEnter *.cxx,*.h,*.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

" recognize files as C++
autocmd BufNewFile,BufReadPost *.h,*.cxx,*.cpp,*.hpp set filetype=cpp

" C++11 Syntastic support
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_include_dirs = ['/Users/lianghe/Documents/root/include']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"markdown highlight options
let g:vim_markdown_folding_disabled=1
" let g:vim_markdown_math=1 " for latex math

" spell checking for certain file extensions
autocmd BufRead,BufNewFile *.tex,*.txt,*.html,*.yml,*.md setlocal spell
