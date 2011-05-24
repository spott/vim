"""""""""""""""""""""""""""""""""""""""
" Vundle stuff:
"""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype on
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()

" Bundles!
if hostname() ==? 'serenity'
	Bundle 'Rip-Rip/clang_complete'
else
	Bundle 'OmniCppComplete'
endif
Bundle 'scrooloose/nerdtree'
Bundle 'taglist.vim'
Bundle 'sophacles/vim-outliner'
"Bundle 'motemen/git-vim'
Bundle 'fugitive.vim'
Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sessionman.vim' 
Bundle 'cpp.vim'


"""""""""""""""""""""""""""""""""""""""
" General stuff:
"""""""""""""""""""""""""""""""""""""""

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting, however, source
" my syntax files.
syntax enable

" wrap my lines...
set wrap linebreak

" Set tabstop to 4 and shiftwidth to 4
set tabstop=4
set shiftwidth=4
set noexpandtab

" Set undo levels
set ul=1000

" Autoread modified files:
set autoread

"Map the leader to ','
let mapleader = ","
let g:mapleader = ","

"edit vimrc easily
map <leader>ev :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" set encoding to utf8
set encoding=utf8
try
    lang en_US
catch
endtry
"""""""""""""""""""""""""""""""""""""""
" Killring in vim...
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" C++/C programming
"""""""""""""""""""""""""""""""""""""""
au filetype c++ set cindent
au filetype c set cindent
au filetype ch set cindent

"comment using <leader>cc
""vnoremap <leader>cc  <ESC>`>a*/<ESC>`<i/*<ESC>
vnoremap <leader>cc  <Esc>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Comment(fl, ll)<CR>
nnoremap <leader>cc  I//<ESC>


function! Comment(fl,ll)
	let i=a:fl
	let a:start=0
	let a:commented=0
	while i<=a:ll
		if (getline(i) =~ '/\{-}\/\*.*' && a:start==0)
			exec(i.'s/\/\*//')
			let a:start=1
			let a:commented=1
		endif
		if (getline(i) =~ '/\{-}\*\/')
			exec(i.'s/\*\///g')
			let a:commented=1
		endif
		let i+=1
	endwhile
	if !a:commented
		exec(a:fl.'s/^/\/\*/')
		exec(a:ll.'s/$/\*\//')
	endif
endfunction

"""""""""""""""""""""""""""""""""""""""
" Quickfix stuff
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F4> :botright cwindow 5<CR>

"map <leader>cc :.cc<CR>


"""""""""""""""""""""""""""""""""""""""
" Search stuff
"""""""""""""""""""""""""""""""""""""""

" ignore the case when searching, unless a capitol letter is
" in the search string
set ignorecase 
set smartcase

" highlight the search values
set hlsearch

" set a leader shortcut to turn off highlighting:
map <leader>hl :nohlsearch<CR>

" Make search act like search in modern browsers
set incsearch 

"Show matching bracets when text indicator is over them
set showmatch 

"How many tenths of a second to blink
set mat=3 

"""""""""""""""""""""""""""""""""""""""
" UI stuff
"""""""""""""""""""""""""""""""""""""""

"colormode stuff
set background=dark

"highlight current line
set cul             

" for terminal, the titlebar will be set to the filename
set title

" show line, and column number in bottom
set ruler

" use the visualbell for errors
set visualbell

" wildmenu stuff.  when tab completing commandline stuff
set wildmenu
set wildmode=list:longest

if has("gui_running")
	set guioptions-=T "set no toolbar"
	colorscheme desert-edit
	set anti
	set window=51
	set lines=56 columns=205
	if hostname() ==? "serenity"
		set lines=60 columns=200
		set fu
		set fuoptions=maxhorz,maxvert
	endif
endif

"""""""""""""""""""""""""""""""""""""""
" Moving around
"""""""""""""""""""""""""""""""""""""""

" moving between windows easily
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" move to the next and previous error"
map cn <esc>:cn<cr>
map cp <esc>:cp<cr>

" keymaps for switching buffers
noremap <C-h> :bp<CR>
noremap <C-l> :bn<CR>

" allow backspacing over an indent, if you want to backspace over the start of
" indent, add 'start' to this list
set backspace=indent

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" Use the arrows to something usefull
map <right> :tabnext<cr>
map <left> :tabprevious<cr>

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

"""""""""""""""""""""""""""""""""""""""
" Plugin stuff
"""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Taglist
""""""""""""""""""""""""""""""
"look for tags
set tags=tags;/     

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/petsc
set tags+=~/.vim/tags/gsl
set tags+=~/.vim/tags/armadillo
set tags+=~/.vim/tags/blitz++
set tags+=~/.vim/tags/fftw

"set tags+=~/.vim/tags/ebasis

" build tags of your own project with Ctrl-F12

if hostname() ==? "serenity"
	map <C-F12> :!/usr/local/bin/ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
else
	map <C-F12> :!/usr/bin/ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
endif

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Display_Prototype = 1

" TODO: Change this when transfering
" change this to ctags directory
if hostname() ==? "serenity"
	let Tlist_Ctags_Cmd = "/usr/local/bin/ctags" 
else
	let Tlist_Ctags_Cmd = "/usr/bin/ctags" 
endif

"Toggle the sidebars
nnoremap <silent> <F2> :TlistToggle<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""
" => LaTeX suite stuff:
""""""""""""""""""""""""""""""
" These settings are needed for latex-suite
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
let g:Tex_ViewRule_pdf = 'open -a Preview'
set iskeyword+=:
"let g:Tex_Folding=0 "I don't like folding.


""""""""""""""""""""""""""""""
" => Omnicppcomplete
""""""""""""""""""""""""""""""



" OmniCppComplete (only for work comp?)
if hostname() !=? 'serentiy'
	au filetype c++ let OmniCpp_NamespaceSearch = 1
	let OmniCpp_GlobalScopeSearch = 1
	let OmniCpp_ShowAccess = 1
	au filetype c++ let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
	au filetype c++ let OmniCpp_MayCompleteDot = 1 " autocomplete after .
	au filetype c++ let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
	au filetype c++ let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
	let OmniCpp_DefaultNamespaces = ["std"]
	" automatically open and close the popup menu / preview window
	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
	set completeopt=menuone,menu,longest,preview
else
	let g:clang_use_library = 1
	let g:clang_complete_copen = 1
	let g:clang_library_path = '/Developer/usr/clang-ide/lib/libclang.dylib'
endif

"""""""""""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""""""""""

au filetype python set expandtab


"""""""""""""""""""""""""""""""""""""""
" Spell Checking
"""""""""""""""""""""""""""""""""""""""

"Pressing ,ss will toggle and untoggle spell checking
map <leader>sc :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""
" Autoclose different closable stuff
"""""""""""""""""""""""""""""""""""""""
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"autocmd Syntax html,vim inoremap < <lt>><Left>

inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap > <c-r>=ClosePair('>')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

"map the visually selected text
vnoremap (  <ESC>`>a)<ESC>`<i(<ESC>
vnoremap )  <ESC>`>a)<ESC>`<i(<ESC>
vnoremap {  <ESC>`>a}<ESC>`<i{<ESC>
vnoremap }  <ESC>`>a}<ESC>`<i{<ESC>
vnoremap "  <ESC>`>a"<ESC>`<i"<ESC>
vnoremap '  <ESC>`>a'<ESC>`<i'<ESC>
vnoremap `  <ESC>`>a`<ESC>`<i`<ESC>
vnoremap [  <ESC>`>a]<ESC>`<i[<ESC>
vnoremap ]  <ESC>`>a]<ESC>`<i[<ESC>

inoremap <expr> <BS> DeleteEmptyPairs()

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function! QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<Left>"
  endif
endf 

function! InAnEmptyPair()
  let cur = strpart(getline('.'),getpos('.')[2]-2,2)
  for pair in (split(&matchpairs,',') + ['":"',"':'"])
    if cur == join(split(pair,':'),'')
      return 1
    endif
  endfor
  return 0
endfunc

func! DeleteEmptyPairs()
    if InAnEmptyPair()
        return "\<Left>\<Del>\<Del>"
    else
        return "\<BS>"
    endif
endfunc

