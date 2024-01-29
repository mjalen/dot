{ inputs, pkgs, ... }: {
	programs.tmux = {
		enable = true;
		keyMode = "vi";
		shortcut = "a";
		mouse = true;
		baseIndex = 1;

		extraConfig = ''
			new-session -n $HOST
			bind r source-file ~/.config/tmux/tmux.conf

			# statusbar
			set -g status-position bottom
			set -g status-justify left
			set -g status-style 'fg=color2'
			set -g status-left ' ' 
			set -g status-right '%Y-%m-%d %H:%M '
			set -g status-right-length 50
			set -g status-left-length 10

			setw -g window-status-current-style 'fg=color0 bg=color1 bold'
			setw -g window-status-current-format ' #I #W #F '

			setw -g window-status-style 'fg=colour2 dim'
			setw -g window-status-format ' #I #[fg=color7]#W #[fg=color2]#F '

			setw -g window-status-bell-style 'fg=color2 bg=color1 bold'
		'';
	};
}
