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
            # "browser.toolbars.bookmarks.visibility" = "never";
            # "browser.fullscreen.autohide" = false;
            # "browser.newtab.extensionControlled" = false;
            # "browser.startup.homepage" = "file://${startpage}";
            #
            # "media.hardware-video-decoding.force-enabled" = true;
            # "general.smoothScroll.msdPhysics.enabled" = true;
            # "layout.frame_rate" = 60;
            # "layout.css.backdrop-filter.enabled" = true;
            #
            # "layout.css.devPixelsPerPx" = "-1.0";
            "devtools.chrome.enabled" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # # "browser.startup.homepage" = "file://${startpage}";
            # # "browser.newtabpage.enabled" = false;
            # # Normal useragent
            "general.useragent.override" =
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
            #
            # "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
            # "browser.uidensity" = 1;

            #   # remove useless stuff from the bar
            # "browser.uiCustomization.state" = ''
            #   {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_temporary-containers-browser-action","nixos_ublock-browser-action","nixos_ether_metamask-browser-action","nixos_cookie-autodelete-browser-action","screenshot-button","panic-button","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_sponsor-block-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_darkreader-browser-action","bookmarks-menu-button","nixos_df-yt-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","sponsorblocker_ajay_app-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","dontfuckwithpaste_raim_ist-browser-action","ryan_unstoppabledomains_com-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","save-to-pocket-button","fxa-toolbar-menu-button","nixos_absolute-copy-browser-action","webextension_metamask_io-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action","nixos_absolute-copy-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_unstoppable-browser-action","nixos_dontcare-browser-action","nixos_skipredirect-browser-action","nixos_ublock-browser-action","nixos_darkreader-browser-action","nixos_fb-container-browser-action","nixos_vimium-ff-browser-action","nixos_df-yt-browser-action","nixos_sponsor-block-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","dontfuckwithpaste_raim_ist-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","ryan_unstoppabledomains_com-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","webextension_metamask_io-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":29}
            # '';

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
            # "media.rdd-ffmpeg.enabled" = true;
            # "media.av1.enabled" = true;
            # "gfx.x11-egl.force-enabled" = true;
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
      # userContent = ''
      #   @import "/home/${user}/.config/firefoxcss/chrome/userContent.css";
      # '';

    };
    #     # see https://github.com/mozilla/policy-templates/blob/master/README.md
    #     extraPolicies = {
    #       ExtensionSettings = let
    #         mkForceInstalled = extensions:
    #           builtins.mapAttrs
    #           (name: cfg: { installation_mode = "force_installed"; } // cfg)
    #           extensions;
    #       in mkForceInstalled {
    #         "addon@darkreader.org".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    #         "uBlock0@raymondhill.net".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    #         "{36bdf805-c6f2-4f41-94d2-9b646342c1dc}".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/export-cookies-txt/latest.xpi";
    #         "{74145f27-f039-47ce-a470-a662b129930a}".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
    #         "{b86e4813-687a-43e6-ab65-0bde4ab75758}".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
    #         "DontFuckWithPaste@raim.ist".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
    #         "{c607c8df-14a7-4f28-894f-29e8722976af}".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
    #         "skipredirect@sblask".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
    #         "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    #         "vimium-c@gdh1995.cn".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
    #         "{47bf427e-c83d-457d-9b3d-3db4118574bd}".install_url =
    #           "https://addons.mozilla.org/firefox/downloads/latest/nighttab/latest.xpi";
    #       };
    #
    #       FirefoxHome = {
    #         Pocket = false;
    #         Snippets = false;
    #       };
    #       PasswordManagerEnabled = false;
    #       PromptForDownloadLocation = true;
    #       UserMessaging = {
    #         ExtensionRecommendations = true;
    #         SkipOnboarding = true;
    #       };
    # SanitizeOnShutdown = {
    # Cache = true;
    # History = true;
    # Cookies = true;
    # Downloads = true;
    # FormData = true;
    # Sessions = true;
    # OfflineApps = true;
    # };
  };
  # };
  # };
}
