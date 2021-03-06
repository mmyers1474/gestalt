" Modeline and Notes {{
" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={{,}} foldlevel=0 foldmethod=marker nospell:
"
" This is the personal .vimrc file of Matthew Myers based
" off of Steve Francia's .vimrc file..
"
" While much of it is beneficial for general use, I would
" recommend picking out the parts you want and understand.
"
" Copyright 2016 Matthew Myers
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" }}

" Environment {{
    set nocompatible        " Must be first line

    " Identify platform {{
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }}

    " Variables {{
        if !WINDOWS()
            set shell=/bin/zsh
        endif

        " If the VIMHOME environment variable has not been set then check specific locations for the vim config folder and set it.
        if !expand($VIMHOME)
            let home=$HOME
            let locations=[
                        \ '.config/vim',
                        \ '.vim' ]
            for location in locations
                let fullpath = home ."/" .location
                if isdirectory(fullpath)
                    let $VIMHOME=fullpath
                    break
                endif
            endfor
        endif

        " Set a couple more helper variables.
        let $VIMWORK=$VIMHOME . "/work"

        " Setting up my custom runtimepath to accomodate my hidden configuration path.
        set runtimepath=$VIMHOME,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$VIMHOME/after
    " }}
" }}

" Fixes {{
    " Arrow Key Fix
    " https://github.com/spf13/spf13-vim/issues/780
    if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
        inoremap <silent> <C-[>OC <RIGHT>
    endif
" }}

" Early external configuration includes {{
    " Use before config if available
    if filereadable(expand("$VIMHOME/before.vim"))
        source $VIMHOME/before.vim
    endif

    " Use bundles config
    if filereadable(expand("$VIMHOME/bundles.vim"))
        source $VIMHOME/bundles.vim
    endif
" }}

" General {{
    set background=dark                             " Assume a dark background
    if !has('gui')
        set term=$TERM                              " Make arrow and other keys work
    endif
    filetype plugin indent on                       " Automatically detect file types.
    syntax on                                       " Syntax highlighting
    set mouse=a                                     " Automatically enable mouse usage
    set mousehide                                   " Hide the mouse cursor while typing
    scriptencoding utf-8

    "set autowrite                                  " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore                         " Allow for cursor beyond last character
    set history=1000                                " Store a ton of history (default is 20)
    set spell                                       " Spell checking on
    set hidden                                      " Allow buffer switching without saving
    set iskeyword-=.                                " '.' is an end of word designator
    set iskeyword-=#                                " '#' is an end of word designator
    set iskeyword-=-                                " '-' is an end of word designator
    set backup                                      " Backups are nice ...
    if has('clipboard')
        if has('unnamedplus')                       " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                                        " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
    if has('persistent_undo')
        set undofile                                " So is persistent undo ...
        set undolevels=1000                         " Maximum number of changes that can be undone
        set undoreload=10000                        " Maximum number lines to save for undo on a buffer reload
    endif
" }}

" Vim UI {{
    color antares                                           " Load a colorscheme
    set tabpagemax=15                                       " Only show 15 tabs
    set showmode                                            " Display the current mode
    set cursorline                                          " Highlight current line

    highlight clear SignColumn                              " SignColumn should match background
    highlight clear LineNr                                  " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr                            " Remove highlight color from current line number

    set backspace=indent,eol,start                          " Backspace for dummies
    set linespace=0                                         " No extra spaces between rows
    set number                                              " Line numbers on
    set showmatch                                           " Show matching brackets/parenthesis
    set incsearch                                           " Find as you type search
    set hlsearch                                            " Highlight search terms
    set winminheight=0                                      " Windows can be 0 line high
    set ignorecase                                          " Case insensitive search
    set smartcase                                           " Case sensitive when uc present
    set wildmenu                                            " Show list instead of just completing
    set wildmode=list:longest,full                          " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]                           " Backspace and cursor keys wrap too
    set scrolljump=5                                        " Lines to scroll when cursor leaves screen
    set scrolloff=3                                         " Minimum lines to keep above and below cursor
    set foldenable                                          " Auto fold code
    set list
    "set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set listchars=trail:•,extends:#,nbsp:.                  " Highlight problematic whitespace
    if has('cmdline_info')
        set ruler                                           " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)  " A ruler on steroids
        set showcmd                                         " Show partial commands in status line and
                                                            " Selected characters/lines in visual mode
    endif
    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif
" }}

" Formatting {{
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }}

" Key (re)Mappings {{
    let mapleader = ','
    let maplocalleader = '_'
    let s:spf13_edit_config_mapping = '<leader>ev'
    let s:spf13_apply_config_mapping = '<leader>sv'

"    nnoremap F1
"    nnoremap F2
    nnoremap    <silent> F3     :nohlsearch<CR>
    nnoremap    <silent> F4     :set invhlsearch<CR>
"    nnoremap F5
"    nnoremap F6
"    nnoremap F7
"    nnoremap F8
"    nnoremap F9
"    nnoremap F10
"    nnoremap F11 reserved for pastetoggle
"    nnoremap F12 reserved for full screen

    " Toggle search highlighting.
    "nmap <silent> <leader>/ :nohlsearch<CR>

    " Clear search highlighting
    "nmap <silent> <leader>/ :set invhlsearch<CR>

    " Needed for tmux and vim to play nice
    map <Esc>[A <Up>
    map <Esc>[B <Down>
    map <Esc>[C <Right>
    map <Esc>[D <Left>

    " Console movement
    cmap <Esc>[A <Up>
    cmap <Esc>[B <Down>
    cmap <Esc>[C <Right>
    cmap <Esc>[D <Left>

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_easyWindows = 1
    if !exists('g:no_easyWindows')
        map <C-J> <C-W>j<C-W>_
        map <C-K> <C-W>k<C-W>_
        map <C-L> <C-W>l<C-W>_
        map <C-H> <C-W>h<C-W>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_wrapRelMotion = 1
    if !exists('g:no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_fastTabs = 1
    if !exists('g:no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
" }}

" Load the plugins {{
    if filereadable(expand("$VIMHOME/plugins.vim"))
        source $VIMHOME/plugins.vim
    endif
" }}

" GUI Settings {{
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        "set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        elseif WINDOWS() && has("gui_running")
            source $VIMRUNTIME/mswin.vim
            behave mswin
            set guifont=Source\ Code\ Pro\ Light:h10
        endif
    else
        if &term == 'xterm' || &term == 'xterm-256color' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        " set term=builtin_ansi       " Make arrow and other keys work
    endif
" }}

" Functions {{
    " Initialize directories {{
        function! InitializeDirectories()
            let home = $HOME
            let work = $VIMHOME . '/work'
            let dir_list = {
                        \ 'backup': 'backupdir',
                        \ 'views': 'viewdir',
                        \ 'swap': 'directory' }
            if has('persistent_undo')
                let dir_list['undo'] = 'undodir'
            endif
            for [dirname, settingname] in items(dir_list)
                let directory = work . '/' . dirname
                if exists("*mkdir")
                    if !isdirectory(directory)
                        call mkdir(directory, 'p')
                    endif
                endif
                if !isdirectory(directory)
                    echo "Warning: Unable to create backup directory: " . directory
                    echo "Try: mkdir -p " . directory
                else
                    let directory = substitute(directory, " ", "\\\\ ", "g")
                    exec "set " . settingname . "=" . directory
                endif
            endfor
        endfunction
        call InitializeDirectories()
    " }}

    " Trigger background toggle between light and dark. {{
        function! ToggleBG()
            let s:tbg = &background
            " Inversion
            if s:tbg == "dark"
                set background=light
            else
                set background=dark
            endif
        endfunction
        noremap <leader>bg :call ToggleBG()<CR>
    " }}

    " Strip whitespace {{
        function! StripTrailingWhitespace()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
        noremap <leader>sw :call StripTrailingWhitespace()<CR>
    " }}

    " Smart Home key function {{
        " Pressing the home key will return the cursor either to the beginning of the line, or the
        " beginning of the text, if it's already at the beginning of the line.
        function! SmartHome()
            let first_nonblank = match(getline('.'), '\S') + 1
            if first_nonblank == 0
                return col('.') + 1 >= col('$') ? '0' : '^'
            endif
            if col('.') == first_nonblank
                return '0'  " if at first nonblank, go to start line
            endif
            return &wrap && wincol() > 1 ? 'g^' : '^'
        endfunction
        noremap <expr> <silent> <Home> SmartHome()
        imap <silent> <Home> <C-O><Home>
    " }}

    " Custom configuration file opener {{
        function! s:ExpandFilenameAndExecute(command, file)
            execute a:command . " " . expand(a:file, ":p")
        endfunction
        function! s:EditConfig()
            call <SID>ExpandFilenameAndExecute("tabedit", "$VIMHOME/.vimrc")
            call <SID>ExpandFilenameAndExecute("tabedit", "$VIMHOME/conf/before.vim")
            call <SID>ExpandFilenameAndExecute("tabedit", "$VIMHOME/conf/bundles.vim")
            call <SID>ExpandFilenameAndExecute("tabedit", "$VIMHOME/conf/before.vim")
            call <SID>ExpandFilenameAndExecute("tabedit", "$VIMHOME/conf/bundles.vim")
        endfunction
        execute "noremap " . "ec" . " :call <SID>EditConfig()<CR>"
        execute "noremap " . "rc" . " :source $VIMHOME/.vimrc<CR>"
    " }}

    " Shell command {{
        function! s:RunShellCommand(cmdline)
            botright new

            setlocal buftype=nofile
            setlocal bufhidden=delete
            setlocal nobuflisted
            setlocal noswapfile
            setlocal nowrap
            setlocal filetype=shell
            setlocal syntax=shell

            call setline(1, a:cmdline)
            call setline(2, substitute(a:cmdline, '.', '=', 'g'))
            execute 'silent $read !' . escape(a:cmdline, '%#')
            setlocal nomodifiable
            1
        endfunction
        command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
        " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }}

    " Initialize NERDTree as needed {{
        function! NERDTreeInitAsNeeded()
            redir => bufoutput
            buffers!
            redir END
            let idx = stridx(bufoutput, "NERD_tree")
            if idx > -1
                NERDTreeMirror
                NERDTreeFind
                wincmd l
            endif
        endfunction
    " }}
" }}

" Auto-commands {{
    " Filetype auto-commands {{
        " preceding line best in a plugin but here for now.
        au BufNewFile,BufRead *.coffee set filetype=coffee
        au BufNewFile,BufRead *.html.twig set filetype=html.twig

        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

        au FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer>
        "au FileType go autocmd BufWritePre <buffer> Fmt

        au FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2

        " Workaround vim-commentary for Haskell
        au FileType haskell setlocal commentstring=--\ %s

        " Workaround broken colour highlighting in Haskell
        au FileType haskell,rust setlocal nospell
    " }}
" }}

" Late external configuration includes {{
    if has('gui_running')
        if filereadable(expand("$VIMHOME/gvimrc.vim"))
            source $VIMHOME/gvimrc.vim
        endif
    endif
" }}
