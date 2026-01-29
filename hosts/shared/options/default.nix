{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  imports = [
    ./device
    ./system
    ./usrEnv
  ];
  options.modules.style = {
    forceGtk = mkEnableOption "Force GTK applications to use the GTK theme";
    useKvantum = mkEnableOption "Use Kvantum to theme QT applications";

    pointerCursor = {
      package = mkOption {
        type = types.package;
        description = "The package providing the cursors";
        default = pkgs.bibata-cursors;
      };

      name = mkOption {
        type = types.str;
        description = "The name of the cursor inside the package";
        default = "Bibata-Modern-Ice";
      };

      size = mkOption {
        type = types.int;
        description = "The size of the cursor";
        default = 24;
      };
    };

    wallpapers = mkOption {
      type = with types; either str (listOf str);
      description = "Wallpaper or wallpapers to use";
      default = [ ];
    };
  };
}
