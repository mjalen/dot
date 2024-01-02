{ inputs, lib, pkgs, ... }: {

	# This symlink is required for my fnl config to work 
	systemd.user.tmpfiles.rules = [
		"L+ /home/jalen/.config/nvim/fnl - - - - /home/jalen/Documents/dot/home/applications/nvim/conf/fnl"
	];

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		# my neovim config is done nearly exclusively in Fennel
		# so there is a simple lua script to use as a gateway.
		extraConfig = ''
			lua << EOF
			${builtins.readFile conf/init.lua}
		'';

		plugins = with pkgs.vimPlugins; with nvim-treesitter-parsers; [
			# for fennel
			hotpot-nvim

			# line
			lualine-nvim
			
			# language server
			nvim-lspconfig
			cmp-nvim-lsp
			cmp-buffer
			nvim-cmp

			# TODO LaTeX
			# vimtex

			# TODO snippets

			# telescope
			plenary-nvim
			telescope-nvim
			telescope-file-browser-nvim

			# toggle term
			toggleterm-nvim

			# theme
			oxocarbon-nvim

			# git
			gitsigns-nvim
			diffview-nvim

			# TODO lisp
			# add Olical/aniseed and conjure

			# tree sitter
			nvim-treesitter
			c
			cpp
			vue
			javascript
			html
			css
			vim
			lua
			fennel
			glsl
			diff
			commonlisp
			latex
			typescript
			markdown
			nix

			# other	
			nvim-web-devicons
		];
	};
}