current-theme: { inputs, pkgs, ... }:

with current-theme;
{
    programs.kitty = {
        enable = true;
        # font = "Victor Mono"; 
        settings = {
            cursor = "#cccccc";
            cursor_text_color = "#111111";
            enable_audio_bell = false;
            window_margin_width = 10;
            cursor_shape = "block";

            background_blur = 10;

            # color map 
            background = black1;
            foreground = white1;

        } // (base16);
    }; 
}