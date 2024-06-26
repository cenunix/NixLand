# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };
  #When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  nvidia-packages = final: _prev: {
    unstable = import inputs.nixpkgs-nvidia {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {
      # vesktop = prev.vesktop.overrideAttrs (old: rec {
      #   version = "master";
      #   src = old.src.override {
      #     rev = "2733727a40a4cf542277dedcf89e87e7740f962d";
      #     hash = "sha256-EF36HbbhTuAdwBEKqYgBBu7JoP1LJneU78bROHoKqDw=";
      #   };
      #   pnpmDeps = old.pnpmDeps.overrideAttrs (old: rec {
      #     outputHash = "sha256-6ezEBeYmK5va3gCh00YnJzZ77V/Ql7A3l/+csohkz68=";
      #   });
      # });
    };
}
