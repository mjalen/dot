{ config, inputs, lib, pkgs, ... }: 

let
	hm = config.home.homeDirectory;

	# copy nvim configuration to store.
	nvim-config = pkgs.stdenv.mkDerivation {
		name = "nvim config";
		src = ./conf;
		buildInputs = with pkgs; [ coreutils ];
		
		buildPhase = "";
		
		installPhase = ''
			mkdir -p $out
			cp -r * $out/.
		'';
	};
in
{
	# This symlink is required for my fnl config to work 
	# I am symlinking my xdg config to the copied config files.
	systemd.user.tmpfiles.rules = [
		"L+ ${hm}/.config/nvim/ - - - - ${nvim-config}"
	];

	# change editor
	programs.bash.bashrcExtra = ''
		export EDITOR=vim
	'';

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		# my neovim config is done nearly exclusively in Fennel
		# so there is a simple lua script to use as a gateway.

		plugins = 
			with pkgs.vimPlugins; 
			with nvim-treesitter-parsers; 
			# with pkgs.nur.repos.m15a.vimExtraPlugins; # Having problems with deprecation here. 
		[
			# for fennel
			hotpot-nvim

			# line
			lualine-nvim
			indent-blankline-nvim
			# incline-nvim
			
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

			# glow
			glow-nvim

			# tree sitter
			nvim-treesitter
			cmp-treesitter
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
			markdown_inline
			nix
			rust

			# other	
			nvim-web-devicons
		];
	};
}
