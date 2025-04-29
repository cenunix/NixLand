{ pkgs, ... }:
let
  catpuccin-css = pkgs.fetchurl {
    url = "https://github.com/CalfMoon/signal-desktop/raw/658cb182d49dc6ba3085c7b63db0987e875a29bf/themes/catppuccin-mocha.css";
    sha256 = "sha256-G+SXzbqgdd4DMoy6L+RW5xdoMMj3oCfd6hyalVnPkR4=";
  };
in
{
  hm.home.packages = [
    (pkgs.signal-desktop-bin.overrideAttrs (
      finalAttrs: previousAttrs: {
        buildInputs = previousAttrs.buildInputs ++ [ pkgs.asar ];
        postInstall = ''
          asar extract $out/lib/signal-desktop/resources/app.asar temp/
          cp ${catpuccin-css} temp/stylesheets/catppuccin-mocha.css
          substituteInPlace temp/stylesheets/catppuccin-mocha.css \
          --replace-fail "#1e1e2e" "#07070b" \
          --replace-fail "#181825" "#07070b" \
          --replace-fail "#11111b" "#07070b"
          sed -i '1s/^/@import "catppuccin-mocha.css";\n /' temp/stylesheets/manifest.css
          asar pack --unpack '*.node' temp/ $out/lib/signal-desktop/resources/app.asar
        '';
      }
    ))
  ];
}
