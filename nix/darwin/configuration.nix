{ pkgs, config, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    [
      pkgs.ollama
      pkgs.opencode
      pkgs.wget
      pkgs.wimlib
    ];

  homebrew = {
    enable = true;
    brews = [];
    casks = [
      "alacritty"
      "battery"
      "brave-browser"
      "bruno"
      "docker-desktop"
      "hiddenbar"
      "legcord"
      "scroll-reverser"
      "the-unarchiver"
      "zed"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  fonts.packages =
    [
      pkgs.nerd-fonts.jetbrains-mono
    ];

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = [ "/Applications" ];
    };
  in
    pkgs.lib.mkForce ''
    # Set up applications.
    echo "setting up /Applications..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
    done
        '';

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  system.primaryUser = "lachau";
  users.users.lachau.home = "/Users/lachau";
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}
