source ~/dotfiles/neobundle.vimrc

scriptencoding utf-8

set nocompatible
syntax on

" To use system clipboard as default
set clipboard=unnamed

set mouse=a
let mapleader = "\<space>"

" General options
set exrc secure             " Enable per-directory .vimrc files and disable unsafe commands in them

" Buffer options
set hidden                  " hide buffers when they are abandoned
set autoread                " auto reload changed files

" reloads all buffers on switching between windows, tabs, and cursor move
au FocusGained,BufEnter,CursorHold * :silent! checktime

" Display options
set novisualbell            " mute error bell
set list
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,nbsp:~
set linebreak               " break lines by words
set scrolloff=5
set scrolljump=1
set sidescroll=4
set sidescrolloff=10
set showcmd
set whichwrap=b,s,<,>,[,],l,h
set completeopt=menu,preview
set infercase
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set ttyfast                 " Optimize for fast terminal connections
set ttymouse=sgr
set shortmess=aOI           " Don’t show the intro message when starting Vim
set nostartofline
set number                  " Show line numbers
set cursorline

set wrap
" execute "set cc=".join(range(121,365), ',')

" Edit
set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
set virtualedit=block
set binary
set eol
set suffixesadd=.js,.ts,.tsx         " to open files without extension (es6 modules, requirejs, etc)
set timeoutlen=1000
set ttimeoutlen=0

"Backup files
silent !mkdir -p ~/tmp/swap
silent !mkdir -p ~/tmp/undo

set nobackup
set nowritebackup
set directory=~/tmp/swap//
set undodir=~/tmp/undo//
set swapfile
set undofile

" Tab options
set autoindent              " copy indent from previous line
set smartindent             " enable nice indent
set smarttab                " indent using shiftwidth"
set cindent
set expandtab               " tab with spaces
set shiftwidth=4            " number of spaces to use for each step of indent
set tabstop=4
set softtabstop=4           " tab like 4 spaces
set shiftround              " drop unused spaces

autocmd BufWrite *.ts,*.tsx :Autoformat
let g:autoformat_autoindent = 0

" disable folding for diff mode
autocmd FilterWritePre * if &diff | setlocal nofoldenable | endif
autocmd FilterWritePost * if &diff | setlocal nofoldenable | endif

" Search options
set gdefault                " Add the g flag to search/replace by default
set hlsearch                " Highlight search results
set ignorecase              " Ignore case in search patterns
set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
set incsearch               " While typing a search command, show where the pattern
nnoremap <silent> <cr> :nohlsearch<cr><cr>

" Matching characters
set showmatch               " Show matching brackets
set matchpairs+=<:>         " Make < and > match as well

" Localization
set keymap=russian-jcukenmac " Alternative keymap
set iminsert=0
set imsearch=0
set noshowmode

let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.dylib'
let g:XkbSwitchKeymapNames = {'0' : 'us', '1': 'ru'}
let g:XkbSwitchAssistNKeymap = 1
let g:XkbSwitchAssistSKeymap = 1

set encoding=utf-8           " Default encoding
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8
set fileformats=unix,dos,mac
set spell spelllang=ru_ru,en_us

" Wildmenu
set wildmenu                " use wildmenu ...
set wildcharm=<TAB>

" Folding
if has('folding')
    set foldmethod=indent
    set foldlevel=99
endif

set diffopt=filler
set diffopt+=vertical
set diffopt+=iwhite

set laststatus=2
set statusline=%F

augroup vimrc
  autocmd!

  autocmd FileType vim setlocal sw=2
  autocmd FileType vim setlocal ts=2
  autocmd FileType vim setlocal sts=2

  " Auto reload vim settings
  autocmd BufWritePost *.vim source $MYVIMRC
  autocmd BufWritePost *.vimrc source $MYVIMRC
  autocmd BufWritePost .vimrc source $MYVIMRC

  " Restore cursor position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
              \| exe "normal g'\"" | endif

  " Filetypes
  autocmd FileType less set ft=less.css

  autocmd BufRead,BufNewFile *.json set ft=javascript
  " autocmd BufRead,BufNewFile *.json set equalprg=python\ -mjson.tool
  autocmd BufRead,BufNewFile *.js set ft=javascript

  " Avoid syntax-highlighting for files larger than 10MB
  autocmd BufReadPre * if getfsize(expand("%")) > 10000*1024 | syntax off | endif

  autocmd BufReadPost fugitive://* set bufhidden=delete

augroup END

set background=dark
colorscheme gruvbox

" NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeWinSize=42
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMouseMode = 3
let g:NERDTreeBookmarksSort=0
" automatically close a tab if the only remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" delimitMate
let delimitMate_matchpairs = '(:),[:],{:}'
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

let g:airline_theme='gruvbox'
let g:airline_section_a=airline#section#create(['mode'])
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" unicode symbols
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:ycm_error_symbol = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = ''

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = { 'javascript': ['flow', 'eslint'] }

let g:gitgutter_enabled = 1
let g:gitgutter_diff_args = '-w'
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=250
set signcolumn=yes
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = ' '
let g:gitgutter_sign_modified = ' '
let g:gitgutter_sign_removed = ' _'
let g:gitgutter_sign_removed_first_line = ' ‾'
let g:gitgutter_sign_modified_removed = ' ‾'

let g:move_key_modifier = 'C'
let g:xml_syntax_folding = 0
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:used_javascript_libs = 'jasmine'

let g:colorizer_startup = 0
let g:colorizer_nomap = 1

" custom mapping
" search
nnoremap <leader>f mM:Ag<space><c-r><c-w><cr>
" view local history
nnoremap <leader>h :UndotreeToggle<cr>
" refresh
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>:GitGutterAll<CR><C-l>
nnoremap <silent> <C-t> :terminal++close<cr>
" current open buffers
nnoremap <silent> <leader>o :CtrlPBuffer<cr>
" browse oldfiles
nnoremap <silent> <leader>O :CtrlPMRUFiles<cr>
" NERDTree
" open and find current file
nmap <silent> <leader><space> :NERDTreeFind<CR>
" close nerdtree and quick fix windows
nmap <silent> <leader>c :NERDTreeClose<CR>:pclose<CR>

" git
" blame
nmap <silent> <leader>b :Gblame<cr>
" git history with info about index and remotes
nnoremap <leader>g :Gitv<cr>
" diff in visual mode of current file
nnoremap <silent> <leader>d :Gdiff<cr>
" open quick fix window with git status
nnoremap <silent> <leader>s :Gstatus<cr>
nnoremap <silent> <leader>> :diffget<cr>
nnoremap <silent> <leader>< :diffput<cr>
" resolving merge conflicts
nnoremap <silent> <leader>2 :diffget //2<cr>
" resolving merge conflicts
nnoremap <silent> <leader>3 :diffget //3<cr>
nnoremap <silent> <leader>l :ll<cr> " jump to current linting error (]l and [l to jump between them)
nnoremap <silent> <leader>n :lnext<cr> " jump to current linting error (]l and [l to jump between them)
nnoremap <silent> <leader>p :lprev<cr> " jump to current linting error (]l and [l to jump between them)
" preview current hunk
nnoremap <silent> <leader>v :GitGutterPreviewHunk<cr>
nnoremap <silent> <leader>N :GitGutterNextHunk<cr>
nnoremap <silent> <leader>P :GitGutterPrevHunk<cr>
nnoremap <silent> <leader>z :ColorToggle<cr>
nnoremap <silent> <leader>x :ToggleCheckbox<cr>
vnoremap <silent> <leader>x :'<,'>S/{[ ],[-],[x]}/{[x],[x],[ ]}<cr>:noh<cr>$
nnoremap <silent> <leader>- :normal I- [ ] <cr>$
vnoremap <silent> <leader>- :'<,'>normal I- [ ] <cr>$
" alternate file
nnoremap <silent> <leader>a :e #<cr>
" working with tabs
nnoremap <silent> gq :tabclose<cr>
nnoremap <silent> gn :tabnew<cr>
nnoremap <silent> go :tabonly<cr> " close other tabs
" mappings for flow and typescript
autocmd FileType javascript nnoremap <buffer> <silent> <leader>j :FlowJumpToDef<cr>
autocmd FileType javascript nnoremap <buffer> <silent> <leader>t :FlowType<cr>
autocmd FileType typescript nnoremap <buffer> <leader>u :YcmCompleter GoToReferences<cr>
autocmd FileType typescript nnoremap <buffer> <leader>r :YcmCompleter RefactorRename 
autocmd FileType typescript nnoremap <buffer> <silent> <leader>j :YcmCompleter GoToDefinition<cr>
autocmd FileType typescript nnoremap <buffer> <silent> <leader>t :YcmCompleter GetType<cr>

" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \]
let g:bullets_enable_in_empty_buffers = 1

"Search visual selection by *
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
nnoremap <silent> <leader>/ :<C-u>call <SID>SetSearch()<CR>/<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
function! s:SetSearch()
    let @/ = '\V' . substitute(escape(@+, '/\'), '\n', '\\n', 'g')
endfunction

"CtrlP
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ }

"ultiSnips
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsEditSplit="vertical"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:flow#enable = 0

augroup filetypedetect
    au BufRead,BufNewFile *.jsx setfiletype javascript
augroup END

let g:user_emmet_settings = {
\  'typescript' : {
\      'extends' : 'jsx',
\      'quote_char': "'",
\  },
\  'javascript' : {
\      'extends' : 'jsx',
\      'quote_char': "'",
\  },
\}
let g:user_emmet_expandabbr_key = '<C-e>'

" make cursor box in command mode and vertical bar in insert mode
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif

if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" encryption settings
set cryptmethod=blowfish2
au BufRead * if &key!= ""
    \ | setlocal nobackup history=0 nomodeline noshelltemp nowritebackup secure foldlevel=0 foldclose=all viminfo= noundofile
    \ | endif

au BufWritePost * if &key!= ""
    \ | setlocal nobackup history=0 nomodeline noshelltemp nowritebackup secure foldlevel=0 foldclose=all viminfo= noundofile
    \ | endif

hi YcmErrorSection cterm=underline
hi YcmWarningSection cterm=underline
hi SpellBad cterm=underline
hi SpellCap cterm=underline
hi Visual cterm=none ctermfg=white ctermbg=38
hi IncSearch cterm=none ctermfg=black ctermbg=220
hi Search cterm=none ctermfg=white ctermbg=5
hi MatchParen cterm=none ctermfg=white ctermbg=5
hi GitGutterAdd cterm=none ctermbg=darkgreen
hi GitGutterChange cterm=none ctermbg=darkblue
hi GitGutterChangeDelete cterm=none ctermbg=darkblue
hi Terminal ctermfg=white ctermbg=black
hi DiffAdd ctermfg=darkgreen ctermbg=black
hi DiffDelete ctermfg=red ctermbg=red
hi DiffChange ctermfg=darkblue ctermbg=black
hi DiffText ctermfg=blue ctermbg=black
hi EndOfBuffer cterm=none ctermfg=bg

source ~/.local.vimrc
