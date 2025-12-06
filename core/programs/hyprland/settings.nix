{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config) modules;
  inherit (modules) device;
  inherit (modules.style) pointerCursor;
in
{
  hm.wayland.windowManager.hyprland.extraConfig =
    let
      monitorConfig = builtins.concatStringsSep "\n" (
        builtins.map (monitor: "monitor=${monitor}") device.monitors
      );
      workspacesConfig = builtins.concatStringsSep "\n" (device.workspaces);
    in
    ''
      ${monitorConfig}
      ${workspacesConfig}
    '';

  #         "DP-2,2560x1440@239.97,1080x0,1"
  #       "DP-1,1920x1080@240,0x0,1,transform,1"

  hm.wayland.windowManager.hyprland.settings = {
    #   "monitorv2[DP-2]" = {
    #     mode = "2560x1440@239.97";
    #     position = "1080x0";
    #     scale = 1;
    #     cm = "auto";
    #     bitdepth = 10;
    #     # supports_wide_color = 1;
    #     # supports_hdr = 1;
    #     # sdr_min_luminance = 0.005;
    #     # sdr_max_luminance = 250;
    #   };
    #   monitor = [
    #     "DP-1,1920x1080@240,0x0,1,transform,1"
    #   ];
    "$mod" = "SUPER";
    exec-once = [
      "hyprctl setcursor ${pointerCursor.name} ${toString pointerCursor.size}"
      # "hyprsunset --temperature 5700"
    ];
    input = {
      follow_mouse = 1;
      sensitivity = 0;
    };
    cursor = {
      # allow_dumb_copy = true;
      no_hardware_cursors = true;
    };
    experimental = {
      xx_color_management_v4 = true;
    };
    general = {
      gaps_in = 4;
      gaps_out = 4;
      border_size = 1;
      # "col.active_border" = "rgb(a0acc5)";
      # "col.inactive_border" = "rgb(7486a9)";
      allow_tearing = true;
      resize_on_border = true;
      layout = "master";
    };
    decoration = {
      shadow = {
        enabled = true;
        range = 20;
        render_power = 3;
        # color = "rgb(3c4252)";
        # color_inactive = "rgb(3c4252)";
      };
      rounding = 8;
      blur = {
        enabled = false;
        ignore_opacity = false;
        size = 8;
        passes = 2;
      };
    };
    animations = {
      enabled = true;
      bezier = [
        "pace, 0.46, 1, 0.29, 0.99"
        "overshot, 0.13, 0.99, 0.29, 1.1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "custom, 0.5, 0.5, 0.6, 0.3"
      ];
      animation = [
        "windowsIn, 1, 1, custom, slide"
        "windowsOut, 1, 1, custom, slide"
        "windowsMove, 1, 1, custom, slide"
        "fade, 1, 1, custom"
        "workspaces, 1, 1.5, custom"
        "specialWorkspace, 1, 1, custom,slide"
      ];
    };
    render = {
      cm_fs_passthrough = 1;
      direct_scanout = 1;
      # cm_auto_hdr = 2;
      # cm_enabled = 1;
      # send_content_type = true;
      # direct_scanout = 2;
      # new_render_scheduling = true;
    };
    dwindle = {
      pseudotile = false; # enable pseudotiling on dwindle
    };
    # gestures = {
    #   workspace_swipe = false;
    # };
    plugin = {
      overview = {
        centerAligned = true;
        hideTopLayers = true;
        hideOverlayLayers = true;
        showNewWorkspace = true;
        exitOnClick = true;
        exitOnSwitch = true;
        drawActiveWorkspace = true;
        reverseSwipe = true;
      };
      # csgo-vulkan-fix = {
      #   res_w = 1920;
      #   res_h = 1080;
      #   class = "cs2";
      # };
    };
    misc = {
      animate_manual_resizes = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      vfr = 1;
      vrr = 1;
    };
  };
}
