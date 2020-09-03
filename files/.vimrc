"
"   _/      _/  _/                      _/      _/  _/            _/
"  _/      _/      _/_/_/  _/_/        _/_/    _/      _/_/_/          _/_/_/
" _/      _/  _/  _/    _/    _/      _/  _/  _/  _/  _/    _/  _/  _/    _/
"  _/  _/    _/  _/    _/    _/      _/    _/_/  _/  _/    _/  _/  _/    _/
"   _/      _/  _/    _/    _/      _/      _/  _/  _/    _/  _/    _/_/_/
"                                                            _/
"                                                         _/
" Fix our indenting for python.
" These are all set by Pymode, but I may want them in for other languages.
" For some reason, if my indent/python.vim is missing, it inserts tabs anyway

" =========================================== Basics ==============================================

" Basic, sensible, VIM setup
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

" Turn on ft detection, plugins, and indentation
if has('autocmd')
	filetype plugin indent on
endif

" If we have syntax highlighting... USE IT.
if has('syntax') && !exists('g:syntax_on')
	syntax enable
endif

" set auto-indenting on for programming
set autoindent

" make that backspace key work the way it should
set backspace=indent,eol,start

" Use CTRL-P/CTRL-N completion, but don't scan 'included' files.
set complete-=i

" Visually highlight searches.
set hlsearch

" ...but use <C-L> to clear search highlights
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Have status (airline) appear all of the time.
set laststatus=2

" It's nice to have line and column numbers displayed
" But vim-airline status bar does this for us.
"set ruler

" Use hybrid line numbering (current line actual number, all other lines
" relative.
set number relativenumber

" Expand vim commands (i.e. : mode) with tab
set wildmenu

" Horizontal completion menu (keep hitting tab) for wildmenu
set wildmode=longest:full,full

" Always show at least one more line above/below cursor
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

" Show really really long lines (as much as possible in view) instead of `@`
set display+=lastline

set encoding=utf-8

" Commented out to see if I still want to do this!
" Possibly also replace with:
" https://github.com/tpope/vim-sleuth
" " set our tabs to four spaces
" set ts=4
" set softtabstop=4
" " set autoindent and ctrl-t/ctrl-d tabs to 4
" set shiftwidth=4
" " set vim to insert spaces rather than a tab char
" set expandtab

" Set our width to programmer width+
set textwidth=99

" turn off compatibility with the old vi
set nocompatible

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" Automatically show matching brackets.
set showmatch

" do NOT put a carriage return at the end of the last line! if you are
" programming for the web the default will cause http headers to be sent.
" that's bad.
set binary noeol

" Set spacebar to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Jump to last position in file from previous edit session.
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Use our zsh profile if shelling.
set shell=zsh

" Automatically save and reload views for folding while changing buffers
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent loadview
augroup END


" ========================================== Plugins! =============================================
" Download vim-plug 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Set up vim plugins using vim-plug
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'avakhov/vim-yaml'
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'keith/swift.vim'
Plug 'mattn/emmet-vim'
Plug 'nathangrigg/vim-beancount'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdtree'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'saltstack/salt-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" Pymode configuration

" Put pymode in python3 land
let g:pymode_python = 'python3'

" Pymode folding (still) considered "experimental"
" It seems to fold JUST the def line in a lot of salt funcs.
" Leaving off.
let g:pymode_folding = 0

" Configure the linters to use
let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'pep257', 'mccabe']

" Disable pylint check on every save
let g:pymode_lint = 1

" Disable pylint check on every save
let g:pymode_lint_on_write = 0

" For some reason pymode wants line length to be 80.
let g:pymode_options_max_line_length = 99

" This doesn't seem to have an effect.
let g:pymode_options_colorcolumn = 1

" ...so I have to do this.
hi ColorColumn ctermbg=Red
set cc=+1

" Rope never seems to work for me.
let g:pymode_rope = 0

" Add symbols: Needs a powerline patched font.
let g:airline_powerline_fonts = 1

" Configure vim-gitgutter
" I alias grep to use color by default.
let g:gitgutter_escape_grep = 1

" Bump up the number of signs gitgutter can add.
let g:gitgutter_max_signs = 5000

let g:beancount_separator_col = 79

" Only use emmet for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" FZF mapping to Ctrl+P
nmap <C-P> :Files<CR>
" FZF Ctrl+G for only git-controlled files.
nmap <C-G> :GFiles<CR>

" Open / close nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

" Automatically close NERDTree when you open a file
let NERDTreeQuitOnOpen = 1

" And close if only NERDTree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Vim-go configs
" Enable syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

" ====================================== Language Configs =========================================
" Turn on autocompletion: hit CTRL-X CTRL-O to use (omnifunc)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete

" Markdown

" Make sure Vim knows .md is markdown
au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
let g:vim_markdown_new_list_item_indent = 0

" Python

" Python debugger abbreviation (type pdb in insert mode)
au filetype python :iabbrev pdb import pdb; pdb.set_trace()

" Python main idiom (type ifname in insert mode)
au filetype python :iabbrev ifname if __name__ == "__main__":<CR>main()

" Use _ as a word boundary also.
" For python only right now
autocmd FileType python setlocal iskeyword-=_

" Code folding settings
" TODO: pymode folding is fancy... but doesn't work great.
autocmd FileType python setlocal foldmethod=indent nofoldenable foldlevel=0

" Go

" Shrink those go tabs to be less enormous
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go setlocal foldmethod=syntax nofoldenable foldlevel=0

" This gets a lot of work
au filetype go :iabbrev iferr if err != nil {<CR>return err<CR>}

" Autopkg Recipes

" And that AutoPkg recipes are XML
au BufRead,BufNewFile *.recipe set filetype=xml

" HTML
autocmd FileType html setlocal foldmethod=syntax nofoldenable foldlevel=0


" =========================================== Colors ==============================================

" I like dark terminals.
set t_Co=256
set background=dark
"colorscheme molokai
"colorscheme PaperColor
colorscheme dracula

" Fix the search color so it stands out from cursor
hi Search cterm=reverse ctermfg=DarkCyan ctermbg=Yellow


" ==================================== Fancy Keyboard Magic =======================================

" Add changelog date or timestamp with F5/F6
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d %T")<CR>P
inoremap <F6> <C-R>=strftime("%Y-%m-%d %T")<CR>

" Add mappings to copy to system clipboard with vim -clipboard.
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" Toggle between tw=100 and 73, and tell us.
nnoremap tw :let &textwidth = (&textwidth / 99 == 1 ? 72 : 99)<CR>:set textwidth?<CR>

" Search for current visual selection
vnoremap // y/<C-R>"<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>