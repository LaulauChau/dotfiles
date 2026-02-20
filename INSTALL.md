# Installation

This guide covers setting up these dotfiles on macOS (nix-darwin) and NixOS.

## macOS (nix-darwin)

### 1. Install Nix Package Manager

```bash
sh <(curl -L https://nixos.org/nix/install)
```

Follow the prompts. After installation, you'll need to either:
- Start a new terminal session, or
- Run `source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh`

### 2. Initialize nix-darwin

Follow the official nix-darwin installation guide:

https://github.com/nix-darwin/nix-darwin

Quick summary:
```bash
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin
nix flake init -t nix-darwin/nix-darwin-24.11
```

Make sure to change `nixpkgs.hostPlatform` to `aarch64-darwin` if you are using Apple Silicon.

### 3. Clone Dotfiles

```bash
cd ~
git clone https://github.com/LaulauChau/dotfiles.git
```

### 4. Apply Configuration

```bash
cd ~/dotfiles/nix
darwin-rebuild switch --flake .#amaterasu
```

This will:
- Update your system configuration
- Install required packages
- Set up Home Manager with dotfile symlinks

### 5. Reload Shell

Start a new terminal session to pick up all changes, or:

```bash
exec zsh
```

## NixOS

### 1. Install NixOS

Follow the official NixOS installation guide:

https://nixos.org/manual/nixos/stable/index.html#sec-installation

During installation, create your user with the same username you'll use with these dotfiles (`lachau` by default).

### 2. Clone Dotfiles

```bash
cd ~
git clone https://github.com/LaulauChau/dotfiles.git
```

### 3. Apply Configuration

```bash
cd ~/dotfiles/nix
sudo nixos-rebuild switch --flake .#nixos-btw
```

This will:
- Update your system configuration
- Install required packages
- Set up Home Manager with dotfile symlinks

### 4. Reload Shell

Start a new terminal session or:

```bash
exec zsh
```

## Troubleshooting

### Git Lock File Error

If you encounter:
```
fatal: Unable to create '.git/index.lock': File exists.
```

Remove the lock file:
```bash
rm -f ~/dotfiles/.git/index.lock
```

### Flakes Not Found

If you get "flake not found" errors, ensure flakes are enabled:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Then re-run the rebuild command.

### Home Manager Conflicts

If Home Manager reports conflicts with existing files, check for backup files:
```bash
ls -la ~/config/alacritty.backup
ls -la ~/.zshrc.backup
```

The `backupFileExtension = "backup"` setting in the config creates these. Review the backups and remove them if desired.

### Missing Packages After Rebuild

If packages aren't available in your shell after a rebuild:
1. Ensure you're using the correct shell (zsh)
2. Check that Home Manager was installed: `home-manager --version`
3. Try reloading your shell: `exec zsh`
4. Check the build log for any errors

### nix-darwin Build Errors

If `darwin-rebuild` fails:
1. Update flake lock: `cd ~/dotfiles/nix && nix flake update`
2. Check for NixOS/nixpkgs issues in the GitHub repository
3. Try building first to see detailed errors: `darwin-rebuild build --flake .#amaterasu`

### NixOS Build Errors

If `nixos-rebuild` fails:
1. Update flake lock: `cd ~/dotfiles/nix && nix flake update`
2. Check hardware configuration matches your system in `nix/linux/hardware-configuration.nix`
3. Try building first: `sudo nixos-rebuild build --flake .#nixos-btw`

## Post-Installation

After successful installation:

1. **Verify symlinks:**
   ```bash
   ls -la ~/.config/alacritty
   ls -la ~/.zshrc
   ```

2. **Test templates:**
   ```bash
   nix flake init -t ~/dotfiles/nix#go
   ```

3. **Set up direnv** (for automatic devshell loading):
   ```bash
   eval "$(direnv hook zsh)"
   ```

Add the direnv hook to your `~/.zshrc` if you want it to persist.
