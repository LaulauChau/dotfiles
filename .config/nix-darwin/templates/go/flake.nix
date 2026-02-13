{
  description = "Go dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            air
            go
            golangci-lint
            go-migrate
            gosec
            sqlc
            templ
          ];

          shellHook = ''
            echo "Go dev environment loaded"
          '';
        };
      }
    );
}
