{ config, lib, ... }:

{
  programs.direnv = {
    enable = config.antidotfiles.toggles.enableCLIUtils;
    nix-direnv.enable = true;
  };
}
