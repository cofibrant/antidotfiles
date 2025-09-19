{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./neovim/settings.lua}
      ${builtins.readFile ./neovim/keymaps.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = builtins.readFile ./neovim/plugins/gruvbox.lua;
        type = "lua";
      }
    ];
  };
}
