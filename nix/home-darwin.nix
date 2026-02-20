{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/lachau";

  home.packages = with pkgs; [
    git
    gnupg
  ];

  imports = [
    ./common/home-manager.nix
  ];
}
