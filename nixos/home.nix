{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    fuzzel = "fuzzel";
    hypr = "hypr";
    nvim = "nvim";
    oh-my-posh = "oh-my-posh";
    swaync = "swaync";
    tmux = "tmux";
    waybar = "waybar";
    wlogout = "wlogout";
  };
in

{
  home = {
    username = "lachau";
    homeDirectory = "/home/lachau";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/.config/${subpath}";
    recursive = true;
  }) configs;

  home.file = {
    ".zshrc".source = create_symlink "${dotfiles}/.zshrc";
    ".gitconfig".source = create_symlink "${dotfiles}/.gitconfig";
    ".local/scripts" = {
      source = create_symlink "${dotfiles}/.local/scripts";
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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
    bat
    eza
    fd
    fzf
    oh-my-posh
    ripgrep
    tmux
    tree
    zoxide

    lazygit
    neovim

    fnm
    go
    rustup
    uv

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
}
