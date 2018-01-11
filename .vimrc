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
" au FocusLost,WinLeave,CursorHold * :silent! w

" Display options
set title                   " show file name in window title
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
" execute "set cc=".join(range(141,365), ',')

" Edit
set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
" set virtualedit=block
set iskeyword+=-
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
" let g:html_indent_inctags = "html,body,head,tbody"

" add ./src to path for case of absolute paths
" let curPath = getcwd()
" exec "set path+=".curPath."/src"

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
" autocmd BufWritePost *.jsx,*.js,*.less,*.css call UpdateTags()

autocmd BufWrite *.ts,*.tsx :Autoformat
let g:autoformat_autoindent = 0

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
set langmenu=none            " Always use english menu
" set keymap=russian-jcukenmac " Alternative keymap
set langmap=ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,фa,ыs,вd,аf,пg,рh,оj,лk,дl,яz,чx,сc,мv,иb,тn,ьn,ж\\;,Ж\\:,б\\,ю.,Б\\<,Ю\\>,э\\',Э\\",х\\[,Х\\{,ъ\\],Ъ\\}

set iminsert=0               " English by default
set imsearch=-1              " Search keymap from insert mode
" set spell
set encoding=utf-8           " Default encoding
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8
set fileformats=unix,dos,mac

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
  autocmd FileType scss set ft=scss.css
  autocmd FileType less set ft=less.css
  autocmd! FileType sass,scss syn cluster sassCssAttributes add=@cssColors

  autocmd BufRead,BufNewFile *.json set ft=javascript
  " autocmd BufRead,BufNewFile *.json set equalprg=python\ -mjson.tool
  autocmd BufRead,BufNewFile *.js set ft=javascript

  " Avoid syntax-highlighting for files larger than 10MB
  autocmd BufReadPre * if getfsize(expand("%")) > 10000*1024 | syntax off | endif

  autocmd BufReadPost fugitive://* set bufhidden=delete

augroup END

set background=light
colorscheme gruvbox

" Unite

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec,file_rec/async,grep', 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/', 'node_modules/', 'libs/', 'log/'], '\|'))
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 10000)

let g:unite_source_buffer_time_format = ''
" let g:unite_enable_start_insert = 1
" let g:unite_split_rule = "botright"
" let g:unite_force_overwrite_statusline = 0
" let g:unite_winheight = 10
" let g:unite_candidate_icon="▷"

nmap <leader> [unite]
nnoremap [unite] <nop>

if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden -S'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-group --no-color'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
endif

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=0
let g:NERDTreeWinSize=42

" delimitMate
let delimitMate_matchpairs = '(:),[:],{:}'
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

let g:airline_theme='gruvbox'
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
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
nnoremap <silent> <C-t> :terminal++close<cr>source ~/.profile<cr><C-l>
" current open buffers
nnoremap <silent> <leader>o :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
" browse oldfiles
nnoremap <silent> <leader>O :Mru<cr>
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
" add hunk to index
nnoremap <silent> <leader>a :GitGutterStageHunk<cr>
" working with tabs
nnoremap <silent> gq :tabclose<cr>
nnoremap <silent> gn :tabnew<cr>
nnoremap <silent> go :tabonly<cr> " close other tabs
nnoremap <silent> g1 1gt
nnoremap <silent> g2 2gt
nnoremap <silent> g3 3gt
nnoremap <silent> g4 4gt
nnoremap <silent> g4 4gt
nnoremap <silent> g5 5gt
nnoremap <silent> g6 6gt
nnoremap <silent> g7 7gt
nnoremap <silent> g8 8gt
nnoremap <silent> g9 9gt
nnoremap <silent> g$ :tablast<cr>
" mappings for flow and typescript
autocmd FileType javascript nnoremap <buffer> <silent> <leader>j :FlowJumpToDef<cr>
autocmd FileType javascript nnoremap <buffer> <silent> <leader>t :FlowType<cr>
autocmd FileType typescript nnoremap <buffer> <leader>u :YcmCompleter GoToReferences<cr>
autocmd FileType typescript nnoremap <buffer> <leader>e :YcmCompleter RefactorRename 
autocmd FileType typescript nnoremap <buffer> <silent> <leader>j :YcmCompleter GoToDefinition<cr>
autocmd FileType typescript nnoremap <buffer> <silent> <leader>t :YcmCompleter GetType<cr>

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

" Helpers for snipmate
" so ~/.vim/snippets/support_functions.vim

" Slime-vim
" Typical settings for tmux:
" socket: "default"
" pane: ":0.1"
if executable('tmux')
    let g:slime_target = "tmux"
endif
xmap gx <Plug>SlimeRegionSend
" WARN: netrwPlugin has the same mapping
nmap gx <Plug>SlimeParagraphSend

let g:goog_user_conf = {
            \ 'langpair': 'en|ru',
            \ 'v_key': 'T'
            \ }

if has('gui_running')
    source ~/.vim/.gvimrc
endif

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"ultiSnips
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsEditSplit="vertical"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:flow#enable = 0

function! SQLUpperCase()
    %s:\<analyze\>\|\<and\>\|\<as\>\|\<by\>\|\<desc\>\|\<exists\>\|\<explain\>\|\<from\>\|\<group\>\|\<in\>\|\<insert\>\|\<intersect\>\|\<into\>\|\<join\>\|\<limit\>\|\<not\>\|\<on\>\|\<order\>\|\<select\>\|\<set\>\|\<update\>\|\<where\>:\U&:i
endfunction

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

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

hi EndOfBuffer cterm=none ctermfg=bg
hi YcmErrorSection cterm=underline
hi YcmWarningSection cterm=underline
hi SpellBad cterm=underline
hi SpellCap cterm=underline
hi Visual cterm=none ctermfg=white ctermbg=38
hi IncSearch cterm=none ctermfg=black ctermbg=220
hi Search cterm=none ctermfg=white ctermbg=5
hi MatchParen cterm=none ctermfg=white ctermbg=5
hi GitGutterAdd cterm=none ctermbg=2
hi GitGutterChange cterm=none ctermbg=4
hi GitGutterChangeDelete cterm=none ctermbg=4
hi Terminal ctermfg=white ctermbg=black

" make cursor box in command mode and vertical bar in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif
