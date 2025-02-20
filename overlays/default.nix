# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };
  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  # stable-packages = final: _prev: {
  #   stable = import inputs.nixpkgs-stable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {

      # egl-wayland = prev.egl-wayland.overrideAttrs (o: rec {
      #   version = "1.1.15";
      #
      #   src = prev.fetchFromGitHub {
      #     owner = "Nvidia";
      #     repo = o.pname;
      #     rev = version;
      #     hash = "sha256-MD+D/dRem3ONWGPoZ77j2UKcOCUuQ0nrahEQkNVEUnI=";
      #   };
      # );
    };
}
