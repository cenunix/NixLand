{
  pkgs,
  inputs,
  ...
}:
{
  # hm.imports = [
  #   # inputs.anyrun.homeManagerModules.default
  # ];
  hm.services = {
    walker = {
      enable = true;
    };
  };

  hm.programs = {
    anyrun = {
      enable = false;
      extraConfigFiles = {
        "applications.ron".text = ''
          Config(
            desktop_actions: false,
            max_entries: 5,
          )
        '';

        "shell.ron".text = ''
          Config(
            prefix: ">"
          )
        '';

        "randr.ron".text = ''
          Config(
            prefi: ":dp",
            max_entries: 5,
          )
        '';

        "stdin.ron".text = ''
          Config(
            allow_invalid: true,
            max_entries: 20
          )
        '';
      };
      extraCss = ''
        * {
          all: unset;
          font-size: 1.2rem;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        #match.activatable {
          border-radius: 8px;
          margin: 4px 0;
          padding: 4px;
          /* transition: 100ms ease-out; */
        }
        #match.activatable:first-child {
          margin-top: 12px;
        }
        #match.activatable:last-child {
          margin-bottom: 0;
        }

        #match:hover {
          background: rgba(255, 255, 255, 0.05);
        }
        #match:selected {
          background: rgba(255, 255, 255, 0.1);
        }

        #entry {
          background: rgba(255, 255, 255, 0.05);
          border: 1px solid rgba(255, 255, 255, 0.1);
          border-radius: 8px;
          padding: 4px 8px;
        }

        box#main {
          background: rgba(0, 0, 0, 0.5);
          box-shadow:
            inset 0 0 0 1px rgba(255, 255, 255, 0.1),
            0 30px 30px 15px rgba(0, 0, 0, 0.5);
          border-radius: 20px;
          padding: 12px;
        }
      '';
      config = {
        width.fraction = 0.25;
        y.fraction = 0.3;
        hidePluginInfo = true;
        closeOnClick = true;
        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
          # "${pkgs.anyrun}/lib/libsymbols.so"
          # "${pkgs.anyrun}/lib/libkidex.so"
          # "${pkgs.anyrun}/lib/librink.so"
          # "${pkgs.anyrun}/lib/libtranslate.so"
        ];
      };
    };
  };
}
