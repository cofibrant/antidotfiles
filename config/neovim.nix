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
        plugin = gruvbox-nvim;
        config = builtins.readFile ./neovim/plugins/gruvbox.lua;
        type = "lua";
      }

      {
        plugin = comment-nvim;
        config = builtins.readFile ./neovim/plugins/comment.lua;
	    type = "lua";
      }

      {
        plugin = nvim-tree-lua;
        config = builtins.readFile ./neovim/plugins/tree.lua;
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
    ];
  };
}
