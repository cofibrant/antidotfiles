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
    plugins = with pkgs.vimPlugins; [
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
        ]));
        config = builtins.readFile ./neovim/plugins/treesitter.lua;
        type = "lua";
      }

      {
        plugin = nvim-tree-lua;
        config = "require('nvim-tree').setup()";
        type = "lua";
      }

      {
        plugin = comment-nvim;
        config = "require('Comment').setup()";
        type = "lua";
      }

      {
        # TODO(@cofibrant) on attach bindings for blame
        plugin = gitsigns-nvim;
        config = "require('gitsigns').setup()";
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

    ];
  };
}
