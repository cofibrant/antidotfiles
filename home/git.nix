{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
{
  programs.git = {
    enable = config.antidotfiles.git.enable;
    userEmail = config.antidotfiles.git.email;
    userName = "Nathan Corbyn";
    extraConfig = {
      credential.helper = "store";
      pull.rebase = true;
      core = {
        askPass = "";
        editor = "${pkgs.neovim}/bin/nvim";
        pager = "${pkgs.gitAndTools.delta}/bin/delta";
      }
      // optionalAttrs config.antidotfiles.git.hooks.enable {
        hooksPath = "${config.home.homeDirectory}/${config.antidotfiles.git.hooks.path}";
      };
    };
  };
}
