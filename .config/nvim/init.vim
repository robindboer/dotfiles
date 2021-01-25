if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Theme
Plug 'gruvbox-community/gruvbox'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tweekmonster/gofmt.vim'
Plug 'szw/vim-maximizer'
Plug 'airblade/vim-gitgutter'

Plug 'christoomey/vim-tmux-navigator'

Plug 'psf/black', { 'branch': 'stable' }

Plug 'fisadev/vim-isort'

call plug#end()

let mapleader = " "

colorscheme gruvbox

"Python autocmd's
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.py execute ':Isort'
autocmd FileType python setlocal completeopt-=preview

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

