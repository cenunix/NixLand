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
    ./hyprpanel
    ./lf
    ./nvf
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./signal.nix
    ./spotify.nix
    ./thunar.nix
    ./vscode.nix
  ];
}
