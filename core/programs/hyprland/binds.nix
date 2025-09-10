{ config, ... }:
let
  inherit (config) modules;
  inherit (modules.programs) default;
  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "Alt_L, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );
in
{
  hm.wayland.windowManager.hyprland = {
    # extraConfig = ''
    #   bind=CTRL,ALT_L,submap,passthrough
    #   submap=passthrough
    #   bindr=CTRL,Escape,submap,reset
    #   submap=reset
    # '';
    settings = {
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, M, exit"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod SHIFT, SPACE, togglefloating"
        "$mod, y, movetoworkspace, special"
        "$mod, t, togglespecialworkspace"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"
        "$mod, B, movecurrentworkspacetomonitor, DP-2"
        "$mod SHIFT, B, movecurrentworkspacetomonitor, DP-1"

        "$mod, V, exec, hyprctl keyword 'device[razer-razer-viper-ultimate-dongle]:enabled' false"
        "$mod SHIFT, V, exec, hyprctl keyword 'device[razer-razer-viper-ultimate-dongle]:enabled' true"
        "$mod, I, exec, hyprlock"
        "$mod, Return, exec, ${default.terminal} start --always-new-process"
        "$mod SHIFT, Return, exec, ${default.terminal}"
        "$mod, E, exec, ${default.fileManager}"
        # "$mod, R, exec, killall astal; astal; killall swww-daemon; swww-daemon"
        "$mod, U, exec, ags -b hypr -r 'recorder.start()'"
        "$mod, P, exec, grimblast --notify copysave output"
        "$mod SHIFT, P, exec, grimblast --notify copysave area"
        "$mod SHIFT, P, exec, ags -b hypr -r 'recorder.screenshot(true)'"
        "$mod, SPACE, exec, walker"
      ]
      ++ workspaces;

      bindle = [
        ", XF86MonBrightnessUp,exec,brightnessctl s 5%+"
        ", XF86MonBrightnessDown,exec,brightnessctl s 5%-"
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
    };
  };
}
