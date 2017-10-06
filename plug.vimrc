if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'Shougo/vimproc' " Vimproc to asynchronously run commands (Unite etc)
Plug 'Shougo/unite.vim' " Unite. The interface to rule almost everything

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', { 'on':'Gitv' }
Plug 'airblade/vim-gitgutter'

Plug 'sirver/ultisnips' " snippets

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-lastpat' "a/ i/ highlighted text
Plug 'kana/vim-textobj-fold' "az folding
Plug 'kana/vim-textobj-entire' "ae ie current buffer
Plug 'glts/vim-textobj-comment' "ac current comment
Plug 'tpope/vim-abolish' ":%S/{dog,man}/{man,dog}
Plug 'yegappan/mru' "history files
Plug 'Raimondi/delimitMate' " autoclose brackets
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'ervandew/supertab'
Plug 'vim-scripts/tlib' " dependency for airline?
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree' " shows all undo tree
Plug 'rking/ag.vim' " super fast search engine
Plug 'ctrlpvim/ctrlp.vim' " fuzzy search by file name

Plug 'matze/vim-move' " move lines with <M-k> and <M-j>

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'

Plug 'othree/html5.vim', { 'for': ['html', 'css'] }
Plug 'gregsexton/MatchTag'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'groenewege/vim-less'

Plug 'w0rp/ale' " async linting, typescript support

Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim' " yet another typescript

Plug 'Quramy/vim-js-pretty-template'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'Valloric/YouCompleteMe' " super plugin for completion, supports typescript, flow

call plug#end()
