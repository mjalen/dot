"" My Vim Configuration
syntax on
filetype on
filetype plugin indent on
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set backspace=indent,eol,start
set relativenumber
set undofile
set modelines=0
set mouse=a
set autoindent
set shiftwidth=4
set number
set wrap
set formatoptions=qrn1
set cursorline
" set cursorcolumn
set swapfile
set dir=~/tmp
set cc=125

set autoread
au CursorHold * checktime

call plug#begin('~/.vim/plugged')


Plug 'kyazdani42/nvim-web-devicons'
" Plug 'vim-airline/vim-airline'
"
" nvim-tree
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

" Colorscheme
Plug 'nyoom-engineering/oxocarbon.nvim'

" GLSL Highlighting
" Plug 'tikhomirov/vim-glsl'

" vimtex
" Plug 'lervag/vimtex'
" let g:vimtex_fold_enabled = 1
" let g:tex_flavor = 'latex'

" Intellisense
" Plug 'neoclide/coc.vim', {'branch': 'release'}

" fzf
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

" Bar Bar for tabs
" Plug 'romgrk/barbar.nvim'

" let bufferline = get(g:, 'bufferline', {})
" let bufferline.maximum_padding = 4

" Language server completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Git
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
" Plug 'tanvirtin/vgit.nvim'
Plug 'lewis6991/gitsigns.nvim'

" TODO comments
Plug 'folke/todo-comments.nvim'

" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Toggle Terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

" luasnip
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

" For ultisnips users.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Common Lisp
Plug 'vlime/vlime', {'rtp': 'vim/'}

call plug#end()

" GIT
lua << EOF
	require('gitsigns').setup {}
EOF

" LSP
lua << EOF
	require'lspconfig'.eslint.setup{}
	-- require'lspconfig'.clangd.setup{}
	require'lspconfig'.ccls.setup{}
	require'lspconfig'.glslls.setup{}
EOF

autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

" nvim-cmp
lua << EOF
	local cmp = require'cmp'

	cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('ultisnips').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

EOF

" Nvim Tree
lua << EOF
	require'nvim-tree'.setup{}
EOF

" Todo Comments
lua << EOF
  require("todo-comments").setup {
      signs = true,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
  }
EOF

" Toggle Terminal
lua << EOF
	require("toggleterm").setup{
		
	}
EOF

" Telescope
lua << EOF
    require('telescope').setup {}
EOF

" Lualine
lua << END
	require('lualine').setup {
		options = {
			icons_enabled = true,
			theme = "modus-vivendi",
			component_seperators = { left = '|', right = '|' },
			section_seperators = { left = '|', right = '|' }
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
	}
END

" Enable Color Theme
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Tree-Sitter
lua << EOF
	require('nvim-treesitter.configs').setup {
		ensure_installed = { "commonlisp", "vue", "javascript", "typescript", "c", "cpp", "glsl", "diff", "markdown", "latex", "make", "vim", "lua", "html", "css" },
		sync_install = false,
		highlight = {
			enable = true,
		},
	}
EOF

" Auto remove line numbers from terminal buffers.
autocmd TermOpen * setlocal nonumber norelativenumber

autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>

nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>

set background=dark
colorscheme oxocarbon 

au FocusLost * :wa
let setleader = ","
nnoremap ; :
nmap ,c :e ~/.config/nvim/init.vim<Enter>
nmap ,x \ll
nmap ,f :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>
nmap ,b :lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>
nmap ,g :lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>
nmap ,n :NvimTreeToggle<Enter>
nnoremap / :BLines<Enter>
nnoremap ,u :source $MYVIMRC<CR> 

tnoremap ,<Esc> <C-\><C-n>

