{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  mkKeymap = mode: key: action: desc: {
    inherit
      mode
      key
      action
      desc
      ;
  };
in
{
  hm.imports = [ inputs.nvf.homeManagerModules.default ];
  hm.programs.nvf = {
    enable = true;
    # most settings are documented in the appendix
    settings.vim = {
      viAlias = false;
      vimAlias = true;
      preventJunkFiles = true;
      enableLuaLoader = true;

      options = {
        shell = "zsh";
        guifont = "Inter Nerd Font:h14";
        termguicolors = true;
        undofile = true;
        smartindent = true;
        tabstop = 2;
        shiftwidth = 2;
        shiftround = true;
        expandtab = true;
        cursorline = true;
        relativenumber = true;
        number = true;
        viminfo = "";
        viminfofile = "NONE";
        wrap = false;
        clipboard = "unnamedplus";
        splitright = true;
        splitbelow = true;
        laststatus = 0;
        cmdheight = 0;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
      };
      binds.whichKey = {
        enable = true;
        register = {
          "<leader>f" = " Picker";
          "<leader>g" = " Git";
          "<leader>t" = " Terminal";
          "<leader>l" = " LSP";
          "<leader>c" = " Spellcheck";
          "<leader>cl" = "󰗊 Language";
          "<leader>o" = " Obsidian";
          "<leader>d" = "Debug";
          "<leader>h" = "";
        };
        setupOpts = {
          preset = "classic";
          delay = 0;
          icons = {
            mappings = false;
            separator = "➜";
            group = "";
          };
          win.border = "none";
          triggers = [
            {
              "@" = "<leader>";
              mode = "n";
            }
          ];
        };
      };
      keymaps = [
        (mkKeymap "n" "<leader>w" "<cmd>w<cr>" "Save Buffer")
        (mkKeymap "n" "<leader>q" "<cmd>q<cr>" "Quit")
        (mkKeymap "n" "<leader>e" ":Neotree action=focus reveal toggle<cr>" "Toggle Neotree")
        (mkKeymap "n" "<leader>c" ":bdelete!<CR>" "Close Buffer")

        # Telescope
        (mkKeymap "n" "<leader>ff" "<cmd>Telescope find_files<cr>" "Find File")
        (mkKeymap "n" "<leader>fr" "<cmd>Telescope oldfiles<cr>" "Open Recent File")
        (mkKeymap "n" "<leader>fn" "<cmd>enew<cr>" "New File")
        (mkKeymap "n" "<leader>fw" "<cmd>Telescope live_grep<cr>" "Grep Files")
        (mkKeymap "n" "<leader>fb" "<cmd>Telescope buffers<cr>" "Grep Buffers")
        (mkKeymap "n" "<leader>fh" "<cmd>Telescope help_tags<cr>" "Grep Help Tags")
        (mkKeymap "n" "<leader>fd" "<cmd>Telescope diagnostics<cr>" "Grep Diagnostics")
        (mkKeymap "n" "<leader>fg" "<cmd>Telescope git_files<cr>" "Grep Git Files")

        # Terminal
        (mkKeymap "n" "<leader>tt" "<cmd>ToggleTerm<cr>" "Toggle Terminal")
        (mkKeymap "n" "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" "Toggle Float Terminal")
        (mkKeymap "t" "<Esc>" "<C-\\><C-N>" "Exit Insert Mode")

        # Git
        (mkKeymap "n" "<leader>gl" "<cmd>Gitsigns blame_line<cr>" "View Git Blame")
        (mkKeymap "n" "<leader>gL" "<cmd>Gitsigns blame_line {full = true}<cr>" "View full Git Blame")
        (mkKeymap "n" "<leader>gp" "<cmd>Gitsigns preview_hunk<cr>" "Preview Git Hunk")
        (mkKeymap "n" "<leader>gh" "<cmd>Gitsigns reset_hunk<cr>" "Reset Git Hunk")
        (mkKeymap "n" "<leader>gr" "<cmd>Gitsigns reset_buffer<cr>" "Reset Git Buffer")
        (mkKeymap "n" "<leader>gs" "<cmd>Gitsigns stage_hunk<cr>" "Stage Git Hunk")
        (mkKeymap "n" "<leader>gS" "<cmd>Gitsigns stage_buffer<cr>" "Stage Git Buffer")
        (mkKeymap "n" "<leader>gu" "<cmd>Gitsigns undo_stage_hunk<cr>" "Unstage Git Hunk")
        (mkKeymap "n" "<leader>gd" "<cmd>Gitsigns diffthis<cr>" "View Git Diff")

        #LSP
        (mkKeymap "n" "<leader>li" "<cmd>LspInfo<cr>" "LSP Information")
        (mkKeymap "n" "<leader>lI" "<cmd>NullLsInfo<cr>" "Null-ls Information")
        (mkKeymap "n" "<leader>la" "<cmd>lua vim.lsp.buf.code_action()<cr>" "LSP Code Action")
        (mkKeymap "n" "<leader>lh" "<cmd>lua vim.lsp.buf.signature_help()<cr>" "Signature Help")
        (mkKeymap "n" "<leader>lr" "<cmd>lua vim.lsp.buf.rename()<cr>" "Rename Current Symbol")
        (mkKeymap "n" "<leader>ll" "<cmd>lua vim.lsp.codelens.refresh()<cr>" "LSP CodeLens Refresh")
        (mkKeymap "n" "<leader>lL" "<cmd>lua vim.lsp.codelens.run()<cr>" "LSP CodeLens Run")
        (mkKeymap "n" "<leader>lR" "<cmd>Telescope lsp_references<cr>" "Search References")

        #Goto Bindings
        (mkKeymap "n" "gd" "<cmd>Telescope lsp_definitions<cr>" "Goto Definition")
        (mkKeymap "n" "gI" "<cmd>Telescope lsp_implementations<cr>" "Goto Implementation")
        (mkKeymap "n" "gr" "<cmd>Telescope lsp_references<cr>" "Search References")
        (mkKeymap "n" "gl" "<cmd>lua vim.diagnostic.open_float()<CR>" "Hover Diagnostics")
        (mkKeymap "n" "gy" "<cmd>Telescope lsp_type_definitions<cr>" "Definition of Current Type")

        #Buffer Nav
        (mkKeymap "n" "<S-h>" "<cmd>BufferLineCyclePrev<cr>" "Left Buffer")
        (mkKeymap "n" "<S-l>" "<cmd>BufferLineCycleNext<cr>" "Right Buffer")
        (mkKeymap "n" "K" "<cmd>lua vim.lsp.buf.hover()<cr>" "Hover Symbol Details")
      ];
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
      utility = {
        preview = {
          markdownPreview = {
            enable = true;
          };
        };
        images = {
          image-nvim = {
            enable = true;
            setupOpts = {
              backend = "kitty";
            };
          };
        };
      };
      statusline.lualine = {
        enable = true;
        theme = "catppuccin";
        setupOpts = {
          icons_enabled = true;
          section_separators = {
            left = "";
            right = "";
          };
          component_separators = {
            left = "";
            right = "";
          };
          disabled_filetypes = {
            statusline = [ ];
            winbar = [ ];
          };
          ignore_focus = [ ];
          always_divide_middle = true;
          globalstatus = false;
          refresh = {
            statusline = 1000;
            tabline = 1000;
            winbar = 1000;
          };
        };

        # Active sections: we use the built-in "mode" component (which will use our custom mapping)
        activeSection.a = [
          "{
              (function()
               local mode_map = {
                 ['n']   = '',
                 ['no']  = '',
                 ['nov'] = '',
                 ['noV'] = '',
                 ['no�'] = '',
                 ['niI'] = '',
                 ['niR'] = '',
                 ['niV'] = '',
                 ['nt']  = '',
                 ['v']   = '',
                 ['vs']  = '',
                 ['V']   = '',
                 ['Vs']  = '',
                 ['�']   = '',
                 ['�s']  = '',
                 ['s']   = '',
                 ['S']   = '',
                 ['�']   = '',
                 ['i']   = '',
                 ['ic']  = '',
                 ['ix']  = '',
                 ['R']   = '',
                 ['Rc']  = '',
                 ['Rx']  = '',
                 ['Rv']  = '',
                 ['Rvc'] = '',
                 ['Rvx'] = '',
                 ['c']   = '',
                 ['cv']  = '',
                 ['ce']  = '',
                 ['r']   = '',
                 ['rm']  = '',
                 ['r?']  = '',
                 ['!']   = '',
                 ['t']   = '',
               }
               return function()
                 return mode_map[vim.api.nvim_get_mode().mode] or '__'
               end
            end)(),
          }"
        ];
        activeSection.b = [
          ''
            {
              "branch",
              icon = ' •',
            }
          ''
        ];
        activeSection.c = [ ];
        activeSection.x = [ ];
        activeSection.y = [ ];
        activeSection.z = [ ];

        # Inactive sections
        inactiveSection.a = [ ];
        inactiveSection.b = [ ];
        inactiveSection.c = [ "'filename'" ];
        inactiveSection.x = [ "'location'" ];
        inactiveSection.y = [ ];
        inactiveSection.z = [ ];
      };
      telescope.enable = true;
      filetree = {
        neo-tree = {
          enable = true;
          setupOpts = {
            git_status_async = true;
            window = {
              position = "float";
              mapping_options = {
                nowait = false;
              };
              mappings = {
                "<space>" = "none";
              };
            };
          };
        };
      };
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;

        # setupOpts.keymap.preset = "default";
        setupOpts.completion.menu.auto_show = false;
        setupOpts = {
          completion = {
            ghost_text = {
              enabled = true;
            };
          };
        };
        mappings = {
          close = "<C-e>";
          confirm = "<C-y>";
        };
      };
      languages = {
        enableLSP = true;
        enableDAP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix = {
          enable = true;
          format.package = pkgs.nixfmt-rfc-style;
          format.type = "nixfmt";
        };
        clang = {
          enable = true;
          lsp = {
            enable = true;
            package = pkgs.clang-tools_19;
            server = "clangd";
          };
        };
        sql.enable = true;
        rust = {
          enable = false;
          crates.enable = true;
        };
        html.enable = true;
        ts.enable = true;
        go.enable = true;
        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
        python = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
        };
        lua = {
          enable = true;
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
      tabline = {
        nvimBufferline = {
          enable = true;
          setupOpts = {
            options = {
              sort_by = "insert_at_end";
              indicator = {
                style = "none";
              };
              offsets = [
                {
                  filetype = "neo-tree";
                  highlight = "File Tree";
                  separator = true;
                  text_align = "left";
                }
              ];
              diagnostics = "nvim_lsp";
              seperator_style = [
                ""
                ""
              ];
              modified_icon = "●";
              show_close_icon = false;
              show_buffer_close_icons = false;
            };
            highlights = {
              background = {
                bg = "NONE";
              };
              buffer_visible = {
                fg = "#45475A";
                bg = "NONE";
              };
              buffer_selected = {
                fg = "#D9E0EE";
                bg = "NONE";
                bold = true;
                italic = true;
              };
              duplicate_selected = {
                fg = "#D9E0EE";
                bg = "NONE";
                bold = true;
                italic = true;
              };
              duplicate_visible = {
                fg = "#45475A";
                bg = "NONE";
                bold = true;
                italic = true;
              };
              duplicate = {
                fg = "#45475A";
                bg = "NONE";
                bold = true;
                italic = true;
              };
              tab = {
                fg = "#45475A";
                bg = "NONE";
              };
              tab_selected = {
                fg = "#89DCEB";
                bg = "NONE";
                bold = true;
              };
              tab_separator = {
                fg = "NONE";
                bg = "NONE";
              };
              tab_separator_selected = {
                fg = "NONE";
                bg = "NONE";
              };
              info = {
                fg = "#585B70";
              };
              info_diagnostic = {
                fg = "#585B70";
              };
              hint = {
                fg = "#585B70";
                bg = "NONE";
              };
              hint_diagnostic = {
                fg = "#585B70";
              };
              warning = {
                fg = "#F9E2AF";
                bg = "NONE";
              };
              warning_visible = {
                fg = "#F9E2AF";
                bg = "NONE";
              };
              warning_selected = {
                fg = "#F9E2AF";
                bg = "NONE";
                bold = true;
                italic = true;
              };
              warning_diagnostic = {
                fg = "#F9E2AF";
                bg = "NONE";
              };
              warning_diagnostic_visible = {
                fg = "#F9E2AF";
                bg = "NONE";
              };
              warning_diagnostic_selected = {
                fg = "#F9E2AF";
                bg = "NONE";
              };
              error = {
                fg = "#585B70";
                bg = "NONE";
              };
              error_diagnostic = {
                fg = "#585B70";
              };
              separator = {
                fg = "NONE";
                bg = "NONE";
              };
              separator_visible = {
                fg = "NONE";
                bg = "NONE";
              };
              separator_selected = {
                fg = "NONE";
                bg = "NONE";
              };
              offset_separator = {
                fg = "NONE";
                bg = "NONE";
              };
              fill = {
                bg = "NONE";
              };
            };
          };
        };
      };
    };
  };
}
