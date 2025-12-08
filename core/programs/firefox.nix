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
  colors = config.lib.stylix.colors.withHashtag;
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    hm.programs = {
      librewolf = mkForce {
        enable = true;
        package = pkgs.librewolf;
        policies = {
          Cookies = {
            Allow = [
              "https://Kagi.com"
              "https://discord.com"
              "https://github.com"
              "https://boot.dev"
              "https://proton.me"
              "https://openai.com"
              "https://youtube.com"
              "https://chatgpt.com"
            ];

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
            # "browser.startup.homepage" = "about:config";
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
              --button-bgcolor: ${colors.base01} !important;
              --lwt-frame: ${colors.base00} !important;
              --lwt-accent-color: ${colors.base00} !important;
              --panel-background: ${colors.base00} !important;
              --arrowpanel-background: ${colors.base00} !important;
              --input-bgcolor: ${colors.base00} !important;
              --toolbar-field-background-color: ${colors.base00} !important;
              --urlbarView-separator-color: ${colors.base00} !important;
              --toolbar-field-focus-background-color: ${colors.base00} !important;
              --toolbar-bgcolor: ${colors.base00} !important;
              --button-primary-color: ${colors.base05} !important;
              --button-hover-bgcolor: ${colors.base01} !important;
              --focus-outline-color: ${colors.base00} !important;
              --tabs-navbar-separator-color: ${colors.base00} !important;
              --chrome-content-separator-color: ${colors.base00} !important;
              --button-active-bgcolor: ${colors.base00} !important;
              --panel-separator-zap-gradient: linear-gradient(90deg, #181825 0%, #45475a 52.08%, #6c7086 100%);
              --arrowpanel-border-color: ${colors.base05} !important;
              --arrowpanel-color: ${colors.base05} !important;
              --input-color: ${colors.base05} !important;
              --toolbar-field-color: ${colors.base05} !important;
              --lwt-text-color: ${colors.base05} !important;
              --toolbar-color: ${colors.base05} !important;
              --toolbar-field-focus-color: ${colors.base05} !important;
              --newtab-text-primary-color: ${colors.base05} !important;
              --tab-selected-textcolor: ${colors.base05} !important;
              --tab-icon-overlay-fill: ${colors.base05} !important;
              --toolbarbutton-icon-fill: ${colors.base05} !important;
              --sidebar-text-color: ${colors.base05} !important;
              --button-primary-bgcolor: ${colors.base05} !important;
              --button-primary-hover-bgcolor: ${colors.base05} !important;
              --button-primary-active-bgcolor: ${colors.base05} !important;
              --urlbarView-highlight-color: ${colors.base05} !important;
              --urlbarView-highlight-background: ${colors.base04} !important;
              --sidebar-background: ${colors.base00} !important;
              --inactive-titlebar-opacity: 1.0 !important;
            }

            #TabsToolbar {
              visibility: collapse !important;
            }
            :root {
              --wide-tab-width: 300px;
              --thin-tab-width: 35px;
              --frame-bg: ${colors.base00};
              --toolbar-bg: ${colors.base00};
              --tabs-bg: ${colors.base00};
            }

            #sidebar-box > #browser,
            #webextpanels-window {
              background: var(--sidebar-background) !important;
            }

            /*Collapse in default state and add transition*/
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] {
              border-right: none !important;
              z-index: 2;
              border-right: none !important;
              width: 100% !important;
              background: var(--sidebar-background);

              /* lock sidebar to height by doing the inverse margin of the toolbar element */
              z-index: 1000 !important;
              position: relative !important;
              margin-top: 0px !important;
              border-right: none;
              transition: all 200ms !important;

              /* lock sidebar to specified width */
              min-width: var(--thin-tab-width) !important;
              max-width: var(--thin-tab-width) !important;
              overflow: hidden !important;
              transition-property: width;
              transition-duration: 0.3s;
              transition-delay: 0.3s;
              transition-timing-function: ease-in;
            }

            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]::after {
              background: #0b0e14 !important;
              margin-left: 207px;
              z-index: 9999999;
              position: absolute;
              content: " ";
              width: 1px;
              height: 100%;
              top: 0;
              right: 0px;
            }

            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover:after {
              top: 42px;
            }

            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover,
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]
              #sidebar:hover {
              min-width: var(--wide-tab-width) !important;
              max-width: var(--wide-tab-width) !important;
              margin-right: calc(
                (var(--wide-tab-width) - var(--thin-tab-width)) * -1
              ) !important;
              transition: all 200ms !important;
            }

            #sidebar-header {
              border: none !important;
              border-right: 1px solid var(--sidebar-border-color);
              background: var(--sidebar-background) !important;
            }

            #sidebar-close,
            #sidebar-title,
            #sidebar-switcher-arrow {
              display: none;
              border: none;
            }

            #sidebar-switcher-target {
              border: none !important;
              margin-left: 4.5px !important;
              padding-top: 4px !important;
              padding-bottom: 6px !important;
            }

            #sidebar-switcher-target:focus-visible:not(:hover, [open]),
            #sidebar-close:focus-visible:not(:hover, [open]) {
              outline: none !important;
            }

            .sidebar-splitter {
              opacity: 0 !important;
              width: 0px !important;
              border: none !important;
              --avatar-image-url: none !important;
            }

            #sidebarMenu-popup .subviewbutton {
              min-width: 0px;
              padding: 0;
              margin: 0 !important;
            }

            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]
              + #sidebar-splitter {
              display: none !important;
            }

            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]
              #sidebar-header {
              visibility: collapse;
            }

            tab-close-button.close-icon {
              display: none;
              color: red;
            }
            tab-label-container {
              color: ${colors.base00};
            }
            #_c607c8df-14a7-4f28-894f-29e8722976af_-BAP {
               color: ${colors.base00};
            }
            #TabsToolbar {
              background-color: ${colors.base00} !important;
            }
            #nav-bar {
              background-color: ${colors.base00};
            }
            #tracking-protection-icon-container {
              background-color: ${colors.base00};
            }
            #appMenu-multiView {
              background-color: ${colors.base00} !important;
            }
            .urlbar-page-action {
              background-color: ${colors.base00};
            }
            .identity-box-button  {
              background-color: ${colors.base00};
            }
            .urlbar-input-box {
              background-color: ${colors.base00};
            }
            .tab-icon-image {
              display: none;
            }
            .tabbrowser-tab {
              color: ${colors.base05} !important;
              color-scheme: unset;
            }
            tab[selected="true"] > .tab-stack > .tab-background {
              background: ${colors.base01} !important;
            }
            tab:not([selected="true"]) > .tab-stack:hover > .tab-background {
              background: ${colors.base01} !important;
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
