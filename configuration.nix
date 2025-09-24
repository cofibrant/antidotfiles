{ pkgs, lib, ... }:
{
  system.stateVersion = 4;

  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [ "@admin" ];

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  ''
  + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  programs.fish.enable = true;

  environment.systemPackages = [ ];
  environment.shells = with pkgs; [
    fish
    zsh
  ];

  users = {
    users.nathan = {
      name = "nathan";
      home = "/Users/nathan";
      shell = pkgs.fish;
    };
  };
}
