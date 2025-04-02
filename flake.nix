{
  description = "NixOS Flake by Cenunix";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };

    wallpkgs.url = "github:NotAShelf/wallpkgs"; # no need to follow nixpkgs
    stylix.url = "github:danth/stylix";
    nixcord.url = "github:kaylorben/nixcord";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
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
            ./hosts/europa
          ];
        };

      };
    };
}
