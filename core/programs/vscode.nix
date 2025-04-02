{
  inputs,
  outputs,
  lib,
  config,
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
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    hm.programs.vscode = {
      enable = true;
      profiles.default = {
        enableExtensionUpdateCheck = true;
        enableUpdateCheck = false;
        extensions =
          with pkgs.vscode-extensions;
          [
            bbenoist.nix
            b4dm4n.vscode-nixpkgs-fmt
            catppuccin.catppuccin-vsc
            christian-kohler.path-intellisense
            eamodio.gitlens
            ibm.output-colorizer
            naumovs.color-highlight
            pkief.material-icon-theme
            usernamehw.errorlens
            redhat.vscode-yaml
            irongeek.vscode-env
            github.vscode-pull-request-github
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-chromium-vector-icons";
              publisher = "adolfdaniel";
              version = "1.0.2";
              sha256 = "sha256-Meo53e/3jUP6YDEXOA/40xghI77jj4iAQus3/S8RPZI=";
            }
          ];
        userSettings = {
          "workbench.iconTheme" = "material-icon-theme";
          # "workbench.colorTheme" = "Catppuccin Mocha";
          "catppuccin.accentColor" = "blue";
          # "editor.fontFamily" = "Maple Mono SC NF, Material Design Icons, 'monospace', monospace";
          # "editor.fontSize" = 16;
          "editor.fontLigatures" = true;
          # "workbench.fontAliasing" = "antialiased";
          "files.trimTrailingWhitespace" = true;
          "terminal.integrated.fontFamily" = "Maple Mono SC NF";
          "window.titleBarStyle" = "custom";
          # "terminal.integrated.automationShell.linux" = "nix-shell";
          # "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.cursorBlinking" = true;
          "terminal.integrated.enableVisualBell" = false;
          # "accessibility.signal.terminalBell" = false;
          "editor.formatOnPaste" = false;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
          "editor.minimap.enabled" = false;
          "editor.minimap.renderCharacters" = false;
          "editor.overviewRulerBorder" = false;
          "editor.renderLineHighlight" = "all";
          "editor.inlineSuggest.enabled" = true;
          "editor.smoothScrolling" = true;
          "editor.suggestSelection" = "first";
          "editor.guides.indentation" = true;
          "editor.guides.bracketPairs" = true;
          "editor.bracketPairColorization.enabled" = true;
          # "window.nativeTabs" = true;
          "window.restoreWindows" = "all";
          "window.menuBarVisibility" = "toggle";
          "workbench.panel.defaultLocation" = "right";
          # "workbench.editor.tabCloseButton" = "left";
          "workbench.startupEditor" = "none";
          "workbench.list.smoothScrolling" = true;
          "security.workspace.trust.enabled" = false;
          "explorer.confirmDelete" = false;
          "breadcrumbs.enabled" = true;
          "workbench.colorCustomizations" = {
            "editor.background" = "#07070b";
            "editorGutter.background" = "#07070b";
            "editorRuler.background" = "#07070b";
            "activityBar.background" = "#07070b";
            "sideBar.background" = "#07070b";
            "sideBarSectionHeader.background" = "#07070b";
            "editorGroupHeader.tabsBackground" = "#07070b";
            "tab.activeBackground" = "#07070b";
            "tab.inactiveBackground" = "#07070b";
            "tab.unfocusedActiveBackground" = "#07070b";
          };
        };
      };
    };
  };
}
