{
  config,
  lib,
  pkgs,
  self,
  inputs,
  ...
}:
with lib;
let
  env = config.modules.usrEnv;
  sys = config.modules.system;
in
{
  config = {
    # unlock GPG keyring on login
    security.pam.services = {
      login = {
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };

    };
    environment.systemPackages = with pkgs; [

      sddm-astronaut
    ];

    services = {
      displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        # defaultSession = "hyprland";
        extraPackages = with pkgs; [
          # sddm-astronaut
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
          kdePackages.svgpart
        ];
        # theme = "astronaut";
        # settings = {
        #   General = {
        #     ScreenWidth = "2560";
        #     ScreenHeight = "1440";
        #     ScreenPadding = "5";
        #     Font = "ESPACION";
        #     FontSize = "12";
        #     KeyboardSize = "0.4";
        #     RoundCorners = "20";
        #     Locale = "";
        #     HourFormat = "HH:mm";
        #     DateFormat = "dddd d";
        #     HeaderText = "";
        #   };
        #
        #   Background = {
        #     BackgroundPlaceholder = "";
        #
        #     # Background = "Backgrounds/black_hole.png";
        #     # Background = "${inputs.wallpkgs.wallpapers.catppuccin-bunnies-road.path}";
        #     BackgroundSpeed = "";
        #     PauseBackground = "";
        #     DimBackground = "0.0";
        #     CropBackground = "true";
        #     BackgroundHorizontalAlignment = "center";
        #     BackgroundVerticalAlignment = "center";
        #   };
        #
        #   Colors = {
        #     HeaderTextColor = "#5c729d";
        #     DateTextColor = "#5c729d";
        #     TimeTextColor = "#b7cef1";
        #     FormBackgroundColor = "#22162f";
        #     BackgroundColor = "#5c729d";
        #     DimBackgroundColor = "#5c729d";
        #     LoginFieldBackgroundColor = "#623461";
        #     PasswordFieldBackgroundColor = "#623461";
        #     LoginFieldTextColor = "#b7cef1";
        #     PasswordFieldTextColor = "#b7cef1";
        #     UserIconColor = "#b7cef1";
        #     PasswordIconColor = "#b7cef1";
        #     PlaceholderTextColor = "#bbbbbb";
        #     WarningColor = "#ffffff";
        #     LoginButtonTextColor = "#ffffff";
        #     LoginButtonBackgroundColor = "#5c729d";
        #     SystemButtonsIconsColor = "#b7cef1";
        #     SessionButtonTextColor = "#b7cef1";
        #     VirtualKeyboardButtonTextColor = "#b7cef1";
        #     DropdownTextColor = "#ffffff";
        #     DropdownSelectedBackgroundColor = "#5c729d";
        #     DropdownBackgroundColor = "#171426";
        #     HighlightTextColor = "#1e1f2f";
        #     HighlightBackgroundColor = "#b7cef1";
        #     HighlightBorderColor = "#5c729d";
        #     HoverUserIconColor = "#5c729d";
        #     HoverPasswordIconColor = "#5c729d";
        #     HoverSystemButtonsIconsColor = "#5c729d";
        #     HoverSessionButtonTextColor = "#5c729d";
        #     HoverVirtualKeyboardButtonTextColor = "#5c729d";
        #   };
        #
        #   Form = {
        #     PartialBlur = "false";
        #     FullBlur = "false";
        #     BlurMax = "32";
        #     Blur = "1.0";
        #   };
        # };
      };

      logind =
        if (sys.server.enable) then
          {
            lidSwitch = "ignore";
            lidSwitchExternalPower = "ignore";
          }
        else
          {
            lidSwitch = "suspend-then-hibernate";
            lidSwitchExternalPower = "lock";
            settings.Login = {
              HandlePowerKey = "suspend-then-hibernate";
              HibernateDelaySec = 3600;
            };
          };
    };
  };
}
