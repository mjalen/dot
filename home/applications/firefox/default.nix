{ config, pkgs, ... }:

with config.valhalla.theme;
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
