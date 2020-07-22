"
" Structure
"
" - Configure Vim's Options (via `set` directive)
" - Plugin Managment
" - Auto Commands
"

" Included because loading inside of Linux caused error:
" E474: Invalid argument: listchars=tab:»·,trail:·
scriptencoding utf-8
set encoding=utf-8

" Tell Vim how many colours are available
set t_Co=256

" Use the system clipboard
set clipboard+=unnamed

" Switch syntax highlighting on
syntax on

" Don't worry about trying to support old school Vi features
set nocompatible

" Disable Mouse (this is something that only recently affected me within NeoVim)
" Seemed using the mouse to select some text would make NeoVim jump into VISUAL mode?
set mouse=

" No backup files
set nobackup

" No write backup
set nowritebackup

" No swap file
set noswapfile

" Command history
set history=100

" Always show cursor
set ruler

" Show incomplete commands
set showcmd

" Incremental searching (search as you type)
set incsearch

" Highlight search matches
set hlsearch

" Makes searching case insensitive
" Note: if turned off, you can use \c at the end of your search phrase instead
set ignorecase

" When used in conjunction with ignorecase it causes Vim to search both case
" sensitive and case insensitive depending on whether your search uses all
" lowercase or any uppercase letters (e.g. foo will match foo and FOO, while
" Foo will match only Foo).
set smartcase

" Try to intelligently indent when creating a newline
set smartindent

" A buffer is marked as 'hidden' if it has unsaved changes, and it is not currently loaded in a window
" If you try and quit Vim while there are hidden buffers, you will raise an error:
" E162: No write since last change for buffer “a.txt”
set hidden

" Turn word wrap off
set nowrap

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Convert tabs to spaces
set expandtab

" Set tab size in spaces (this is for manual indenting)
set tabstop=2

" The number of spaces inserted for a tab (used for auto indenting)
set shiftwidth=2

" Turn on line numbers
set number

" Highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Always show status bar
set laststatus=2

" Set the status line to something useful
set statusline=%f\ %m\ %=L:%l/%L\ C:%c\ (%p%%)

" UTF encoding
set encoding=utf-8

" Autoload files that have changed outside of vim
set autoread

" Better splits (new windows appear below and to the right)
set splitbelow
set splitright

" Highlight the current line
set cursorline

" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
set wildmenu

" Redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" Highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" <C-x><C-k> for word autocomplete
set dictionary=/usr/share/dict/words

" Use Ag for :grep command (would use Sift but it doesn't work well)
set grepprg=ag\ --nogroup\ --nocolor

" Allow substitutions to dynamically be represented in the buffer
" https://asciinema.org/a/92207
:silent! set inccommand=nosplit

" Allow per-project configuration files
" See also `set secure` at the bottom of this file
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
"
" e.g. ./project/.vimrc
set exrc

" set foldlevel so when opening Markdown files we don't have to zR to open all
set foldlevel=100

" NetRW settings (see :NetrwSettings)
let g:netrw_winsize=-35 " Negative value is absolute; Positive is percentage (related to above mapping)
let g:netrw_localrmdir='rm -r' " Allow netrw to remove non-empty local directories
let g:netrw_fastbrowse=0 " Always re-evaluate directory listing
let g:netrw_hide=0 " Show ALL files
let g:netrw_list_hide= '^\.git,^\.DS_Store$' " Ignore certain files and directories
let g:netrw_sizestyle='h' " Human readable file sizes
let g:netrw_liststyle=3 " Set built-in file system explorer to use layout similar to the NERDTree plugin
                        " P opens file in previously focused window
                        " o opens file in new horizontal split window
                        " v opens file in new vertical split window
                        " t opens file in new tab split window

" recent update to Vim 8 has broken gx command that opens URL in web browser
" it should use the `open` command (provided by macOS, not shell builtin).
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>

" Plugin Managment
" https://github.com/junegunn/vim-plug#example
"
" Reload .vimrc and :PlugInstall to install plugins.
" Use single quotes as requested by vim-plug.
"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'chr4/nginx.vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'dense-analysis/ale'
Plug 'ekalinin/Dockerfile.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'ervandew/supertab'

" <C-x><C-o> for autocomplete via gocode
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'integralist/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'jamessan/vim-gnupg'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Tab to select multiple results
Plug 'm-kat/aws-vim'
Plug 'matze/vim-move'
Plug 'mileszs/ack.vim'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'
Plug 'python/black'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'sheerun/vim-polyglot'
Plug 'smerrill/vcl-vim-plugin'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/camelcasemotion'

" Initialize plugin system
call plug#end()

" Colour Scheme
let g:default_theme='gruvbox'
set background=dark
execute 'colorscheme ' . g:default_theme

" Function used by Lightline to show the current working directory
function! GetWorkingDirectory()
  return getcwd()
endfunction

" Function used by Lightline to modify each tab so it's named after the parent
" directory of the file being opened.
function! LightlineTabname(n) abort
  return fnamemodify(getcwd(tabpagewinnr(a:n), a:n), ':t')
endfunction

" Lightline Status Line Tweaks
"
" See documentation for details: https://github.com/itchyny/lightline.vim#advanced-configuration
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'working_dir', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'working_dir': 'GetWorkingDirectory',
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum', 'cwd' ],
      \   'inactive': [ 'tabnum', 'cwd' ]
      \  },
      \ 'tab_component_function': {
      \   'cwd': 'LightlineTabname'
      \  }
      \ }

" SuperTab
" have selection start at top of the list instead of the bottom
let g:SuperTabDefaultCompletionType = "<c-n>"

" ALE linting
"
" go vet options depends on installing extra command:
"
"   $ go install golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow
"
" ...just be sure to run that install outside of your projects directory,
" otherwise it'll add dependencies to your project go.mod accidentally.
"
let g:ale_go_govet_options = '-vettool=$(which shadow)'
let g:ale_linters = {'go': ['gopls']}
let g:ale_python_mypy_options = '--ignore-missing-imports --strict-equality'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '▲'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

nmap <silent> <leader>x :ALENext<cr>
nmap <silent> <leader>z :ALEPrevious<cr>

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_gopls_complete_unimported = 1
let g:go_gopls_staticcheck = 1
let g:go_metalinter_command='gopls'
let g:go_metalinter_deadline = '20s'

" vim-go: check if any expressions return an error type that aren't being handled
autocmd BufWritePost *.go :GoErrCheck! -ignoretests

" DISABLED... because it caused 10s blocking delay
"
" let g:go_metalinter_autosave = 1

" we use nsf/gocode & vim-go (which uses gocode) to handle autocomplete
" we setup insert mode to allow us to use a double forward slash for autocomplete
" opens a "preview" (i.e. scratch) window which can be closed using `pc`, `pclose`
autocmd FileType go imap /. <C-x><C-o>

" FZF (search files)
"
" Shift-Tab to select multiple files
"
" Ctrl-t = tab
" Ctrl-x = split
" Ctrl-v = vertical
"
" We can also set FZF_DEFAULT_COMMAND in ~/.bashrc
" Also we can use --ignore-dir multiple times
"
" Note use :map command to see current mappings (also :vmap, :nmap, :omap).
" Can also restrict to specific mapping `:map <Leader>w`
" https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping
map <leader>f :FZF<CR>
map <leader>b :Buffers<CR>
map <leader>g :GFiles?<CR>
map <leader>w :Windows<CR>
set wildignore+=*/.git/*,*/node_modules/*,*/.hg/*,*/.svn/*.,*/.DS_Store " Files matched are ignored when expanding wildcards
set wildmode=list:longest,list:full

" ack
let g:ackprg = 'ag --vimgrep --smart-case --ignore-dir=node_modules'

" vim-commentary
xmap <leader><leader><leader> <Plug>Commentary
nmap <leader><leader><leader> <Plug>Commentary
omap <leader><leader><leader> <Plug>Commentary
nmap <leader><leader><leader> <Plug>CommentaryLine

" camelcase
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" vim-move (<C-j>, <C-k> to move lines around more easily than :move)
let g:move_key_modifier = 'C'

" shortcut for quick terminal exit
:silent! tnoremap <Esc> <C-\><C-n>

" tabs
"
" note: I used to map <Tab> to gt but that caused <C-i> to break.
nnoremap <S-Tab> gT

" Auto Commands
" :h autocommand-events

fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

" Execute Python isort
autocmd BufWritePost *.py :execute '!isort %' | edit

" Execute Python autopep8
autocmd BufWritePost *.py :execute '!autopep8 --experimental --verbose --aggressive --aggressive --recursive --in-place %' | edit

" Execute Python unimport
autocmd BufWritePost *.py :execute '!unimport --remove %' | edit

" Execute Python Black formatter
" autocmd BufWritePost *.py :!Black --line-length 79 %
"
" Note: Black is disabled because it's a LOT more opinionated than Python's
" PEP-8 style guides. If I'm working on a side-project, then I'll run autopep8
" followed by Black using a project local .vimrc as per `set exrc`.

" Execute Terraform formatter on on current terraform file
autocmd BufWritePost *.tf :!terraform fmt %

autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd FileType sh,cucumber,ruby,yaml,zsh,vim setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType php,python setlocal shiftwidth=4 tabstop=4 expandtab

" See `:h fo-table` for details of formatoptions `t` to force wrapping of text
autocmd FileType python,ruby,go,sh,javascript setlocal textwidth=79 formatoptions+=t

" Specify syntax highlighting for specific files
autocmd BufRead,BufNewFile *.spv set filetype=php
autocmd BufRead,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?

" Change colourscheme when diffing
fun! SetDiffColours()
  highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
  highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
  highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
  highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endfun
autocmd FilterWritePre * call SetDiffColours()

" Map ± key to :nohlsearch (or :noh for short)
map ± :nohlsearch<CR>

" touch bar on new MacBook Pros suck, so avoid non-tactile Esc
imap § <Esc>

" This will prevent :autocmd, shell and write commands from
" being run inside project-specific .vimrc files (unless they’re owned by you).
"
" See above `set exrc`
set secure
