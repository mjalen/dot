{ inputs, config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        settings = with config.valhalla.theme.dark; {
            enable_audio_bell = false;
            window_margin_width = 10;
            cursor_shape = "block";

			font_size = 12;
			font_family = "Victor Mono";
			bold_font = "auto";
			italic_font = "auto";
		    bold_italic_font = "auto"; 

		    background_opacity = "0.95";
            background_blur = 10;

            # color map 

			# Base16 {{scheme-name}} - kitty color config
			# Scheme by {{scheme-author}}
			background = base00; #{{base00-hex}}
			foreground = base05; #{{base05-hex}}
			selection_background = base05; #{{base05-hex}}
			selection_foreground = base00; #{{base00-hex}}
			url_color = base04; #{{base04-hex}}
			cursor = base05; #{{base05-hex}}
			active_border_color = base03; #{{base03-hex}}
			inactive_border_color = base01; #{{base01-hex}}
			active_tab_background = base00; #{{base00-hex}}
			active_tab_foreground = base05; #{{base05-hex}}
			inactive_tab_background = base01; #{{base01-hex}}
			inactive_tab_foreground = base04; #{{base04-hex}}
			tab_bar_background = base01; #{{base01-hex}}

			# normal
			color0 = base00; #{{base00-hex}}
			color1 = base08; #{{base08-hex}}
			color2 = base0B; #{{base0B-hex}}
			color3 = base0A; #{{base0A-hex}}
			color4 = base0D; #{{base0D-hex}}
			color5 = base0E; #{{base0E-hex}}
			color6 = base0C; #{{base0C-hex}}
			color7 = base05; #{{base05-hex}}

			# bright
			color8 = base03; #{{base03-hex}}
			color9 = base09; #{{base09-hex}}
			color10 = base01; #{{base01-hex}}
			color11 = base02; #{{base02-hex}}
			color12 = base04; #{{base04-hex}}
			color13 = base06; #{{base06-hex}}
			color14 = base0F; #{{base0F-hex}}
			color15 = base07;
        };
    }; 
}
