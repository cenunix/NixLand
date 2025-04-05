{
  config,
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  device = config.modules.device;
  acceptedTypes = [
    "desktop"
    "laptop"
    "armlaptop"
  ];
  startpage = pkgs.substituteAll { src = ./startpage.html; };
  user = config.modules.system.username;
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    hm.programs.firefox = mkDefault {
      enable = true;
      package = with pkgs; wrapFirefox firefox-unwrapped { };
      profiles.cenunix.isDefault = true;
      profiles.cenunix = {
        search = {
          force = true;
          default = "Kagi";
          privateDefault = "Kagi";
          order = [
            "Kagi"
            "DuckDuckGo"
            "Google"
          ];
          engines = {
            "Kagi" = {
              urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://kagi.com/favicon.ico";
            };
            "Bing".metaData.hidden = true;
          };
        };
        extensions.packages = with addons; [
          ublock-origin
          bitwarden
          darkreader
          vimium-c
        ];
        bookmarks = { };
        settings = mkMerge [
          {
            "browser.startup.homepage" = "about:home";

            # Disable irritating first-run stuff
            "browser.disableResetPrompt" = true;
            "browser.download.panel.shown" = true;
            "browser.feeds.showFirstRunUI" = false;
            "browser.messaging-system.whatsNewPanel.enabled" = false;
            "browser.rights.3.shown" = true;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.uitour.enabled" = false;
            "startup.homepage_override_url" = "";
            "trailhead.firstrun.didSeeAboutWelcome" = true;
            "browser.bookmarks.restore_default_bookmarks" = false;
            "browser.bookmarks.addedImportButton" = true;

            # Disable crappy home activity stream page
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
            "browser.newtabpage.blocked" = lib.genAttrs [
              # Youtube
              "26UbzFJ7qT9/4DhodHKA1Q=="
              # Facebook
              "4gPpjkxgZzXPVtuEoAL9Ig=="
              # Wikipedia
              "eV8/WsSLxHadrTL1gAxhug=="
              # Reddit
              "gLv0ja2RYVgxKdp0I5qwvA=="
              # Amazon
              "K00ILysCaEq8+bEqV/3nuw=="
              # Twitter
              "T9nJot5PurhJSy8n038xGA=="
            ] (_: 1);
            # Disable some telemetry
            "app.shield.optoutstudies.enabled" = false;
            "browser.discovery.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.sessions.current.clean" = true;
            "devtools.onboarding.telemetry.logged" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.prompted" = 2;
            "toolkit.telemetry.rejected" = true;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.server" = "";
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.unifiedIsOptIn" = false;
            "toolkit.telemetry.updatePing.enabled" = false;

            # Disable fx accounts
            "identity.fxaccounts.enabled" = false;
            # Disable "save password" prompt
            "signon.rememberSignons" = false;
            # Harden
            "privacy.trackingprotection.enabled" = true;
            "dom.security.https_only_mode" = true;

            "devtools.chrome.enabled" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            "general.useragent.override" =
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";

            "browser.uiCustomization.state" = builtins.toJSON {
              currentVersion = 20;
              newElementCount = 5;
              dirtyAreaCache = [
                "nav-bar"
                "PersonalToolbar"
                "toolbar-menubar"
                "TabsToolbar"
                "widget-overflow-fixed-list"
              ];
              placements = {
                PersonalToolbar = [ "personal-bookmarks" ];
                TabsToolbar = [
                  "tabbrowser-tabs"
                  "new-tab-button"
                  "alltabs-button"
                ];
                nav-bar = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "urlbar-container"
                  "downloads-button"
                  "ublock0_raymondhill_net-browser-action"
                  "_testpilot-containers-browser-action"
                  "reset-pbm-toolbar-button"
                  "unified-extensions-button"
                ];
                toolbar-menubar = [ "menubar-items" ];
                unified-extensions-area = [ ];
                widget-overflow-fixed-list = [ ];
              };
              seen = [
                "save-to-pocket-button"
                "developer-button"
                "ublock0_raymondhill_net-browser-action"
                "_testpilot-containers-browser-action"
              ];
            };
          }

          (mkIf (config.modules.device.gpu == "nvidia") {
            "media.ffmpeg.vaapi.enabled" = true;
            "widget.dmabuf.force-enabled" = true;
          })
        ];
        # };
        userChrome = ''
          * {
            --button-bgcolor: #11111b !important;
            --lwt-accent-color: #07070b !important;
            --arrowpanel-background: #07070b !important;
            --input-bgcolor: #07070b !important;
            --toolbar-field-background-color: #07070b !important;
            --urlbarView-separator-color: #07070b !important;
            --toolbar-field-focus-background-color: #07070b !important;
            --toolbar-bgcolor: #07070b !important;
            --button-primary-color: #cdd6f4 !important;
            --button-hover-bgcolor: #11111b !important;
            --focus-outline-color: #07070b !important;
            --button-active-bgcolor: #07070b !important;
            --panel-separator-zap-gradient: linear-gradient(90deg, #181825 0%, #45475a 52.08%, #6c7086 100%);
            --arrowpanel-border-color: #cdd6f4 !important;
            --arrowpanel-color: #cdd6f4 !important;
            --input-color: #cdd6f4 !important;
            --toolbar-field-color: #cdd6f4 !important;
            --lwt-text-color: #cdd6f4 !important;
            --toolbar-color: #cdd6f4 !important;
            --toolbar-field-focus-color: #cdd6f4 !important;
            --newtab-text-primary-color: #cdd6f4 !important;
            --tab-selected-textcolor: #cdd6f4 !important;
            --tab-icon-overlay-fill: #cdd6f4 !important;
            --toolbarbutton-icon-fill: #cdd6f4 !important;
            --sidebar-text-color: #cdd6f4 !important;
            --button-primary-bgcolor: #cdd6f4 !important;
            --button-primary-hover-bgcolor: #cdd6f4 !important;
            --button-primary-active-bgcolor: #cdd6f4 !important;
            --urlbarView-highlight-color: #cdd6f4 !important;
            --urlbarView-highlight-background: #585b70 !important;
          }


          tab-close-button.close-icon {
            display: none;
            color: red;
          }
          #_c607c8df-14a7-4f28-894f-29e8722976af_-BAP {
             color: #07070b;
          }
          #TabsToolbar {
            background-color: #07070b !important;
          }
          #nav-bar {
            background-color: #07070b;
          }
          #tracking-protection-icon-container {
            background-color: #07070b;
          }
          #appMenu-multiView {
            background-color: #07070b !important;
          }
          .urlbar-page-action {
            background-color: #07070b;
          }
          .identity-box-button  {
            background-color: #07070b;
          }
          .urlbar-input-box {
            background-color: #07070b;
          }
          .tab-icon-image {
            display: none;
          }
          .tabbrowser-tab {
            color: #cdd6f4 !important;
            color-scheme: unset;
          }
          tab[selected="true"] > .tab-stack > .tab-background {
            background: #11111b !important;
          }
          tab:not([selected="true"]) > .tab-stack:hover > .tab-background {
            background: #11111b !important;
          }
          #firefox-view-button {
            list-style-image : url(nix-snowflake.svg) !important;
          }
        '';
      };
    };
  };
}
