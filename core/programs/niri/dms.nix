{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  dmsPkgs,
  ...
}:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{

  hm.systemd.user.services = {
    dms = {
      Unit = {
        Description = "DankMaterialShell Service";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        ExecStart = "${
          inputs.dankmaterialshell.inputs.dms-cli.packages.${pkgs.system}.default
        }/bin/dms run";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
  hm.programs.dankMaterialShell = {
    enable = true;
    # enableKeybinds = false;
    enableSystemd = false;
    # enableSpawn = true;
    enableSystemMonitoring = true;
    enableClipboard = true;
    enableAudioWavelength = true;
  };
  hm.xdg.configFile."DankMaterialShell/theme.json".text = builtins.toJSON {
    dark = {
      name = "Nebula Ice (Stylix)";
      primary = colors.base0D;
      primaryText = colors.base05;
      primaryContainer = colors.base02;
      secondary = colors.base00;
      surface = colors.base00;
      surfaceText = colors.base05;
      surfaceVariant = colors.base03;
      surfaceVariantText = colors.base06;
      surfaceTint = colors.base04;
      background = colors.base00;
      backgroundText = colors.base07;
      outline = colors.base04;
      surfaceContainer = colors.base02;
      surfaceContainerHigh = colors.base03;
      error = colors.base08;
      warning = colors.base09;
      info = colors.base0A;
      success = colors.base0B;
    };

    # optional light theme (placeholder or reuse)
    light = {
      name = "Nebula Ice Light";
      primary = "#cccccc";
      primaryText = "#000000";
      primaryContainer = "#f5f5f5";
      secondary = "#ffffff";
      surface = "#ffffff";
      surfaceText = "#000000";
      surfaceVariant = "#eeeeee";
      surfaceVariantText = "#111111";
      surfaceTint = "#cccccc";
      background = "#ffffff";
      backgroundText = "#000000";
      outline = "#cccccc";
      surfaceContainer = "#f5f5f5";
      surfaceContainerHigh = "#eeeeee";
      error = "#ff0000";
      warning = "#ffaa00";
      info = "#0088ff";
      success = "#00aa66";
    };
  };

  hm.xdg.configFile."DankMaterialShell/settings.json".text = builtins.toJSON {
    currentThemeName = "custom";
    customThemeFile = "${config.hm.xdg.configHome}/DankMaterialShell/theme.json";
    topBarTransparency = 0.75;
    topBarWidgetTransparency = 0.85;
    popupTransparency = 0.92;
    dockTransparency = 1;
    use24HourClock = true;
    useFahrenheit = true;
    nightModeEnabled = false;
    weatherLocation = "40.7128, -74.0060";
    weatherCoordinates = "40.7128,-74.0060";
    useAutoLocation = true;
    weatherEnabled = true;
    showLauncherButton = true;
    showWorkspaceSwitcher = true;
    showFocusedWindow = true;
    showWeather = true;
    showMusic = true;
    showClipboard = true;
    showCpuUsage = true;
    showMemUsage = true;
    showCpuTemp = true;
    showGpuTemp = true;
    selectedGpuIndex = 0;
    enabledGpuPciIds = [ ];
    showSystemTray = true;
    showClock = true;
    showNotificationButton = true;
    showBattery = true;
    showControlCenterButton = true;
    controlCenterShowNetworkIcon = true;
    controlCenterShowBluetoothIcon = true;
    controlCenterShowAudioIcon = true;
    showWorkspaceIndex = false;
    showWorkspacePadding = false;
    showWorkspaceApps = false;
    maxWorkspaceIcons = 3;
    workspacesPerMonitor = true;
    workspaceNameIcons = { };
    waveProgressEnabled = true;
    clockCompactMode = false;
    focusedWindowCompactMode = false;
    runningAppsCompactMode = true;
    runningAppsCurrentWorkspace = false;
    clockDateFormat = "";
    lockDateFormat = "";
    mediaSize = 1;
    topBarLeftWidgets = [
      "launcherButton"
      "workspaceSwitcher"
      "focusedWindow"
    ];
    topBarCenterWidgets = [
      "music"
      "clock"
      "weather"
    ];
    topBarRightWidgets = [
      "systemTray"
      "clipboard"
      "cpuUsage"
      "memUsage"
      "notificationButton"
      "battery"
      "controlCenterButton"
    ];
    appLauncherViewMode = "list";
    spotlightModalViewMode = "list";
    networkPreference = "auto";
    iconTheme = "System Default";
    useOSLogo = false;
    osLogoColorOverride = "";
    osLogoBrightness = 0.5;
    osLogoContrast = 1;
    wallpaperDynamicTheming = true;
    fontFamily = "Inter Variable";
    monoFontFamily = "Fira Code";
    fontWeight = 400;
    fontScale = 1;
    notepadUseMonospace = true;
    notepadFontFamily = "";
    notepadFontSize = 14;
    gtkThemingEnabled = false;
    qtThemingEnabled = false;
    showDock = true;
    dockAutoHide = false;
    cornerRadius = 12;
    notificationOverlayEnabled = false;
    topBarAutoHide = false;
    topBarOpenOnOverview = false;
    topBarVisible = true;
    topBarSpacing = 4;
    topBarBottomGap = 0;
    topBarInnerPadding = 8;
    topBarSquareCorners = false;
    topBarNoBackground = false;
    lockScreenShowPowerActions = true;
    hideBrightnessSlider = false;
    notificationTimeoutLow = 5000;
    notificationTimeoutNormal = 5000;
    notificationTimeoutCritical = 0;
    screenPreferences = { };
  };
}
