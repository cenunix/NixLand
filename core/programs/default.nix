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
    ./waydroid
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    # ./nvf.nix
    ./signal.nix
    ./spotify.nix
    ./thunar.nix
    ./vscode.nix
  ];
}
