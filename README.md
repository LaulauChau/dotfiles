# My dotfiles

Dotfiles managed through nix-darwin.

## Installation

### MacOS

1. Install Nix package manager
```sh
sh <(curl -L https://nixos.org/nix/install)

# Create the nix-darwin configuration directory
sudo mkdir -p /etc/nix-darwin

# Change the owner of the directory to the current user
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin

cd /etc/nix-darwin
```

2. Initialize the nix-darwin configuration
```sh
# Initialize the nix-darwin configuration
# nix flake init -t nix-darwin/master # for the unstable version
nix flake init -t nix-darwin/nix-darwin-24.11

# Edit the hostname in flake.nix
sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
```
Make sure to change `nixpkgs.hostPlatform` to `aarch64-darwin` if you are using Apple Silicon.

3. Install nix-darwin
```sh
# nix run nix-darwin/master#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch # for the unstable version
nix run nix-darwin/nix-darwin-24.11#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch
```

4. You can now clone the dotfiles repository (you will maybe need to add git to the package list in your `flake.nix`)
```sh
cd ~

git clone https://github.com/LaulauChau/dotfiles.git
```

5. Apply changes to your system (this will be the command you will run everytime you update any dotfile)
```sh
sudo darwin-rebuild switch --flake ~/dotfiles/.config/nix-darwin#hostname
```

6. Sync the other dotfiles
```sh
cd ~/dotfiles

stow .
```
