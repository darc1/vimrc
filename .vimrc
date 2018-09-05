
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'burnettk/vim-angular'
Plug 'moll/vim-node'
Plug 'mileszs/ack.vim'
call plug#end()

" configure ack.vim to use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" close ack window after choosing result
let g:ack_autoclose = 1

nnoremap <C-b> :Ack -Q <cword><CR>

" ctrl+n to open nerd tree file explorer
map <C-n> :NERDTreeToggle<CR>

autocmd FileType nerdtree nmap <buffer> <CR> go

" close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctrl+f to find with fzf
map <C-f> :Files<CR>

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

nnoremap <C-t> :tabprevious<CR>
nnoremap <C-A-t>   :tabnext<CR>

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

let g:ycm_python_binary_path = '/usr/bin/python3'

let g:angular_skip_alternate_mappings = 1

