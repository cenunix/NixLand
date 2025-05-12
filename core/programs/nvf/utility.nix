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
  hm.programs.nvf.settings.vim.utility = {
    preview = {
      markdownPreview = {
        enable = true;
      };
    };
    snacks-nvim = {
      enable = true;
      setupOpts = {
        explorer = {
          replace_netrw = true;
        };
        picker = {
          layout = {
            preset = "telescope";
          };
          # preview = true;
          sources = {
            explorer = {
              jump = {
                close = true;
              };
              # auto_close = true;
              layout = {
                preset = "telescope";
                preview = true;
              };
            };
          };
          input = { };
          notifier = { };
        };
        image = {
          enabled = true;
          doc = {
            float = true;
            max_width = 20;
            max_height = 10;
          };
        };
      };
    };
  };
}
