" Modeline and Notes {{
" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={{,}} foldlevel=0
" foldmethod=marker nospell:
" }}

" Environment {{
    " Basics {{
        set nocompatible        " Must be first line
        exec "set viminfo+=n" .expand($VIMWORK). "/viminfo"
        set background=dark     " Assume a dark background
    " }}
    " Windows Compatible {{
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$VIMHOME,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$VIMHOME/after

          " Be nice and check for multi_byte even if the config requires
          " multi_byte support most of the time
          if has("multi_byte")
            " Windows cmd.exe still uses cp850. If Windows ever moved to
            " Powershell as the primary terminal, this would be utf-8
            set termencoding=cp850
            " Let Vim use utf-8 internally, because many scripts require this
            set encoding=utf-8
            setglobal fileencoding=utf-8
            " Windows has traditionally used cp1252, so it's probably wise to
            " fallback into cp1252 instead of eg. iso-8859-15.
            " Newer Windows files might contain utf-8 or utf-16 LE so we might
            " want to try them first.
            set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
          endif
        endif
    " }}

    let installplugins = 0
    let bundledir = $VIMHOME . "/bundles"
    let vundlepath = bundledir . "/vundle/autoload/vundle.vim"
    if !filereadable(vundlepath)
      if !isdirectory(bundledir)
        echo "Creating bundle directory."
        if exists("*mkdir")
          call mkdir(bundledir)
        else
          !mkdir -p bundledir
        endif
      endif
      echo "Downloading vundle from GitHub."
      echo
      silent !git clone https://github.com/gmarik/vundle.git "${VIMHOME}/bundles/vundle"
      echo
      let installplugins = 1
    endif

    " Setup Plugin Support {{
        " The next three lines ensure that the bundle system works
        filetype off
        exe 'set rtp+=' . expand('$VIMHOME/bundles/vundle')
        call vundle#rc(expand($VIMHOME . '/bundles'))
    " }}
" }}
" Bundles {{
    " Deps {{
        Plugin 'gmarik/vundle'
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'tomtom/tlib_vim'
        Plugin 'xolox/vim-misc'
        if executable('ag')
            Plugin 'mileszs/ack.vim'
            let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
        elseif executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
            Plugin 'mileszs/ack.vim'
        elseif executable('ack')
            Plugin 'mileszs/ack.vim'
        endif
    " }}
    " In your .vimrc.before.local file
    " list only the plugin groups you will use
    if !exists('g:plugin_groups')
        let g:plugin_groups=['commands', 'interface', 'language', 'completion', 'integrations',]
    endif
    " Commands {{
        if count(g:plugin_groups, 'commands')
            Plugin 'xolox/vim-session'
            Plugin 'tpope/vim-obsession'
            Plugin 'easymotion/vim-easymotion'
            Plugin 'terryma/vim-multiple-cursors'
            Plugin 'matchit.zip'
            Plugin 'tpope/vim-abolish.git'
            "Plugin 'tpope/vim-repeat'
            Plugin 'scrooloose/nerdcommenter'
        endif
    " }}
    " Interface {{
        if count(g:plugin_groups, 'interface')
            Plugin 'mattboehm/vim-accordion'
            Plugin 'bling/vim-bufferline'
            Plugin 'jeetsukumaran/vim-buffergator'
            Plugin 'fweep/vim-tabber'
            Plugin 'webdevel/tabulous'
            Plugin 'mbbill/undotree'
            Plugin 'powerline/fonts'
            Plugin 'vim-airline/vim-airline'
            Plugin 'vim-airline/vim-airline-themes'
            Bundle 'edkolev/tmuxline.vim'
            Plugin 'myusuf3/numbers.vim'
            Plugin 'nathanaelkane/vim-indent-guides'
            Plugin 'osyo-manga/vim-over'
            Plugin 'szw/vim-ctrlspace'
            "Plugin 'ctrlpvim/ctrlp.vim'
            "Plugin 'tacahiroy/ctrlp-funky'
            "Plugin 'wincent/command-t'
        endif
    " }}
    " Language {{
        if count(g:plugin_groups, 'language')
            Plugin 'klen/python-mode'
            Plugin 'scrooloose/syntastic'
            Plugin 'sheerun/vim-polyglot'
            Plugin 'airblade/vim-gitgutter'
        endif
    " }}
    " Completion {{
        if count(g:plugin_groups, 'completion')
            Plugin 'vitalk/vim-shebang'
            Plugin 'tpope/vim-surround'
            "Plugin 'valloric/youcompleteme'
        endif
    " }}
    " Integrations {{
        if count(g:plugin_groups, 'integrations')
            Plugin 'scrooloose/nerdtree'
            Plugin 'jistr/vim-nerdtree-tabs'
            Plugin 'tpope/vim-fugitive'
            Plugin 'low-ghost/nerdtree-fugitive'
            Plugin 'tpope/vim-vinegar'
            Plugin 'mattn/gist-vim'
            Plugin 'benmills/vimux'
        endif
    " }}
" }}

if (installplugins == 1)
    BundleInstall
endif
