{ inputs
, pkgs
, config
, ...
}:
let
  devinit = pkgs.writeShellScriptBin "devinit" ''
    nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$1" && direnv allow
  '';
in
{

  hm = {
    home.packages = [
      devinit
    ];
    programs = {
      wezterm = {
        enable = true;
        enableZshIntegration = true;
        extraConfig = ''
          local wezterm = require 'wezterm'
          local mux = wezterm.mux
          local config = wezterm.config_builder()
          local act = wezterm.action
          config.max_fps = 240
          config.animation_fps = 240
          config.use_fancy_tab_bar = false
          config.front_end = "OpenGL"
          config.enable_wayland = true
          config.keys = {
            {
              key = 'i',
              mods = 'CTRL',
              action = act.EmitEvent 'workflow-startup',
            },
            {
              key = 'i',
              mods = 'CTRL|SHIFT',
              action = act.SwitchToWorkspace {
                name = 'workflow',
              },
            },
            {
              key = 'u',
              mods = 'CTRL|SHIFT',
              action = act.SwitchToWorkspace {
                name = 'default',
              },
            },
          }

          wezterm.on('workflow-startup', function(cmd)
            -- allow `wezterm start -- something` to affect what we spawn
            -- in our initial window
            local args = {}
            if cmd then
              args = cmd.args
            end

            local journal_dir = '/home/cenunix/Personal/Janaru'
            local config_dir = '/home/cenunix/NixLand'
            local default_dir = '/home/cenunix'
            local default_tab, default_pane, window = mux.spawn_window {
              workspace = 'workflow',
              cwd = default_dir,
              args = args,
            }
            local config_tab, config_pane, window = window:spawn_tab {
              cwd = config_dir,
            }
            local journal_tab, journal_pane, window = window:spawn_tab {
              cwd = journal_dir,
            }
            local music_tab, music_pane, window = window:spawn_tab {
              cwd = default_dir,
            }

            journal_tab:set_title 'Journal'
            config_tab:set_title 'NixLand'
            music_tab:set_title 'Music'

            config_pane:send_text 'nvim .\n'
            journal_pane:send_text 'nvim .\n'
            music_pane:send_text 'spotify_player \n'
            default_tab:activate()



            -- We want to startup in the workflow workspace
            mux.set_active_workspace 'workflow'
          end)
          return config
        '';
      };
      dircolors = {
        enable = true;
        enableZshIntegration = true;
      };
      bash = {
        enable = true;
        initExtra = "SHELL=${pkgs.bash}";
      };
      starship = {
        enable = true;
        settings = {
          add_newline = false;
          scan_timeout = 5;
          character = {
            error_symbol = "[󰊠](bold red)";
            success_symbol = "[󰊠](bold green)";
            vicmd_symbol = "[󰊠](bold yellow)";
            format = "$symbol [|](bold bright-black) ";
          };
          git_commit = {
            commit_hash_length = 4;
          };
          line_break.disabled = false;
          lua.symbol = "[](blue) ";
          python.symbol = "[](blue) ";
          hostname = {
            ssh_only = true;
            format = "[$hostname](bold blue) ";
            disabled = false;
          };
        };
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        sessionVariables = {
          LC_ALL = "en_US.UTF-8";
          ZSH_AUTOSUGGEST_USE_ASYNC = "true";
          SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
          GOPATH = "$HOME/.local/share/go";
        };
        initContent = ''
          path+="$HOME/.local/share/go/bin"
        '';
        history = {
          save = 1000;
          size = 1000;
          expireDuplicatesFirst = true;
          ignoreDups = true;
          ignoreSpace = true;
        };
      };
    };
  };
}
