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
    hm.programs = {
      librewolf = mkForce {
        enable = true;
        package = pkgs.librewolf;
        # Allow Kagi to store sign in for convenience
        policies = {
          Cookies = {
            Allow = [ "https://Kagi.com" ];
          };
        };
        profiles.cenunix = {
          name = "cenunix";
          isDefault = true;
          search = {
            engines = {
              "kagi" = {
                urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
                icon = "https://kagi.com/favicon.ico";
              };
              "bing".metaData.hidden = true;
            };
            force = true;
            default = "kagi";
            privateDefault = "kagi";
            order = [
              "kagi"
            ];
          };
          extensions = {
            force = true;
            packages = with addons; [
              ublock-origin
              bitwarden
              darkreader
              vimium-c
              purpleadblock
            ];
          };
          bookmarks = { };
          settings = {
            "extensions.autoDisableScopes" = 0;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.startup.homepage" = "about:config";
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
                PersonalToolbar = [ ];
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
          };
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
  };
}
