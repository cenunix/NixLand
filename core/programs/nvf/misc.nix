{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  hm.programs.nvf.settings.vim = {
    extraPackages = with pkgs; [
      fd
      imagemagick
    ];
    extraPlugins = {
      snipe = {
        package = pkgs.vimPlugins.snipe-nvim;
        setup = "require('snipe').setup()";
      };
    };
    visuals = {
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
    };
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };
    telescope.enable = true;
    snippets = {
      luasnip.enable = true;
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      # setupOpts.keymap.preset = "default";
      # setupOpts.completion.menu.auto_show = false;
      setupOpts = {
        snippets = {
          preset = "luasnip";
        };
        completion = {
          ghost_text = {
            enabled = false;
          };
        };
      };
      mappings = {
        close = "<C-e>";
        confirm = "<C-y>";
      };
    };

    git = {
      gitsigns.enable = true;
    };
    terminal = {
      toggleterm = {
        enable = true;
      };
    };
    autopairs = {
      nvim-autopairs.enable = true;
    };
  };
}
