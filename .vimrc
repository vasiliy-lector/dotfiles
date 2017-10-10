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
set expandtab               " tab with spaces
set shiftwidth=4            " number of spaces to use for each step of indent
set tabstop=4
set softtabstop=4           " tab like 4 spaces
set shiftround              " drop unused spaces
" let g:html_indent_inctags = "html,body,head,tbody"

" add ./src to path for case of absolute paths
let curPath = getcwd()
exec "set path+=".curPath."/src"

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
autocmd BufWritePost *.jsx,*.js,*.less,*.css call UpdateTags()

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

colorscheme solarized

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
let g:NERDTreeWinSize=47

" delimitMate
let delimitMate_matchpairs = '(:),[:],{:}'
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

let g:airline_theme='base16'
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
let g:gitgutter_updatetime = 250
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
let g:used_javascript_libs = 'react,jasmine'

" Neosnippet
" " Plugin key-mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
"
" " SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"
"
" " For snippet_complete marker.
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif
"
" let g:neosnippet#disable_runtime_snippets = {
"       \   '_' : 1,
"       \ }
"
" " Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
"
" " Tell Neosnippet about the other snippets
" let g:neosnippet#snippets_directory='~/.vim/snippets'

" custom mapping
nnoremap <silent> <leader>t :tabnew<cr>
nnoremap <silent> <leader>x :close<cr>
nnoremap <silent> <leader>q :tabclose<cr>
nnoremap <silent> <leader>w :w<cr>
" reload if changed
nnoremap <leader>f mM:Ag<space>
nnoremap <leader>u :UndotreeToggle<cr>
nnoremap <leader>G :Gitv<cr>
" git diff
nnoremap <silent> <leader>g :Gdiff<cr>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" nnoremap <silent> <leader>> :diffget<cr>
" nnoremap <silent> <leader>< :diffput<cr>
nnoremap <silent> <leader>2 :diffget //2<cr>
nnoremap <silent> <leader>3 :diffget //3<cr>
" :current open
nnoremap <silent> <leader>o :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
" :browse oldfiles
nnoremap <silent> <leader>O :Mru<cr>
nnoremap <silent> <leader>d :YcmCompleter GoToDefinition<cr>
nnoremap <silent> <leader>D :YcmCompleter GetType<cr>
nnoremap <silent> <leader>l :tabmove +1<cr>
nnoremap <silent> <leader>h :tabmove -1<cr>
nnoremap <silent> <leader>n :lnext<cr>
nnoremap <silent> <leader>p :lprev<cr>
nnoremap <silent> <leader>J :set ft=html<cr>
nnoremap <silent> <leader>j :set ft=javascript<cr>
nnoremap <silent> <leader>hn :GitGutterNextHunk<cr>
nnoremap <silent> <leader>hp :GitGutterPrevHunk<cr>
nnoremap <silent> <leader>hv :GitGutterPreviewHunk<cr>
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
" nnoremap <silent> <leader>S :setlocal spell spelllang=ru_ru,en_us<cr>

nnoremap <silent> <leader>s :FlowJumpToDef<cr>
nnoremap <silent> <leader>S :FlowType<cr>

nmap <silent> <leader><space> :NERDTreeFind<CR>
nmap <silent> <leader>c :NERDTreeClose<CR>
" nmap <silent> <leader><space> :NERDTreeTabsOpen<cr>:NERDTreeTabsFind<cr>
" nmap <silent> <leader>c :NERDTreeTabsToggle<cr>

" fugitive
nmap <silent> <leader>a :.Gblame<cr>
nmap <silent> <leader>A :Gblame<cr>

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

" let g:nerdtree_tabs_open_on_console_startup=1
" let g:nerdtree_tabs_smart_startup_focus=2
" let g:nerdtree_tabs_autofind=1

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

if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

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


hi EndOfBuffer cterm=none ctermfg=bg
hi TabLineFill cterm=none ctermfg=white ctermbg=16
hi TabLine cterm=none ctermfg=white ctermbg=16
hi VertSplit cterm=none ctermfg=16 ctermbg=16
hi StatusLine cterm=none ctermbg=16
hi StatusLineNC cterm=none ctermfg=16 ctermbg=16
hi TabLineSel cterm=none ctermfg=black ctermbg=7
hi Title cterm=none ctermfg=none ctermbg=none
hi MatchParen cterm=none ctermfg=white ctermbg=5
hi Visual cterm=none ctermfg=white ctermbg=38
hi IncSearch cterm=none ctermfg=black ctermbg=220
hi Search cterm=none ctermfg=white ctermbg=5
hi AleErrorSign cterm=none ctermfg=160 ctermbg=bg
hi AleWarningSign cterm=none ctermfg=220 ctermbg=bg
hi GitGutterAdd cterm=none ctermbg=2
hi GitGutterChange cterm=none ctermbg=4
hi GitGutterChangeDelete cterm=none ctermbg=4
hi GitGutterDelete cterm=none ctermfg=160 ctermbg=bg
hi SignColumn ctermbg=bg
hi clear CursorLineNR
hi CursorLineNR ctermbg=bg

" make cursor box in command mode and vertical bar in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
