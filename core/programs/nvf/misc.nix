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
      avante-nvim = {
        package = pkgs.vimPlugins.avante-nvim;
        setup = "
          require('avante').setup ({
            mode = 'agentic'
            provider = 'ollama',
            auto_suggestions_provider = 'ollama',
            behaviour = {
              enable_cursor_planning_mode = true,
            },
            rag_service = {
              enabled = true, -- Enables the RAG service
              host_mount = os.getenv('HOME'), -- Host mount path for the rag service
              provider = 'ollama', -- The provider to use for RAG service (e.g. openai or ollama)
              llm_model = 'qwen2.5-coder:7b', -- The LLM model to use for RAG service
              embed_model = 'nomic-embed-text', -- The embedding model to use for RAG service
              endpoint = 'http://localhost:11434', -- The API endpoint for RAG service
              runner = 'nix',
            },
            ollama = {
              endpoint = 'http://localhost:11434',
              model = 'qwen2.5-coder:7b',
            }
          })
        ";
      };
      minuet = {
        package = pkgs.vimPlugins.minuet-ai-nvim;
        setup = "
          require('minuet').setup {
            provider = 'openai_fim_compatible',
              n_completions = 1, -- recommend for local model for resource saving
              -- I recommend beginning with a small context window size and incrementally
              -- expanding it, depending on your local computing power. A context window
              -- of 512, serves as an good starting point to estimate your computing
              -- power. Once you have a reliable estimate of your local computing power,
              -- you should adjust the context window to a larger value.
              context_window = 1024,
              provider_options = {
                  openai_fim_compatible = {
                      -- For Windows users, TERM may not be present in environment variables.
                      -- Consider using APPDATA instead.
                      api_key = 'TERM',
                      name = 'Ollama',
                      end_point = 'http://localhost:11434/v1/completions',
                      model = 'qwen2.5-coder:7b',
                      optional = {
                          max_tokens = 70,
                          top_p = 0.9,
                      },
                  },
              },
          }
          ";
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

      setupOpts = {
        keymap = {
          "<A-y>" = [
            (lib.generators.mkLuaInline ''
              function(cmp)
                cmp.show { providers = { 'minuet' } }
              end
            '')
          ];
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];

          providers = {
            minuet = {
              name = "minuet";
              module = "minuet.blink";
              async = true;
              #Should match minuet.config.request_timeout * 1000,
              #since minuet.config.request_timeout is in seconds
              timeout_ms = 3000;
              score_offset = 50;
            };
          };
        };
        snippets = {
          preset = "luasnip";
        };
        completion = {
          ghost_text = {
            enabled = true;
          };
          trigger = {
            prefetch_on_insert = false;
          };
        };
        appearance = {
          kind_icons = {
            Ollama = "󰳆";
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
