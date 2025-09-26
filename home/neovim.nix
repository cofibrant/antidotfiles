{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with config.antidotfiles.toggles;
{
  home.file."./.config/nvim/lua/themes/" = optionals enableDevTools {
    source = ./neovim/themes;
    recursive = true;
  };

  programs.neovim = {
    enable = enableDevTools;

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

        luaConfig = pkg: file: {
          plugin = pkg;
          config = builtins.readFile file;
          type = "lua";
        };
      in
      [
        {
          plugin = base46;
          config = ''
            require('nvconfig').base46.theme = "iro"
            require('base46').load_all_highlights()
          '';
          type = "lua";
        }

        (luaConfig telescope-nvim ./neovim/plugins/telescope.lua)
        (luaConfig (nvim-treesitter.withPlugins (p: [
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
        ])) ./neovim/plugins/treesitter.lua)

        nvim-treesitter-textobjects

        {
          plugin = nvim-lspconfig;
          # nixfmt: off
          config = ''
            local lsp = vim.lsp

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

            lsp.config('nixd', {
              cmd = { '${pkgs.nixd}/bin/nixd' },
              filetypes = { 'nix' },
              root_markers = { 'flake.nix' },
            })

            lsp.enable('rust-analyzer')
            lsp.enable('clangd')
            lsp.enable('nixd')
          '';
          # nixfmt: off
          type = "lua";
        }

        {
          plugin = conform-nvim;
          # nixfmt: off
          config = ''
            require("conform").setup({
              formatters = {
                stylua = { command = "${pkgs.stylua}/bin/stylua" },
                clang_format = { command = "${pkgs.clang-tools}/bin/clang-format" },
                nixfmt = { command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt" },
                rustfmt = { command = "${pkgs.rustup}/bin/rustup", args = { "run", "stable", "rustfmt" } },
                black = { command = "${pkgs.black}/bin/black" },
              },
              formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                rust = { "rustfmt" },
                cpp = { "clang_format" },
                nix = { "nixfmt" },
                default_format_opts = {
                  lsp_format = "fallback",
                },
                ["_"] = { "trim_whitespace", lsp_format = "prefer" },
              },
              format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
              },
            })'';
          # nixfmt: on
          type = "lua";
        }

        targets-vim
        vim-fugitive
        vim-vsnip
        friendly-snippets

        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-vsnip

        (luaConfig nvim-cmp ./neovim/plugins/cmp.lua)
        (luaConfig nvim-tree-lua ./neovim/plugins/tree.lua)

        (autoConfig nvim-web-devicons "nvim-web-devicons")
        (autoConfig comment-nvim "Comment")
        (autoConfig nvim-colorizer-lua "colorizer")
        # TODO(@cofibrant) on attach bindings for blame
        (autoConfig gitsigns-nvim "gitsigns")
        (autoConfig trouble-nvim "trouble")

        {
          plugin = nvim-colorizer-lua;
          # nixfmt: off
          config = ''
            require('colorizer').setup({
              filetypes = { "*" },
              user_default_options = { names = false },
              buftypes = {},
            })'';
          # nixfmt: on
          type = "lua";
        }

        {
          plugin = indent-blankline-nvim;
          # nixfmt: off
          config = ''
            require('ibl').setup({
              indent = { char = "│", highlight = "IblChar" },
              scope = { char = "│", highlight = "IblScopeChar" },
            })'';
          # nixfmt: on
          type = "lua";
        }

        (luaConfig nvim-autopairs ./neovim/plugins/autopairs.lua)
        (luaConfig lualine-nvim ./neovim/plugins/lualine.lua)

        {
          plugin = toggleterm-nvim;
          # nixfmt: off
          config = ''
            require('toggleterm').setup({
              shade_terminals = false,
              direction = 'horizontal',
              open_mapping = [[<C-\>]]
            })'';
          # nixfmt: on
          type = "lua";
        }
      ];
  };
}
