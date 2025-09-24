{ pkgs, ... }:

{
  home.file."./.config/nvim/lua/themes/" = {
    source = ./neovim/themes;
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = builtins.readFile ./neovim/settings.lua;
    plugins =
      with pkgs.vimPlugins;
      let
        autoConfig = pkg: require: {
          plugin = pkg;
          config = "require('${require}').setup()";
          type = "lua";
        };
      in [
      {
        plugin = base46;
        config = ''
          require('nvconfig').base46.theme = "iro"
          require('base46').load_all_highlights()
        '';
        type = "lua";
      }

      {
        plugin = telescope-nvim;
        config = builtins.readFile ./neovim/plugins/telescope.lua;
        type = "lua";
      }

      {
        plugin = (nvim-treesitter.withPlugins(p: [
          p.tree-sitter-nix
          p.tree-sitter-lua
          p.tree-sitter-vim
          p.tree-sitter-json
          p.tree-sitter-python
          p.tree-sitter-cpp
          p.tree-sitter-rust
          p.tree-sitter-html
          p.tree-sitter-css
          p.tree-sitter-javascript
          p.tree-sitter-json
        ]));
        config = builtins.readFile ./neovim/plugins/treesitter.lua;
        type = "lua";
      }

      nvim-treesitter-textobjects

      {
        plugin = nvim-lspconfig;
        config = ''local lsp = vim.lsp

          lsp.config('rust-analyzer', {
            cmd = { '${pkgs.rust-analyzer}/bin/rust-analyzer' },
            filetypes = { 'rust' },
            root_markers = { 'Cargo.toml' },
          })
          
          lsp.config('clangd', {
            cmd = { '${pkgs.clang-tools}/bin/clangd' },
            filetypes = { 'c', 'cpp' },
            root_markers = { '.clangd', 'compile_commands.json' },
          })
          
          lsp.enable('rust-analyzer')
          lsp.enable('clangd')'';
        type = "lua";
      }

      targets-vim
      vim-vsnip
      friendly-snippets

      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-vsnip

      {
        plugin = nvim-cmp;
        config = builtins.readFile ./neovim/plugins/cmp.lua;
        type = "lua";
      }

      {
        plugin = nvim-tree-lua;
        config = builtins.readFile ./neovim/plugins/tree.lua;
        type = "lua";
      }

      (autoConfig nvim-web-devicons "nvim-web-devicons")
      (autoConfig comment-nvim "Comment")
      (autoConfig nvim-colorizer-lua "colorizer")
      # TODO(@cofibrant) on attach bindings for blame
      (autoConfig gitsigns-nvim "gitsigns")
      (autoConfig trouble-nvim "trouble")
      (autoConfig auto-save-nvim "auto-save")

      {
        plugin = nvim-colorizer-lua;
        config = ''require('colorizer').setup({
          filetypes = { "*" },
          user_default_options = { names = false },
          buftypes = {},
        })'';
        type = "lua";
      }

      {
        plugin = indent-blankline-nvim;
        config = ''require('ibl').setup({
          indent = { char = "│", highlight = "IblChar" },
          scope = { char = "│", highlight = "IblScopeChar" },
        })'';
        type = "lua";
      }

      {
        plugin = nvim-autopairs;
        config = builtins.readFile ./neovim/plugins/autopairs.lua;
        type = "lua";
      }

      {
        plugin = lualine-nvim;
        config = builtins.readFile ./neovim/plugins/lualine.lua;
        type = "lua";
      }

      {
        plugin = toggleterm-nvim;
        config = ''require('toggleterm').setup({
          shade_terminals = false,
          direction = 'horizontal',
          open_mapping = [[<C-\>]]
        })'';
        type = "lua";
      }
    ];
  };
}
