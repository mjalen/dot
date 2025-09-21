{ config, pkgs, ... }:

with config.valhalla.theme;
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
		    extensions.force = true;
        extensions.packages =
          with pkgs.nur.repos.rycee.firefox-addons; [
            pwas-for-firefox
            ublock-origin
            sponsorblock
            old-reddit-redirect
            darkreader
          ];
        search = {
          default = "ddg html";
          engines = {
            "ddg html" = {
              urls = [{ template = "https://html.duckduckgo.com/html?q={searchTerms}"; }];
              icon = "https://html.duckduckgo.com/favicon.ico";
            };
            "opts" = {
              urls = [{
                template = "https://search.nixos.org/options?query={searchTerms}";
                icon = "https://search.nixos.org/favicon-96x96.png";
              }];
            };
            "pkgs" = {
              urls = [{
                template = "https://search.nixos.org/packages?query={searchTerms}";
                icon = "https://search.nixos.org/favicon-96x96.png";
              }];
            };
          };
        };
        settings = {
		      "general.autoScroll" = true;
		      "sidebar.verticalTabs" = true;
          "sidebar.main.tools" = [];
          "sidebar.visibility" = "expand-on-hover";
          "sidebar.expandOnHover" = true;
          "sidebar.animation.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "extensions.pocket.enabled" = false;
          "extensions.autoDisableScopes" = 0;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "extensions.getAddons.cache.enabled" = false;
          "media.rdd-ffmpeg.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.navigator.mediadatadecoder_vpx_enabled" = true;
          "gfx.webrender.all" = true;

          "browser.startup.blankWindow" = true;
          "browser.sessionstore.resume_session_once" = true;

          # Why would I want this?
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.server" = "<clear value>";
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
        };
        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };

}
