cd ~/workspace/winwag/

nmap <silent> <Leader>t :CommandT ~/workspace/winwag/<CR>
nmap <silent> <Leader>b :CommandTBuffer<CR>
" Great sources & credits:
" gmarik's vimrc - https://github.com/gmarik/vimfiles/blob/master/vimrc
" durdn's vimrc - https://github.com/durdn/cfg/blob/master/.vimrc
" FactoryLab's Vim Git repo - https://github.com/factorylabs/vimfiles
" Example vimrc - http://www.vi-improved.org/vimrc.php
"
" Graphical cheat sheet - http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html

" Initialization
set nocompatible  " Disable vi compatibility (more efficient, and besides - we're using non-vi tricks here).

set fileformats=unix,dos,mac  " Set file end-of-line priority.

"set statusline=  " FIXME: Reset status line here.

behave xterm

filetype on
filetype plugin indent on  " Automatically detect file types, and enable file-type-specific plugins and indentation.

"VimOrganizer (ORGMODE for Vim)
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

"Vim LaTeX
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Plugin Bundles - http://vim-scripts.org/vim/scripts.html
" To install/update type  ':BundleInstall!'  <-- NOTE the exclamation mark '!'
" To clean ununsed plugins type ':BundleClean!'

" Plugin manager initialization
set runtimepath+=$HOME/.vim/vundle.git/ 

call vundle#rc()

" Git
Bundle "tpope/vim-fugitive.git"

" Colors
Bundle "altercation/vim-colors-solarized"
Bundle "nanotech/jellybeans.vim"
Bundle "desert256.vim"

" Syntax
Bundle "hsitz/VimOrganizer"
Bundle "jcf/vim-latex"
Bundle "vim-scripts/VOoM"
Bundle "tpope/vim-markdown"
Bundle "pangloss/vim-javascript"
Bundle "briangershon/html5.vim"
Bundle "digitaltoad/vim-jade"
Bundle "groenewege/vim-less"

"Bundle "ChrisYip/Better-CSS-Syntax-for-Vim"
Bundle "sukima/xmledit"
Bundle "css3"
Bundle "django.vim"
Bundle "python.vim--Vasiliev"
Bundle "indentpython.vim"
let python_highlight_all=1  " Enable all plugin's highlighting.
let python_slow_sync=1  " For fast machines.
let python_print_as_function=1  " Color 'print' function.

" Linting / Error correction
Bundle "scrooloose/syntastic"
"Bundle "oryband/syntastic"
let g:syntastic_enable_signs=1  " Show sidebar signs.
"let g:syntastic_auto_loc_list=1  " Auto open errors window upon detection.
set statusline+=%#warningmsg#  " Add Error ruler.
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nnoremap <silent> ` :Errors<CR>

" NOTE: For Javascript:
"    1. Install exuberant-ctags & Node.js using your favorite package manager,
"    2. Install Node Package Manager (npm): Execute `curl http://npmjs.org/install.sh | sh` - See http://npmjs.org for more info.
"    3. Install jshint: Execute `npm install jshint`
"    4. Create a .jshintrc file @ your HOME dir (~/). Example: https://github.com/oryband/dotfiles/blob/master/jshintrc
"    5. Overwrite .vim/bundle/syntastic/syntax_checkers/javascript.vim with this one: https://github.com/oryband/dotvim/blob/master/syntax_checkers/javascript.vim  TODO: Find a way to not need this line.

" Other plugins
Bundle "AutoTag"

Bundle "scrooloose/nerdcommenter"
Bundle "scrooloose/nerdtree"


Bundle "camelcasemotion"
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

Bundle "ShowMarks"
" Only show alphabetic marks.
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Marks will be shown in format of 'm[mark char]' e.g. 'mA'.
let g:showmarks_textlower="\.\t"
let g:showmarks_textupper="\.\t"
let g:showmarks_textother="\.\t"

Bundle "majutsushi/tagbar"
nnoremap <silent> \ :TagbarToggle<CR>

Bundle 'minibufexpl.vim'
let g:miniBufExplModSelTarget = 1  " Don't open buffer in a non-modifiable buffer (e.g. TagList window).
"let g:miniBufExplVSplit = 13  " Vertical column static width in chars
"let g:miniBufExplMaxSize = 2   " Vertical column max size.
"let g:miniBufExplForceSyntaxEnable = 1  " Use this if you encounter highlighting bugs (colors not changing).

Bundle "godlygeek/tabular"
Bundle "IndexedSearch"
Bundle "tpope/vim-unimpaired"
Bundle "AutoComplPop"


" Terminal / GUI
set t_Co=256  " Set terminal to display 256 colors.

if has("win32")  " Fix Windows specific encoding problem.
    set encoding=utf-8
endif


" Colors
set background=dark
colorscheme jellybeans
"colorscheme desert256
" let g:solarized_termcolors=256  " Use this if you don't use Solarized as your terminal colors.
"colorscheme solarized

function! GlobalColorSettings()  " Set global color settings, regardless of colorscheme currently in use.
    " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
    highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

    " TODO: colorscheme jellybeans only.
    highlight Operator term=underline ctermfg=215 guifg=#ffb964

    " Set cursor color to be like in jellybeans.vim colorscheme, but with black text (previously white).
    highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

autocmd colorscheme * call GlobalColorSettings()  " Call the global color settings on every colorscheme change.


" Formatting
set nowrap     " No line wrapping.
set linebreak  " Wrap at word.

set textwidth=0  " Desirable text width. Used for text auto-wrapping. 0 means no auto-wrapping.
autocmd FileType * set formatoptions=r,2  " Enable auto-wrapping comments, comment leader auto-insertion in <Insert> mode, auto-format paragraphs, keep last line indentation. Disable all other format options. NOTE: Requires 'set autoindent'. autocmd FileType is required since formatoptions i set differently for each fiel type (.c, .py, etc.).

set backspace=indent,eol,start  " Enable backspace key. Erase previously entered characters in insert mode.

set number " Show line numbers.
set numberwidth=5  " Width of numbers column.


" Syntax
syntax on  " Syntax highlighting.
autocmd BufWinEnter,FileType html setfiletype htmldjango  " Special syntax for html+django.
autocmd BufWinEnter,FileType *.json,*jshintrc setfiletype javascript

set showmatch  " Show matching brace on insertion or cursor over.
set matchtime=3  " How many tenths of a second to wait before showing matching braces.
set matchpairs+=<:>  " Treat '<','>' as matching braces.


" Omni Completion
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS



" Indentation
set autoindent  " Automatically set the indent of a new line (local to buffer).
set smartindent
"set shiftround  " Round shift actions. i.e. When at 3 spaces, and I hit > ... go to 4, not 5. FIXME: Doesn't work.

" expandtab  = All tabs will be spaces.
" softabstop = How many spaces will a tab take when 'expandtab' is on.
" smarttab   = delete chunks of spaces like tabs.
" tabstop    = How many spaces is a tab (visually).
" shiftwidth = How many spaces will a 'shift' command take.
autocmd BufWinEnter,FileType *,python,javascript set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4  " This includes default behaviour.
autocmd BufWinEnter,FileType html,css            set expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2  " FIXME: Doesn't work.


" Searching
"set hlsearch  " Highlight search.
set smartcase  " Be case sensitive when input has a capital letter.
set incsearch  " Show matches while typing.
set ignorecase  " Ignore case when searching.


" Folding
set foldenable  " Turn on folding.
set foldmethod=marker  " Fold on the marker.
set foldlevel=100  " Don't autofold anything (but I can still fold manually).
set foldopen=block,hor,tag,percent,mark,quickfix  " Which movements open folds.


" Backup
set nobackup  " Disable file backup before file overwrite attempt.
set nowritebackup

"set undofile  " Keep undo actions even when a file (buffer) is closed.
"if has ("win32")  " Set undo files location.
    "set undodir=$HOME\vimfiles\undo
    "set undodir+=C:\tmp
    "set undodir+=C:\temp
    "set undodir+=.
"else
    "set undodir=$HOME/.vim/undo
    "set undodir+=/var/tmp
    "set undodir+=/tmp
    "set undodir+=.
"endif


" Window splitting
"set equalalways  " Multiple windows, when created, are equal in size. NOTE: Doesn't work well with MiniBufExpl.vim
set splitbelow splitright  " New windows are created to the bottom-right.


" Status Line
set shortmess=at  " Shortens messages in status line, truncates long messages.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.
set ruler  " Show file status ruler. NOTE: Doesn't work with buftabs.vim plugin.
"set ch=2  " Make command line two lines high


" Invisible characters.
if ! has("win32")
    set listchars=tab:▸\ ,trail:¬,eol:«  " Invisible characters.
    "set listchars=tab:°\ ,trail:·,eol:☠  " Alternate invisible characters.
endif
"set list  " Display invisible characters.
set nolist  " Don't display invisible characters.


" Mouse
set mouse=a  " Enable mouse.
"set mouse-=a  " Disable mouse.
set mousehide  " Hide mouse after chars typed.
behave xterm  " Make mouse behave like in xterm (instead of, e.g. Windows' command-prompt mouse).
set selectmode=mouse  " Enable visule selection with mouse.


" Bells
set novisualbell  " No blinking
"set noerrorbells  " No noise.
"set vb t_vb= " Disable any beeps or flashes on error


" Ignored files
set wildignore+=*.jpg,*.jpeg,*.png,*.gif  " Ignore images
set wildignore+=*.pdf  " Ignore PDF files
set wildignore+=*.pyc,*.pyo  " Ignore compiled Python files


" Key mappings
" Map arrow keys to window-change actions.
"map <Up> <C-w>k
"map <Down> <C-w>j
map <Left> <C-w>h
map <Right> <C-w>l

" Map up/down keys to page-up/down.
map <Up> <C-b>
map <Down> <C-f>


" General
let mapleader=","  " Set <leader> key to comma.

set history=256  " Number of things to remember in history.

set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).

"set autoread  " Reload file if changed outside of Vim (DANGEROUS!).

set clipboard+=unnamed  " Enable OS clipboard integration.

set hidden  " The current buffer can be put to the background without writing to disk.

autocmd BufWinEnter * lcd %:p:h  " Sets current-directory of current buffer/file. We avoid using `set autchdir` instead, because it can cause problems with some plugins.
"autocmd bufwritepost .vimrc source $MYVIMRC  " Source .vimrc after saving it.

" Search tag list from current dir up till root.
set tags=./tags;/

"set debug=msg  " Show Vim error messages.

"set timeoutlen=500  " Set key-combination timeout.

"set wildignorecase  " case-insensitive dir/file completion.

"Cut, copy and paste

vmap <C-c> "+yi
vmap <C-x> "+c
nmap <C-v> <ESC>"+p
imap <C-v> <ESC>"+pa

call pathogen#infect()

:vnoremap > >gv
:vnoremap < <gv

" Alternative using Tab/Shift-Tab (for gvim).
:vnoremap <Tab> >gv
:vnoremap <S-Tab> <gv


  Bundle 'tpope/vim-endwise'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-ragtag'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'msanders/snipmate.vim'
  Bundle 'ervandew/supertab'
  Bundle 'tomtom/tlib_vim'
  Bundle 'tomtom/tcomment_vim'
  Bundle 'tomtom/tselectbuffer_vim'
  Bundle 'tsaleh/vim-matchit'
  Bundle 'vim-scripts/taglist.vim'
  Bundle 'Townk/vim-autoclose'
  Bundle 'trapd00r/x11colors.vim'
  Bundle 'lilydjwg/colorizer'
  Bundle 'shemerey/vim-project'


" }}}
" General settings {{{

  set title
  set mouse=a

  set shortmess=at      " shorten error messages

  set nrformats+=alpha  " in-/decrease letters with C-a/C-x

  set modeline          " enable modelines
  set modelines=5

  set number            " enable line numbers
  set ruler             " enable something
  set cursorline        " enable hiliting of cursor line

  set backspace=2       " backspace over EOL etc.

  set background=dark   " i prefer dark backgrounds

  set hidden            " buffer switching should be quick
  set confirm           " ask instead of just print errors
  set equalalways       " make splits equal size

  set lazyredraw        " don't redraw while executing macros

  set noshowmode        " don't display mode, it's already in the status line

  let mapleader=","
  let maplocalleader=","
" }}}
" General Keybinds {{{

  " Set MapLeader
  let mapleader = ","

  " Delete previous word with C-BS
  imap <C-BS> <C-W>

  " Toggle Buffer Selection and list Tag Lists
  map <F2> <Esc>:TSelectBuffer<CR>
  map <F4> <Esc>:TlistToggle<CR>

   
  " Set text wrapping toggles
  nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR> 
   
  " Set up retabbing on a source file
  nmap <silent> <leader>rr :1,$retab<CR> 
   
  " cd to the directory containing the file in the buffer
  nmap <silent> <leader>cd :lcd %:h<CR> 
   
  " Make the directory that contains the file in the current buffer.
  " This is useful when you edit a file in a directory that doesn't
  " (yet) exist
  nmap <silent> <leader>md :!mkdir -p %:p:h<CR>


" }}}
" {{{ Window movement
  nmap <M-h> :winc h<CR>
  nmap <M-j> :winc j<CR>
  nmap <M-k> :winc k<CR>
  nmap <M-l> :winc l<CR>
" }}}
" GUI or no GUI, that's the question {{{
  if has('gui_running')
    set guicursor+=a:blinkon0       " Cursor doesn't blink - it's annoying
    set guioptions-=m               " No Menubar
    set guioptions-=T               " No Toolbar
    set guioptions-=l               " No Scrollbar left
    set guioptions-=L               " No Scrollbar left when split
    set guioptions-=r               " No Scrollbar right
    set guioptions-=r               " No Scrollbar right when split

    set laststatus=2                " always show statusline

    " set gfn=Pragmata\ 6.5
    set gfn=Neep\ Medium\ Semi-Condensed\ 9
    " set gfn=Mensch\ 7

    set lines=40                    " Height
    set columns=85                  " Width

    colorscheme nucolors

  else
    colorscheme jellybeans
endif
" }}}
" Status line {{{
  set laststatus=2      " always show statusline

  " Generic Statusline {{{
  function! SetStatus()
    setl statusline+=
          \%1*\ %f
          \%H%M%R%W%7*\ ┃
          \%2*\ %Y\ <<<\ %{&ff}%7*\ ┃
  endfunction

  function! SetRightStatus()
    setl statusline+=
          \%5*\ %{StatusFileencoding()}%7*\ ┃
          \%5*\ %{StatusBuffersize()}%7*\ ┃
          \%=%<%7*\ ┃
          \%5*\ %{StatusWrapON()}
          \%6*%{StatusWrapOFF()}\ %7*┃
          \%5*\ %{StatusInvisiblesON()}
          \%6*%{StatusInvisiblesOFF()}\ %7*┃
          \%5*\ %{StatusExpandtabON()}
          \%6*%{StatusExpandtabOFF()}\ %7*┃
          \%5*\ w%{StatusTabstop()}\ %7*┃
          \%3*\ %l,%c\ >>>\ %P
          \\ 
  endfunction " }}}

  " Update when leaving Buffer {{{
  function! SetStatusLeaveBuffer()
    setl statusline=""
    call SetStatus()
  endfunction
  au BufLeave * call SetStatusLeaveBuffer() " }}}

  " Update when switching mode {{{
  function! SetStatusInsertMode(mode)
    setl statusline=%4*
    if a:mode == 'i'
      setl statusline+=\ Einfügen\ ◥
    elseif a:mode == 'r'
      setl statusline+=\ Ersetzen\ ◥
    elseif a:mode == 'normal'
      setl statusline+=\ \ ◥
    endif
    call SetStatus()
    call SetRightStatus()
  endfunction

  au VimEnter     * call SetStatusInsertMode('normal')
  au InsertEnter  * call SetStatusInsertMode(v:insertmode)
  au InsertLeave  * call SetStatusInsertMode('normal')
  au BufEnter     * call SetStatusInsertMode('normal') " }}}

  " Some Functions shamelessly ripped and modified from Cream
  "fileencoding (three characters only) {{{
  function! StatusFileencoding()
    if &fileencoding == ""
      if &encoding != ""
        return &encoding
      else
        return " -- "
      endif
    else
      return &fileencoding
    endif
  endfunc " }}}
  " &expandtab {{{
  function! StatusExpandtabON()
    if &expandtab == 0
      return "tabs"
    else
      return ""
    endif
  endfunction "
  function! StatusExpandtabOFF()
    if &expandtab == 0
      return ""
    else
      return "tabs"
    endif
  endfunction " }}}
  " tabstop and softtabstop {{{
  function! StatusTabstop()

    " show by Vim option, not Cream global (modelines)
    let str = "" . &tabstop
    " show softtabstop or shiftwidth if not equal tabstop
    if   (&softtabstop && (&softtabstop != &tabstop))
    \ || (&shiftwidth  && (&shiftwidth  != &tabstop))
      if &softtabstop
        let str = str . ":sts" . &softtabstop
      endif
      if &shiftwidth != &tabstop
        let str = str . ":sw" . &shiftwidth
      endif
    endif
    return str

  endfunction " }}}
  " Buffer Size {{{
  function! StatusBuffersize()
    let bufsize = line2byte(line("$") + 1) - 1
    " prevent negative numbers (non-existant buffers)
    if bufsize < 0
      let bufsize = 0
    endif
    " add commas
    let remain = bufsize
    let bufsize = ""
    while strlen(remain) > 3
      let bufsize = "," . strpart(remain, strlen(remain) - 3) . bufsize
      let remain = strpart(remain, 0, strlen(remain) - 3)
    endwhile
    let bufsize = remain . bufsize
    " too bad we can't use "¿" (nr2char(1068)) :)
    let char = "b"
    return bufsize . char
  endfunction " }}}
  " Show Invisibles {{{
  function! StatusInvisiblesON()
    "if exists("g:LIST") && g:LIST == 1
    if &list
      if     &encoding == "latin1"
        return "¶"
      elseif &encoding == "utf-8"
        return "¶"
      else
        return "$"
      endif
    else
      return ""
    endif
  endfunction
  function! StatusInvisiblesOFF()
    "if exists("g:LIST") && g:LIST == 1
    if &list
      return ""
    else
      if     &encoding == "latin1"
        return "¶"
      elseif &encoding == "utf-8"
        return "¶"
      else
        return "$"
      endif
    endif
  endfunction " }}}
  " Wrap Enabled {{{
  function! StatusWrapON()
    if &wrap
      return "wrap"
    else
      return ""
    endif
  endfunction
  function! StatusWrapOFF()
    if &wrap
      return ""
    else
      return "wrap"
    endif
  endfunction
  " }}}
" }}}
" Tabstops {{{
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set autoindent
  set smartindent
  set expandtab
" }}}
" Invisibles {{{
  set listchars=tab:>\ ,eol:<
  set list
  nmap <silent> <F5> :set list!<CR>
" }}}
" Tabstops {{{
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set autoindent
  set smartindent
  set expandtab
" }}}
" Invisibles {{{
  set listchars=tab:>\ ,eol:<
  set list
  nmap <silent> <F5> :set list!<CR>
" }}}
" Folds {{{
  set foldmethod=marker
  set foldcolumn=1
  " au BufWinLeave * mkview
  " au BufWinEnter * silent loadview
" }}}
" Pairings {{{
  set showmatch
" }}}
" Margins {{{
  set scrolloff=5
  set sidescroll=5
" }}}
" Search {{{
  set incsearch
  set ignorecase

  " Toggle that stupid highlight search
  nmap <silent> ,n :set invhls<CR>:set hls?<CR> 
" }}}
" Backup files {{{
  set nobackup
  set nowb
  set noswapfile
" }}}
" Completion {{{
  set wildmenu
  set wildmode=longest,full,list

  set ofu=syntaxcomplete#Complete
" }}}
" Snipmate {{{
  imap <tab> <C-r>=TriggerSnippet()<CR>
" }}}
" NERDTree {{{
  map <F3> :NERDTreeToggle<CR>

  let NERDTreeChDirMode = 2
  let NERDTreeShowBookmarks = 1
" }}}
" Wrapping {{{
  set linebreak
  set showbreak=↳\ 
" toggle wrapping
  nmap <silent> <F12> :let &wrap = !&wrap<CR>
" }}}
" RagTag {{{
  imap <M-O> <Esc>o
  imap <C-J> <Down>
  let g:ragtag_global_maps = 1

  imap <C-Space> <C-X><Space>
  imap <C-CR> <C-X><CR>
" }}}
" 'Bubbling' {{{
  nmap <C-up> [e
  nmap <C-down> ]e
  vmap <C-up> [egv
  vmap <C-down> ]egv
" }}}
" Formatting with Par (gqip) {{{
  set formatprg=par\ -req
  nmap <F9> gqip
" }}}
" Pasting {{{
  set paste
  nnoremap p ]p
  nnoremap <c-p> p
" }}}
" Macros {{{
  " Execute macro "q" with space
  nmap <Space> @q
  " Map @ to + for more comfortable macros on DE kb layout
  nmap + @
" }}}


fun! RangerChooser()
silent !ranger --choosefile=/tmp/chosenfile `[ -z '%' ] && echo -n . || dirname %`
  if filereadable('/tmp/chosenfile')
    exec 'edit ' . system('cat /tmp/chosenfile')
    call system('rm /tmp/chosenfile')
  endif
  redraw!
endfun
map ,r :call RangerChooser()<CR


