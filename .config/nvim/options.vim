scriptencoding utf-8

set timeoutlen=500

set updatetime=500

set noswapfile

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

set number relativenumber

set ignorecase smartcase

set linebreak
set showbreak=↪

set scrolloff=8

set mouse=nic
set mousemodel=popup
set mousescroll=ver:1,hor:0

set noshowmode

set confirm

set visualbell noerrorbells
set history=500

set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣

set autowrite

set undofile

set shortmess+=c

set shortmess+=S

set shortmess+=I

set completeopt+=menuone
set completeopt-=preview

set pumheight=10
set pumblend=10

set winblend=0

set shiftround

set synmaxcol=250
set nostartofline

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

set termguicolors

set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

set signcolumn=yes:1

set isfname-==
set isfname-=,

set nowrap
set noruler
