" set our tabs to four spaces
set ts=4

" Keep our width to programmer width
set textwidth=79

set softtabstop=4

" set autoindent and ctrl-t/ctrl-d tabs to 4
set shiftwidth=4

" set vim to insert spaces rather than a tab char
set expandtab

" turn syntax highlighting on by default
syntax on

" set auto-indenting on for programming
set ai

" turn off compatibility with the old vi
set nocompatible

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

set hlsearch

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set binary noeol

" It's nice to have line and column numbers displayed
set ruler

" make that backspace key work the way it should
set backspace=indent,eol,start

colorscheme elflord
set background=dark

" Turn on autocompletion: hit CTRL-X CTRL-O to use
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Turn on indention plugins (I think) Right now I'm just using the python one
filetype plugin indent on

" Code folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Jump to last position in file
if has("autocmd")
	  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif
