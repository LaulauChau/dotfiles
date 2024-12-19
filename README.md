# My dotfiles

Dotfiles managed through nix-darwin and home-manager.

## Installation

### MacOS

1. Install Nix package manager
```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. Manually copy the content of the nix-darwin folder. You can't clone the repository yet as you should not have git installed at this point
```sh
mkdir -p ~/.config/nix-darwin

touch ~/.config/nix-darwin/flake.nix
```

3. Build the configuration
```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin
```

4. You can now clone the dotfiles repository
```sh
git clone https://github.com/LaulauChau/dotfiles.git

cp ~/dotfiles/.config/nix-darwin/home.nix ~/.config/nix-darwin/home.nix
```

5. Apply changes to your system (this will be the command you will run everytime you update any dotfile)
```sh
darwin-rebuild switch --flake ~/.config/nix-darwin --impure
```
