{ config, pkgs, ... }:

{
# Home Manager needs a bit of information about you and the
# paths it should manage.
  home.username = "lachau";
  home.homeDirectory = "/Users/lachau";

# This value determines the Home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new Home Manager release introduces backwards
# incompatible changes.
#
# You can update Home Manager without changing this value. See
# the Home Manager release notes for a list of state version
# changes in each release.
  home.stateVersion = "24.11";

  home.file = {
    ".config/alacritty".source = "${config.home.homeDirectory}/dotfiles/.config/alacritty";
    ".config/nvim".source = "${config.home.homeDirectory}/dotfiles/.config/nvim";
    ".config/ohmyposh".source = "${config.home.homeDirectory}/dotfiles/.config/ohmyposh";
    ".config/tmux".source = "${config.home.homeDirectory}/dotfiles/.config/tmux";
    ".gitconfig".source = "${config.home.homeDirectory}/dotfiles/.gitconfig";
    ".zshrc".source = "${config.home.homeDirectory}/dotfiles/.zshrc";
  };

# Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
