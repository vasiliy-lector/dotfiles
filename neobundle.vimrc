filetype off             " Turn off filetype plugins before bundles init

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let g:neobundle#types#git#clone_depth = 1
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Vimproc to asynchronously run commands (NeoBundle, Unite)
NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/unite.vim' " Unite. The interface to rule almost everything

NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'], 'autoload':{'commands':'Gitv'}}
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'sirver/ultisnips' " snippets

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-lastpat' "a/ i/ highlighted text
NeoBundle 'kana/vim-textobj-fold' "az folding
NeoBundle 'kana/vim-textobj-entire' "ae ie current buffer
NeoBundle 'glts/vim-textobj-comment' "ac current comment
NeoBundle 'tpope/vim-abolish' ":%S/{dog,man}/{man,dog}
NeoBundle 'yegappan/mru' "history files
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'

NeoBundle 'rking/ag.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'mbbill/undotree' " shows all undo tree
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/tlib' " dependency for airline?
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Valloric/YouCompleteMe', {'build' : {'mac': './install.sh', 'unix': './install.sh'}}
NeoBundle 'ap/vim-css-color'
" NeoBundle 'matze/vim-move' " move lines with <M-k> and <M-j>
NeoBundle 'Raimondi/delimitMate' " auto close brackets

NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'othree/javascript-libraries-syntax.vim'

NeoBundle 'groenewege/vim-less'
NeoBundleLazy 'othree/html5.vim', {'autoload': {'filetypes': ['html', 'css']}}
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'hail2u/vim-css3-syntax'

NeoBundle 'w0rp/ale'
NeoBundleLazy 'flowtype/vim-flow', {'autoload': {'filetypes': 'javascript'}}
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'HerringtonDarkholme/yats.vim' " yet another typescript
NeoBundle 'Quramy/vim-js-pretty-template'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
