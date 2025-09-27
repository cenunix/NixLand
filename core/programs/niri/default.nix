{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
{
  # nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  imports = [
    # inputs.niri.nixosModules.niri
    ./dms.nix
  ];
  # programs.niri.enable = false;
  # hm = {
  #
  #   home.sessionVariables = {
  #     # DISPLAY = ":0";
  #     NIXOS_OZONE_WL = "1";
  #   };
  #   home.packages = with pkgs; [
  #     xwayland-satellite
  #   ];
  #   programs = {
  #     niri = {
  #       settings = {
  #         environment = {
  #           "NIXOS_OZONE_WL" = "1";
  #         };
  #         prefer-no-csd = true;
  #         screenshot-path = "${config.hm.xdg.userDirs.pictures}/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
  #         window-rules = [
  #           {
  #             matches = [
  #               {
  #                 app-id = "^librewolf$";
  #               }
  #             ];
  #             border.width = 3;
  #           }
  #         ];
  #         layout = {
  #           focus-ring = {
  #             enable = true;
  #             width = 1;
  #           };
  #           border = {
  #             enable = true;
  #             width = 2;
  #           };
  #           preset-column-widths = [
  #             { proportion = 1.0 / 6.0; }
  #             { proportion = 1.0 / 4.0; }
  #             { proportion = 1.0 / 3.0; }
  #             { proportion = 1.0 / 2.0; }
  #             { proportion = 2.0 / 3.0; }
  #             { proportion = 3.0 / 4.0; }
  #             { proportion = 5.0 / 6.0; }
  #           ];
  #           preset-window-heights = [
  #             { proportion = 1.0 / 6.0; }
  #             { proportion = 1.0 / 4.0; }
  #             { proportion = 1.0 / 3.0; }
  #             { proportion = 1.0 / 2.0; }
  #             { proportion = 2.0 / 3.0; }
  #             { proportion = 3.0 / 4.0; }
  #             { proportion = 5.0 / 6.0; }
  #           ];
  #
  #         };
  #         input = {
  #           focus-follows-mouse.enable = true;
  #         };
  #         outputs = {
  #           "DP-1" = {
  #             transform.rotation = 90;
  #             mode.width = 1920;
  #             mode.height = 1080;
  #             mode.refresh = 240.000;
  #           };
  #           "DP-2" = {
  #             mode.width = 2560;
  #             mode.height = 1440;
  #             mode.refresh = 239.970;
  #           };
  #         };
  #         binds = {
  #           "Mod+Return".action.spawn = "kitty";
  #           "Mod+O".action.show-hotkey-overlay = { };
  #           "Mod+Space".action.spawn = [
  #             "dms"
  #             "ipc"
  #             "call"
  #             "spotlight"
  #             "toggle"
  #           ];
  #
  #           "Mod+Shift+M".action.quit.skip-confirmation = false;
  #           "Mod+L".action.focus-column-or-monitor-right = { };
  #           "Mod+H".action.focus-column-or-monitor-left = { };
  #           "Mod+K".action.focus-window-up = { };
  #           "Mod+J".action.focus-window-down = { };
  #           "Mod+Shift+H".action.consume-or-expel-window-left = { };
  #           "Mod+Shift+L".action.consume-or-expel-window-right = { };
  #           "Mod+Shift+K".action.move-window-up = { };
  #           "Mod+Shift+J".action.move-window-down = { };
  #           "Mod+P".action.screenshot = { };
  #           "Mod+F".action.fullscreen-window = { };
  #           "Mod+Shift+F".action.toggle-window-floating = { };
  #           "Mod+V".action.focus-monitor-next = { };
  #           "Mod+B".action.move-workspace-to-monitor-next = { };
  #           "Mod+Tab".action.focus-workspace-down = { };
  #           "Mod+Shift+Tab".action.focus-workspace-up = { };
  #           "Mod+Q".action.close-window = { };
  #           "Mod+R".action.switch-preset-window-width = { };
  #           "Mod+Shift+R".action.switch-preset-window-width-back = { };
  #           "Mod+C".action.maximize-column = { };
  #           "Mod+T".action.reset-window-height = { };
  #           "Mod+E".action.switch-preset-window-height = { };
  #           "Mod+Shift+E".action.switch-preset-window-height-back = { };
  #           "Mod+Shift+1".action.move-window-to-workspace = 1;
  #           "Mod+Shift+2".action.move-window-to-workspace = 2;
  #           "Mod+Shift+3".action.move-window-to-workspace = 3;
  #           "Mod+Shift+4".action.move-window-to-workspace = 4;
  #           "Mod+Shift+5".action.move-window-to-workspace = 5;
  #           "Mod+Shift+6".action.move-window-to-workspace = 6;
  #           "Mod+Shift+7".action.move-window-to-workspace = 7;
  #           "Mod+Shift+8".action.move-window-to-workspace = 8;
  #           "Mod+1".action.focus-workspace = 1;
  #           "Mod+2".action.focus-workspace = 2;
  #           "Mod+3".action.focus-workspace = 3;
  #           "Mod+4".action.focus-workspace = 4;
  #           "Mod+5".action.focus-workspace = 5;
  #           "Mod+6".action.focus-workspace = 6;
  #           "Mod+7".action.focus-workspace = 7;
  #           "Mod+8".action.focus-workspace = 8;
  #         };
  #       };
  #     };
  #   };
  # };
}
