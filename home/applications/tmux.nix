{ inputs, pkgs, ... }: {
	programs.tmux = {
		enable = true;
		keyMode = "vi";
		shortcut = "a";
		# enableVim = true;
	};
}
