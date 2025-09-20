{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = builtins.readFile ./neovim/settings.lua;
    plugins = with pkgs.vimPlugins; [
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
        # TODO(@cofibrant) configure a sensible highlight colour
        plugin = visual-whitespace-nvim;
        config = "require('visual-whitespace').setup()";
        type = "lua";
      }
      {
        # TODO(@cofibrant) configure with iro colours
        plugin = base46;
        config = ''require('base46').load_all_highlights()'';
        type = "lua";
      }
    ];
  };
}
