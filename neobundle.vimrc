filetype off             " Turn off filetype plugins before bundles init

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let g:neobundle#types#git#clone_depth = 1
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Vimproc to asynchronously run commands (NeoBundle, Unite)
NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak'}}

NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'], 'autoload':{'commands':'Gitv'}}
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'

NeoBundle 'sirver/ultisnips' " snippets

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-lastpat' "a/ i/ highlighted text
NeoBundle 'kana/vim-textobj-fold' "az folding
NeoBundle 'kana/vim-textobj-entire' "ae ie current buffer
NeoBundle 'glts/vim-textobj-comment' "ac current comment
NeoBundle 'tpope/vim-abolish' ":%S/{dog,man}/{man,dog}
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'machakann/vim-highlightedyank'

NeoBundle 'rking/ag.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'mbbill/undotree' " shows all undo tree
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/tlib' " dependency for airline?
NeoBundle 'bling/vim-airline'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Valloric/YouCompleteMe', {'build' : {'mac': './install.sh', 'unix': './install.sh'}}
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'Raimondi/delimitMate' " auto close brackets

NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'mattn/emmet-vim'

NeoBundle 'groenewege/vim-less'
NeoBundleLazy 'othree/html5.vim', {'autoload': {'filetypes': ['html', 'css']}}
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'chrisyip/Better-CSS-Syntax-for-Vim'

NeoBundle 'w0rp/ale'
NeoBundleLazy 'flowtype/vim-flow', {'autoload': {'filetypes': 'javascript'}}
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'HerringtonDarkholme/yats.vim' " yet another typescript
NeoBundle 'Quramy/vim-js-pretty-template'
NeoBundle 'Chiel92/vim-autoformat'
NeoBundle 'dkarter/bullets.vim'

NeoBundle 'lyokha/vim-xkbswitch'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
