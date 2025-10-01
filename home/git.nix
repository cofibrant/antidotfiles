{ pkgs, config, ... }:

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
        hooksPath = config.antidotfiles.git.hooksPath;
      };
    };
  };
}
