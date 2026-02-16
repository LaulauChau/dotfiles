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
    tmux = "tmux";
    waybar = "waybar";
    wlogout = "wlogout";
  };
in

{
  home.username = "lachau";
  home.homeDirectory = "/home/lachau";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    # Hyprland
    brightnessctl
    cliphist
    fuzzel
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    swaynotificationcenter
    waybar
    wl-clipboard
    wlogout
    wlsunset
    
    brave
    nerd-fonts.jetbrains-mono
    
    # Shell & Terminal
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

    # Editor & git
    lazygit
    neovim

    # Version managers
    fnm
    go
    rustup
    uv

    # Base development
    binutils
    gcc
    gnumake
    libffi
    openssl
    zlib

    # Utilities
    claude-code
    ollama
    opencode
    stow
    wget
  ];

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
}
