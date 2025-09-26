{ pkgs, config, ... }:

{
  programs.git = {
    enable = config.antidotfiles.git.enable;
    userEmail = "me@nathancorbyn.com";
    userName = "Nathan Corbyn";
    extraConfig = {
      credential.helper = "store";
      core.askPass = "";
      core.editor = "${pkgs.neovim}/bin/nvim";
      core.pager = "${pkgs.gitAndTools.delta}/bin/delta";
      pull.rebase = true;
    };
  };
}
