{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/lachau";

  home.packages = with pkgs; [
    git
    gnupg
    go
  ];

  imports = [
    ./common/home-manager.nix
  ];
}
