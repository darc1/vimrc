set nocompatible
set backspace=indent,eol,start
set exrc

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/suda.vim'
Plug 'vim-airline/vim-airline'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'hashivim/vim-terraform'
Plug 'puremourning/vimspector', {'branch': 'master'}
"Plug 'puremourning/vimspector', {'branch': 'master', 'do': './install_gadget.py --enable-c --enable-python'}
Plug 'troydm/zoomwintab.vim'
Plug 'nvie/vim-togglemouse'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()


set exrc
set secure

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" mappings for window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <space>, :nohlsearch<CR>
nnoremap  <C-W> :W<CR>

"nnoremap <F5> :checktime<CR>
nnoremap q: <nop>
nnoremap q/ <nop>
nnoremap Q <nop>


autocmd FileType ts let b:coc_root_patterns = ['package-lock.json', 'node_modules/']
autocmd FileType typescript let b:coc_root_patterns = ['package-lock.json', 'node_modules/']

"set encoding=utf-8
"set fileencoding=utf-8
" ttymouse=sgr for tmux screen-256color terminal
"set ttymouse=sgr
set mouse=a


" -------------------------------------------------------------------------------------------------
" vim-terraform settings
" ------------------------------------------------------------------------------------------------
"

"Allow vim-terraform to align settings automatically with Tabularize.
let g:terraform_align=1

"Allow vim-terraform to automatically fold (hide until unfolded) sections of terraform code. Defaults to 0 which is off.
"let g:terraform_fold_sections=1

"Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt. You can also do this manually with the :TerraformFmt command.
let g:terraform_fmt_on_save=1


" -------------------------------------------------------------------------------------------------
" fzf.vim settings
" -------------------------------------------------------------------------------------------------
"

if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

map <C-f> :Files<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores --ignore .git -g ""'

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
set laststatus=2
set statusline+=%F
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" -------------------------------------------------------------------------------------------------
" onehalf-vim settings
" -------------------------------------------------------------------------------------------------
"

set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
"colorscheme onehalflight
"let g:airline_theme='onehalflight'
" lightline
" let g:lightline.colorscheme='onehalfdark'
"

" -------------------------------------------------------------------------------------------------
" nerdtree settings
" -------------------------------------------------------------------------------------------------
"

map <C-e> :NERDTreeToggle<CR>
map <C-S-e> :NERDTreeFind<cr>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -------------------------------------------------------------------------------------------------
" vim-airline settings
" -------------------------------------------------------------------------------------------------
"

let g:airline#extensions#tabline#enabled = 1


" -------------------------------------------------------------------------------------------------
" suda.vim settings
" -------------------------------------------------------------------------------------------------
"

let g:suda#prefix = ['suda://', 'sudo://', '_://']
" Open a current file with sudo
" :e suda://%

" Save a current file with sudo
" :w suda://%

" Edit /etc/sudoers
" :e suda:///etc/sudoers

" Read /etc/sudoers (insert content under the cursor)
" :r suda:///etc/sudoers

" Read /etc/sudoers at the end
" :$r suda:///etc/sudoers

" Write contents to /etc/profile
" :w suda:///etc/profile

" Save contents to /etc/profile
" :saveas suda:///etc/profile


" -------------------------------------------------------------------------------------------------
" coc.nvim settings
" -------------------------------------------------------------------------------------------------
"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <NUL> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <S-F12> <Plug>(coc-diagnostic-prev)
nmap <silent> <F12> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>fq  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"
" -------------------------------------------------------------------------------------------------
" vimspector settings
" -------------------------------------------------------------------------------------------------
"
" vim spector installed by downlading a release file into plugged dictionary.
"set pythonthreedll=/home/ubuntu/.pyenv/versions/3.8.3/lib/libpython3.8.so.1.0
"let g:vimspector_enable_mappings='HUMAN'
let g:vimspector_enable_mappings='VISUAL_STUDIO'
nmap <leader>dq :VimspectorReset<CR>

"execute 'source' g:plug_home. '/vimspector/support/custom_ui_vimrc'-
" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval"

nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
nmap <LocalLeader><F12> <Plug>VimspectorDownFrame

"
" -------------------------------------------------------------------------------------------------
" coc-prettier settings
" -------------------------------------------------------------------------------------------------
"
"
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"
" -------------------------------------------------------------------------------------------------
" coc-prettier settings
" -------------------------------------------------------------------------------------------------
"
"
command! -nargs=0 EslintAutofix :CocCommand eslint.executeAutofix

nnoremap fa :Prettier<CR> <bar> :EslintAutofix<CR><CR>
