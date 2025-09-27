{
  inputs,
  pkgs,
  config,
  osConfig,
  self,
  ...
}:
{
  imports = [
    ./anyrun
    ./btop
    ./discord
    ./hyprland
    ./hyprlock
    # ./hyprpanel
    ./lf
    ./nvf
    ./niri
    ./spotify
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./signal.nix
    ./thunar.nix
    ./vscode.nix
  ];
}
