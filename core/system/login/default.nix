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
  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];

in
{
  config = {
    # unlock GPG keyring on login
    security.pam.services = {
      login = {
        # enableGnomeKeyring = true;
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };
      # greetd = {
      #   gnupg.enable = true;
      #   enableGnomeKeyring = true;
      # };
    };

    services = {
      # xserver.displayManager.session = [
      #   {
      #     manage = "desktop";
      #     name = "hyprland";
      #     start = ''
      #       Hyprland
      #     '';
      #   }
      # ];

      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        # defaultSession = "hyprland";
        # extraPackages = [ pkgs.sddm-astronaut ];
        # theme = "astronaut";
        settings = {
          General = {
            ScreenWidth = "2560";
            ScreenHeight = "1440";
            ScreenPadding = "5";
            Font = "ESPACION";
            FontSize = "12";
            KeyboardSize = "0.4";
            RoundCorners = "20";
            Locale = "";
            HourFormat = "HH:mm";
            DateFormat = "dddd d";
            HeaderText = "";
          };

          Background = {
            BackgroundPlaceholder = "";

            # Background = "Backgrounds/black_hole.png";
            # Background = "${inputs.wallpkgs.wallpapers.catppuccin-bunnies-road.path}";
            BackgroundSpeed = "";
            PauseBackground = "";
            DimBackground = "0.0";
            CropBackground = "true";
            BackgroundHorizontalAlignment = "center";
            BackgroundVerticalAlignment = "center";
          };

          Colors = {
            HeaderTextColor = "#5c729d";
            DateTextColor = "#5c729d";
            TimeTextColor = "#b7cef1";
            FormBackgroundColor = "#22162f";
            BackgroundColor = "#5c729d";
            DimBackgroundColor = "#5c729d";
            LoginFieldBackgroundColor = "#623461";
            PasswordFieldBackgroundColor = "#623461";
            LoginFieldTextColor = "#b7cef1";
            PasswordFieldTextColor = "#b7cef1";
            UserIconColor = "#b7cef1";
            PasswordIconColor = "#b7cef1";
            PlaceholderTextColor = "#bbbbbb";
            WarningColor = "#ffffff";
            LoginButtonTextColor = "#ffffff";
            LoginButtonBackgroundColor = "#5c729d";
            SystemButtonsIconsColor = "#b7cef1";
            SessionButtonTextColor = "#b7cef1";
            VirtualKeyboardButtonTextColor = "#b7cef1";
            DropdownTextColor = "#ffffff";
            DropdownSelectedBackgroundColor = "#5c729d";
            DropdownBackgroundColor = "#171426";
            HighlightTextColor = "#1e1f2f";
            HighlightBackgroundColor = "#b7cef1";
            HighlightBorderColor = "#5c729d";
            HoverUserIconColor = "#5c729d";
            HoverPasswordIconColor = "#5c729d";
            HoverSystemButtonsIconsColor = "#5c729d";
            HoverSessionButtonTextColor = "#5c729d";
            HoverVirtualKeyboardButtonTextColor = "#5c729d";
          };

          Form = {
            PartialBlur = "false";
            FullBlur = "false";
            BlurMax = "32";
            Blur = "1.0";
          };
        };
      };
      # greetd = mkIf env.windowManager {
      #   enable = true;
      #   vt = 2;
      #   restart = !env.autologin;
      #   settings = {
      #     # pick up desktop variant (i.e Hyprland) and username from usrEnv
      #     # this option is usually defined in host/<hostname>/system.nix
      #     initial_session = mkIf env.autologin {
      #       command = "${env.desktop}";
      #       user = "${sys.username}";
      #     };
      #
      #     default_session =
      #       if (!env.autologin) then
      #         {
      #           command = lib.concatStringsSep " " [
      #             (getExe pkgs.greetd.tuigreet)
      #             "--time"
      #             "--remember"
      #             "--remember-user-session"
      #             "--asterisks"
      #             "--power-shutdown '${pkgs.systemd}/bin/systemctl shutdown'"
      #             "--sessions '${sessionPath}'"
      #           ];
      #           user = "greeter";
      #         }
      #       else
      #         {
      #           command = "${env.desktop}";
      #           user = "${sys.username}";
      #         };
      #   };
      # };

      # gnome = {
      #   glib-networking.enable = true;
      #   gnome-keyring.enable = true;
      # };

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
            extraConfig = ''
              HandlePowerKey=suspend-then-hibernate
              HibernateDelaySec=3600
            '';
          };
    };
  };
}
