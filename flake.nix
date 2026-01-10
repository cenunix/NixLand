{
  description = "NixOS Flake by Cenunix";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Different Window Managers, who will win??
    hyprland.url = "github:hyprwm/hyprland?ref=v0.52.2";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankmaterialshell = {
      url = "github:AvengeMedia/DankMaterialShell?ref=v0.6.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };

    wallpkgs.url = "github:NotAShelf/wallpkgs"; # no need to follow nixpkgs
    stylix.url = "github:danth/stylix";
    nixcord.url = "github:kaylorben/nixcord";
    # hyprpanel.url = "github:cenunix/HyprPanel/fix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nur-atarax.url = "github:AtaraxiaSjel/nur";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        europa = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/europa
          ];
        };
        callisto = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/callisto
          ];
        };

      };
    };
}
