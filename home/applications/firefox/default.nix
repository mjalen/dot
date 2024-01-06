{ inputs, pkgs, ... }: 

{
    # firefox stuffs
    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                isDefault = true;
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                    ublock-origin
                    sponsorblock
                    old-reddit-redirect
		    darkreader
                ];
                settings = {
                    "identity.fxaccounts.enabled" = false;
                    "extensions.pocket.enabled" = false;
                    "extensions.autoDisableScopes" = 0;
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
					"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                    "extensions.getAddons.cache.enabled" = false;
					"media.rdd-ffmpeg.enabled" = true;
					"media.ffmpeg.vaapi.enabled" = true;
					"media.navigator.mediadatadecoder_vpx_enabled" = true;
                };
                userChrome = builtins.readFile ./userChrome.css;
            };
        };
    };

}
