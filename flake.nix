{
  description = "Nathan's darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
  let 
    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

    nixpkgsConfig = {
      config = { allowUnfree = true; };
    };
    
  in
  {
    darwinConfigurations = {
      mithridate = darwinSystem {
        system = "aarch64-darwin";
        modules = [ 
          # Main `nix-darwin` config
          ./configuration.nix
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            # `home-manager` config
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nathan = {...}: {
                imports = [
                  (import ./home.nix)
                  (import ./config)
                ];
              };
            };
          }
        ];
      };
    };

    overlays = {
      # Overlay useful on Macs with Apple Silicon
      apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
        # Add access to x86 packages system is running Apple Silicon
        pkgs-x86 = import inputs.nixpkgs-unstable {
          system = "x86_64-darwin";
          inherit (nixpkgsConfig) config;
        };
      }; 
    };
 };
}
