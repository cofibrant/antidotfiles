{ config, lib, ... }:

{
  programs.direnv = {
    enable = config.antidotfiles.cliUtils.enable;
    nix-direnv.enable = true;
  };
}
