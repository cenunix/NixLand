{
  config,
  pkgs,
  osConfig,
  ...
}:
{
  imports = [
    ./hardware-config.nix
    ./system.nix
    ../shared
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "europa"; # Define your hostname.

  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelModules = [ "kvm-amd" ];

  users.users.cenunix = {
    isNormalUser = true;
    description = "cenunix";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Allow unfree packages

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
