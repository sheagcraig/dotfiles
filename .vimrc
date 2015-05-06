" Fix our indenting for python.
" These are all set by Pymode, but I may want them in for other languages.
" For some reason, if my indent/python.vim is missing, it inserts tabs anyway
"
" set our tabs to four spaces
set ts=4
set softtabstop=4
" set autoindent and ctrl-t/ctrl-d tabs to 4
set shiftwidth=4
" set vim to insert spaces rather than a tab char
set expandtab
" set auto-indenting on for programming
set ai

" Keep our width to programmer width
set textwidth=79

" turn off compatibility with the old vi
set nocompatible

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" Visually highlight searches.
set hlsearch

" Automatically show matching brackets.
set showmatch

" do NOT put a carriage return at the end of the last line! if you are
" programming for the web the default will cause http headers to be sent.
" that's bad.
set binary noeol

" It's nice to have line and column numbers displayed
"set ruler

" make that backspace key work the way it should
set backspace=indent,eol,start

" Use _ as a word boundary also.
set iskeyword-=_

" Turn on autocompletion: hit CTRL-X CTRL-O to use
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" These are also managed by Pymode, but again, may be helpful elsewhere.
" Code folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
" Set spacebar to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Jump to last position in file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Make sure Vim knows .md is markdown
au BufRead,BufNewFile *.md set filetype=markdown
" And that AutoPkg recipes are XML
au BufRead,BufNewFile *.recipe set filetype=xml

" Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()

" Turn on indention plugins.
filetype plugin indent on
syntax on

" Disable pylint check on every save
let g:pymode_lint_on_write = 0
" For some reason pymode wants line length to be 80. Pep8 says 79.""
let g:pymode_options_max_line_length = 79
" This doesn't seem to have an effect.
let g:pymode_options_colorcolumn = 1
" ...so I have to do this.
hi ColorColumn ctermbg=Red
set cc=+1
" Rope drives me nuts.
let g:pymode_rope = 0

" Colors! I like writing to dark terminals.
set background=dark
"colorscheme liquidcarbon
"colorscheme elflord
colorscheme nu42dark
"colorscheme gentooish
"colorscheme molokai
" Fix the search color so it stands out from cursor
hi Search cterm=reverse ctermfg=LightGreen ctermbg=Yellow

" Have airline appear all of the time.
set laststatus=2
" Add symbols: Needs a powerline patched font.
let g:airline_powerline_fonts = 1

" Configure vim-gitgutter
" I alias grep to use color by default.
let g:gitgutter_escape_grep = 1

" Use our bash profile if shelling.
set shell=bash\ -l
