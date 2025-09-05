set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Ruby / Rails
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'jgdavey/vim-blockle'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-rake'

" General Editing
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kana/vim-textobj-user'
Plugin 'Julian/vim-textobj-variable-segment'
Plugin 'kana/vim-textobj-line'
Plugin 'thinca/vim-textobj-between'
Plugin 'tpope/vim-unimpaired'
Plugin 'sjl/gundo.vim'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'nertzy/j-split'
Plugin 'matt-royal/diffthese'
Plugin 'camelcasemotion'
Plugin 'nertzy/edit-plus'
Plugin 'brysgo/quickfixfix'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'regreplop.vim'
Plugin 'Peeja/insert_mode_background_color'
Plugin 'vim-scripts/L9'
Plugin 'Peeja/vim-cdo'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'YankRing.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-projectionist'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'junegunn/fzf.vim'

" Window Management
Plugin 'ZoomWin'

" Searching
Plugin 'mileszs/ack.vim'
Plugin 'epmatsw/ag.vim'
Plugin 'tpope/vim-abolish'
Plugin 'henrik/vim-qargs'
Plugin 'kien/ctrlp.vim'

" Navigation
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'k0kubun/vim-open-github'

" Languages
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'slim-template/vim-slim'
Plugin 'nono/vim-handlebars'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-cucumber'
Plugin 'quentindecock/vim-cucumber-align-pipes'
Plugin 'juvenn/mustache.vim'
Plugin 'fatih/vim-go'
Plugin 'rosstimson/scala-vim-support'
Plugin 'guns/vim-clojure-static'
Plugin 'chrisbra/csv.vim'
Plugin 'elzr/vim-json'
Plugin 'briancollins/vim-jst'
Plugin 'digitaltoad/vim-jade'
Plugin 'mxw/vim-jsx'
Plugin 'lambdatoast/elm.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'digitaltoad/vim-pug'

" Development Tool Integration
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'pivotal/tmux-config'
Plugin 'tpope/vim-dispatch'
Plugin 'carlobaldassi/ConqueTerm'
Plugin 'sjl/vitality.vim'
Plugin 'brysgo/test_server'
Plugin 'mdelillo/vim-simple-bdd'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line