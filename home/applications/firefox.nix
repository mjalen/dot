{ self, inputs, lib, pkgs, ... }: 

{
    # firefox stuffs

    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                isDefault = true;
                extensions = with pkgs.nur.overlay.repos.rycee.firefox-addons; [
                    ublock-origin
                    sponsorblock
                    old-reddit-redirect
                ];
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