{
  description = "cofibrant's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      darwin,
      home-manager,
      nixpkgs,
      ...
    }:
    with nixpkgs.lib;
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
      };

      mkHomeManagerConfiguration =
        {
          username ? "nathan",
          antidotfiles,
        }:
        { ... }:
        {
          nixpkgs = nixpkgsConfig;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${username}" = {
              imports = [ ./home ];
              config.antidotfiles = antidotfiles;
            };
          };
        };

      mkDarwinConfiguration =
        name:
        {
          system ? "aarch64-darwin",
          username ? "nathan",
          antidotfiles ? { },
        }:
        nameValuePair name (
          darwin.lib.darwinSystem {
            inherit system;
            modules = [
              (
                { pkgs, ... }:
                {
                  networking.hostName = name;
                  users = {
                    users."${username}" = {
                      name = username;
                      home = "/Users/${username}";
                      shell = pkgs.fish;
                    };
                  };
                }
              )
              # main `nix-darwin` config
              (import ./configuration.nix)
              # `home-manager` module
              home-manager.darwinModules.home-manager
              # `home-manager` config
              (mkHomeManagerConfiguration {
                inherit username antidotfiles;
              })
            ];
          }
        );
    in
    {
      darwinConfigurations = mapAttrs' mkDarwinConfiguration {
        mithridate = {
          antidotfiles.typesetting.enable = true;
        };
        nepenthe = {
          antidotfiles.git = {
            email = "n_corbyn@apple.com";
            hooksPath = "dt-git-hooks/hooks";
          };
        };
      };

      overlays = {
        # Overlay useful on Macs with Apple Silicon
        apple-silicon =
          final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Add access to x86 packages system is running Apple Silicon
            pkgs-x86 = import inputs.nixpkgs-unstable {
              system = "x86_64-darwin";
              inherit (nixpkgsConfig) config;
            };
          };
      };
    };
}
