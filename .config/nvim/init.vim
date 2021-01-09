let mapleader = " "

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
    "Theme
    Plug 'arcticicestudio/nord-vim'

    "Status bar
    Plug 'itchyny/lightline.vim'

    Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'davidhalter/jedi-vim'
    Plug 'deoplete-plugins/deoplete-jedi'

    if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
  	Plug 'Shougo/deoplete.nvim'
  	Plug 'roxma/nvim-yarp'
  	Plug 'roxma/vim-hug-neovim-rpc'
    endif

    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

    Plug 'airblade/vim-gitgutter'

    Plug 'christoomey/vim-tmux-navigator'

    Plug 'psf/black', { 'branch': 'stable' }

    Plug 'fisadev/vim-isort'

    Plug 'jiangmiao/auto-pairs'

    Plug 'scrooloose/nerdcommenter'

call plug#end()

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']

let g:jedi#environment_path = "env"
let g:jedi#completions_enabled = 0

let g:deoplete#enable_at_startup = 1

colorscheme nord

set number
set relativenumber
set noshowmode

autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.py execute ':Isort'

set updatetime=100

"Custom key bindings
nnoremap <silent> <C-P> :Files<CR>
nnoremap <C-k><C-b> :NERDTreeToggle<CR>

