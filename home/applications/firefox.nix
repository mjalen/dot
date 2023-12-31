{ libs, pkgs, ... }: {

    # firefox stuffs

    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                    ublock-origin
                    sponsorblock
                    old-reddit-redirect
                ];
                search.order = [ "DuckDuckGo" ];
                settings = {
                    "identity.fxaccounts.enabled" = false;
                    "extensions.pocket.enabled" = false;
                    "extensions.autoDisableScopes" = 0;
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                    "extensions.activeThemeID" = "light-theme@mozilla.org";
                    "extensions.getAddons.cache.enabled" = false;
                };
                userChrome = ''
                @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");

                #TabsToolbar .titlebar-spacer[type="post-tabs"] {
                    display: none !important;
                }

                #TabsToolbar > .titlebar-buttonbox-container {
                    display: none !important;
                }
                '';
            };
        };
    };

}