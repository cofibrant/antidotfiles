{ pkgs, ... }:

{
  programs.gh = {
    enable = true;
    settings.editor = "${pkgs.neovim}/bin/nvim";
    gitCredentialHelper = {
      enable = true;
    };
  };
}
