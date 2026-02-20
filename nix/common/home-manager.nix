{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    nvim = "nvim";
    oh-my-posh = "oh-my-posh";
    tmux = "tmux";
  };
in
{
  home.username = "lachau";
  home.stateVersion = "26.05";
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
    rustup
    uv

    direnv
  ];
}
