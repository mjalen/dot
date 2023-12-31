{ libs, pkgs, ... }: 

let
    hashStr = builtins.hashString "sha256" "test2";
in
{

    # firefox stuffs

    programs.firefox = {
        enable = true;
        profiles = {
            "${hashStr}" = {
                isDefault = true;
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                    ublock-origin
                    sponsorblock
                    old-reddit-redirect
                ];
                search.default = "DuckDuckGo";
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