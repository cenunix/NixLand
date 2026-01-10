{ lib, ... }:
let
  inherit (lib) mkIf;
in
{
  hm.wayland.windowManager.hyprland.settings = {
    # layer rules
    # layerrule =
    #   let
    #     toRegex =
    #       list:
    #       let
    #         elements = lib.concatStringsSep "|" list;
    #       in
    #       "^(${elements})$";

    #   ignorealpha = [
    #     # ags
    #     "calendar"
    #     "notifications"
    #     "osd"
    #     "system-menu"
    #     "wofi"
    #     "anyrun"
    #   ];
    #
    #   layers = ignorealpha ++ [
    #     "bar"
    #     "gtk-layer-shell"
    #   ];
    # in
    # [
    #   "blur, ${toRegex layers}"
    #   "xray 1, ${
    #     toRegex [
    #       "bar"
    #       "gtk-layer-shell"
    #     ]
    #   }"
    #   "ignorealpha 0.2, ${
    #     toRegex [
    #       "bar"
    #       "gtk-layer-shell"
    #     ]
    #   }"
    #   "ignorealpha 0.5, ${toRegex (ignorealpha ++ [ "music" ])}"
    # ];
    windowrule = [
      # window rules go here
      # See https://wiki.hyprland.org/Configuring/Window-Rules/
      "match:class ^(Civ6)$, fullscreen on"
      "match:class ^(Civ6)$, monitor 1"

    ];
  };
}
