{ pkgs, config, ... }:

{
  programs.gh = {
    enable = config.antidotfiles.toggles.enableGit;
    settings.editor = "${pkgs.neovim}/bin/nvim";
    gitCredentialHelper = {
      enable = true;
    };
  };
}
