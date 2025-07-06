{
  config,
  inputs,
  pkgs,
  lib,
  system,
  impurity,
  ...
}:
let
  inherit (inputs) quickshell;
  # hack because the greeter user cant access /home/admin
  maybeLink = path: if config.hm.home.username == "admin" then impurity.link path else path;
in
{
  hm.home.packages = with pkgs; [
    qt6.qtimageformats # amog
    qt6.qt5compat # shader fx
    qt6.qtmultimedia # flicko shell
    qt6.qtdeclarative # qtdecl types in path
    quickshell.packages.${pkgs.system}.default
    # (quickshell.packages.${pkgs.system}.default.override (prevqs: {
    #   debug = true;
    #   qt6 = prevqs.qt6.overrideScope (
    #     _: prevqt: {
    #       qtdeclarative = prevqt.qtdeclarative.overrideAttrs (prev: {
    #         cmakeBuildType = "Debug";
    #         dontStrip = true;
    #       });
    #     }
    #   );
    # }))
    grim
    imagemagick # screenshot
  ];

  hm.xdg.configFile."quickshell/manifest.conf".text = lib.generators.toKeyValue { } {
    shell = "${maybeLink ./.}/shell";
    greeter = "${maybeLink ./.}/shell/greeter.qml";
  };
}
