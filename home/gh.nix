{ pkgs, config, ... }:

{
  programs.gh = {
    enable = config.antidotfiles.git.enable;
    settings.editor = "${pkgs.neovim}/bin/nvim";
    gitCredentialHelper = {
      enable = true;
    };
  };
}
