{ pkgs }:

let
  imgLink = "https://github.com/NotAShelf/wallpkgs/blob/main/wallpapers/catppuccin/catppuccin-jellyfish.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-Q366NmsgzQoyQWFZeE005Ei1LvxzyCRFUg/gL4Ucxlk=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "5e39e0841d4942757079779b4f0087f921288af6";
    sha256 = "sha256-bqMnJs59vWkksJCm+NOJWgsuT4ABSyIZwnABC3JLcSc=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    # cd $out/
    # rm Background.jpg
    # cp -r ${image} $out/Background.jpg
  '';
}
