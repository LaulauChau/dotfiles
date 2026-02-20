{
  description = "nix config (darwin + nixos)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager, flake-utils }:
    {
      darwinConfigurations."amaterasu" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            nix-homebrew.autoMigrate = true;
            nix-homebrew.enable = true;
            nix-homebrew.enableRosetta = true;
            nix-homebrew.user = "lachau";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.lachau = import ./home-darwin.nix;
          }
        ];
      };

      nixosConfigurations."nixos-btw" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./linux/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.lachau = import ./home-linux.nix;
          }
        ];
      };

      templates = {
        default = { description = "Base devshell"; path = ./templates/default; };
        go = { description = "Go devshell"; path = ./templates/go; };
        js = { description = "JS/TS devshell"; path = ./templates/js; };
        python = { description = "Python devshell"; path = ./templates/python; };
      };
    };
}
