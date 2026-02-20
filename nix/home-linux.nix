{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/lachau";

  home.packages = with pkgs; [
    brightnessctl
    cliphist

    fuzzel
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    libnotify
    swaynotificationcenter
    waybar
    wl-clipboard
    wlogout
    wlsunset

    brave
    nerd-fonts.jetbrains-mono

    alacritty

    go

    binutils
    gcc
    gnumake
    libffi
    openssl
    zlib

    claude-code
    ollama
    opencode
    stow
    wget
  ];

  imports = [
    ./common/home-manager.nix
  ];
}
