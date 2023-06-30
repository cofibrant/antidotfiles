{ pkgs, ... }:

let
  iro = pkgs.vimUtils.buildVimPlugin {
    name = "iro";
    src = pkgs.fetchFromGitHub {
      owner = "doctorn";
      repo = "iro";
      rev = "4f23412e5b24550989a180746291d031a81ee073";
      sha256 = "ykxz4JOIaL3gtP0LcSwkngHyD6Kj6JPihgdcqsF0GwY=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible

      vim-signify

      vim-fugitive
      vim-dispatch

      unite-vim
      vimproc-vim
      vimfiler-vim

      coc-nvim
      vim-nix
      rust-vim
      typescript-vim
      idris2-vim

      indentLine

      lightline-vim

      iro
    ];
    extraConfig = builtins.readFile ./.vimrc;

    vimAlias = true;
  };
}
