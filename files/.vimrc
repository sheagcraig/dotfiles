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

" Set our width to programmer width+
set textwidth=100

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

set encoding=utf-8

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
" set foldnestmax=10
set foldnestmax=1
set nofoldenable
set foldlevel=0
" set foldlevel=1
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
" As well as SavingThrow ADF's
au BufRead,BufNewFile *.adf set filetype=xml

" Pathogen load
filetype off
" Turn on indention plugins.
filetype plugin indent on
syntax on

" Put pymode in python3 land
let g:pymode_python = 'python3'
" Disable pylint check on every save
let g:pymode_lint = 0
" Disable pylint check on every save
let g:pymode_lint_on_write = 0
" For some reason pymode wants line length to be 80. Pep8 says 79.""
let g:pymode_options_max_line_length = 100
" This doesn't seem to have an effect.
let g:pymode_options_colorcolumn = 1
" ...so I have to do this.
hi ColorColumn ctermbg=Red
set cc=+1
" Rope drives me nuts.
let g:pymode_rope = 0

" Colors! I like writing to dark terminals.
set t_Co=256
set background=dark
"colorscheme liquidcarbon
"colorscheme elflord
"colorscheme nu42dark
"colorscheme gentooish
colorscheme molokai
" Fix the search color so it stands out from cursor
hi Search cterm=reverse ctermfg=DarkCyan ctermbg=Yellow

" Have airline appear all of the time.
set laststatus=2
" Add symbols: Needs a powerline patched font.
let g:airline_powerline_fonts = 1

" Configure vim-gitgutter
" I alias grep to use color by default.
let g:gitgutter_escape_grep = 1
" Bump up the number of signs gitgutter can add.
let g:gitgutter_max_signs = 5000

" Use our bash profile if shelling.
set shell=bash\ -l

" Only use emmet for html/css
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall

" Add changelog date or timestamp with F5
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d %T")<CR>P
inoremap <F6> <C-R>=strftime("%Y-%m-%d %T")<CR>

" Add mappings to copy to system clipboard with vim -clipboard.
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" Toggle between tw=79 and 73, and tell us.
nnoremap tw :let &textwidth = (&textwidth / 79 == 1 ? 72 : 79)<CR>:set textwidth?<CR>

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

" Python debugger abbreviation (type pdb in insert mode)
au filetype python :iabbrev pdb import pdb; pdb.set_trace()
" Python main idiom (type ifname in insert mode)
au filetype python :iabbrev ifname if __name__ == "__main__":<CR>main()
