{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
final: prev:
let
  patchedLibrespotSrc = prev.fetchFromGitHub {
    owner = "librespot-org";
    repo = "librespot";
    rev = "v0.6.0";
    hash = "sha256-dGQDRb7fgIkXelZKa+PdodIs9DxbgEMlVGJjK/hU3Mo=";
  };

  librespotWithPatches = prev.stdenv.mkDerivation {
    name = "librespot-patched-src";
    src = patchedLibrespotSrc;

    patches = [
      ./1524.patch # https://github.com/librespot-org/librespot/pull/1524
      ./1527.patch # https://github.com/librespot-org/librespot/pull/1524
    ];

    buildPhase = "";
    installPhase = ''
      cp -r . $out
    '';
  };
in
{
  spotify-player = prev.spotify-player.overrideAttrs (old: rec {
    pname = "spotify-player";
    version = "0.7.0-dev";
    src = prev.fetchFromGitHub {
      owner = "aome510";
      repo = "spotify-player";
      rev = "b92c7379b192e6492ec37b722ecb9934e6803c2f";
      hash = "sha256-cWJAj0n3Q8WC5U0PvDMeDQ6yjxYtvoF5N9LJPJJnixo=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-Xw2TAJHlPcXUjJCO2XCl5Fjkp3WuAyxdEMyBTovpbT4=";
    };
    patches = old.patches or [ ] ++ [
      # Patch Cargo.toml to use local patched librespot
      (prev.writeText "use-local-librespot.patch" ''
        diff --git a/spotify_player/Cargo.toml b/spotify_player/Cargo.toml
        index a5c812d..8c8532d 100644
        --- a/spotify_player/Cargo.toml
        +++ b/spotify_player/Cargo.toml
        @@ -15,11 +15,11 @@ clap = { version = "4.5.41", features = ["derive", "string"] }
         config_parser2 = "0.1.6"
         crossterm = "0.29.0"
         dirs-next = "2.0.0"
        -librespot-connect = { version = "0.6.0", optional = true }
        -librespot-core = "0.6.0"
        -librespot-oauth = "0.6.0"
        -librespot-playback = { version = "0.6.0", optional = true }
        -librespot-metadata = "0.6.0"
        +librespot-connect = { path = "${librespotWithPatches}/connect", optional = true }
        +librespot-core = { path = "${librespotWithPatches}/core" }
        +librespot-oauth = { path = "${librespotWithPatches}/oauth" }
        +librespot-playback = { path = "${librespotWithPatches}/playback", optional = true }
        +librespot-metadata = { path = "${librespotWithPatches}/metadata" }
         log = "0.4.27"
         chrono = "0.4.41"
         reqwest = { version = "0.12.22", features = ["json"] }
      '')
    ];
  });
}
