{
  description = "Zenful nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.act
          pkgs.android-tools
          pkgs.air
          pkgs.bat
          pkgs.cargo
          pkgs.discord
          pkgs.fd
          pkgs.fnm
          pkgs.fzf
          pkgs.gh
          pkgs.git
          pkgs.go
          pkgs.golangci-lint
          pkgs.gosec
          pkgs.go-migrate
          pkgs.lazygit
          pkgs.neovim
          pkgs.oh-my-posh
          pkgs.python3
          pkgs.qmk
          pkgs.ripgrep
          pkgs.rustup
          pkgs.templ
          pkgs.tmux
          pkgs.tree
          pkgs.sqlc
          pkgs.stow
          pkgs.wget
          pkgs.yazi
          pkgs.zoxide
        ];

      homebrew = {
        enable = true;
        brews = [
          "minikube"
        ];
        casks = [
          "android-studio"
          "battery"
          "cursor"
          "docker"
          "ghostty"
          "hiddenbar"
          "scroll-reverser"
          "the-unarchiver"
          "zen-browser"
        ];
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages =
        [
          # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
          pkgs.nerd-fonts.jetbrains-mono
        ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
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

      # Auto upgrade nix package and the daemon service.
      # services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.lachau.home = "/Users/lachau";
      # nix.configureBuildUsers = true;
      # nix.useDaemon = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBook-Pro-de-Laurent
    darwinConfigurations."amaterasu" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            autoMigrate = true;
            enable = true;
            enableRosetta = true;
            user = "lachau";
          };
        }
      ];
    };
  };
}
