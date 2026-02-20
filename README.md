# My dotfiles

Managed through Nix with support for both macOS (nix-darwin) and NixOS.
Uses home-manager for dotfile management and package management.

## Quick Start

See [INSTALL.md](INSTALL.md) for installation instructions.

## Directory Structure

- `nix/` - Unified Nix configuration
  - `common/home-manager.nix` - Shared home-manager config (packages, symlinks, session vars)
  - `darwin/` - macOS system config
  - `linux/` - NixOS system config
  - `home-darwin.nix` - Darwin user packages
  - `home-linux.nix` - NixOS user packages
  - `templates/` - Devshell templates

## Managing Dotfiles

### Apply Changes

**macOS:**
```bash
cd ~/dotfiles/nix
darwin-rebuild switch --flake .#amaterasu
```

**NixOS:**
```bash
cd ~/dotfiles/nix
sudo nixos-rebuild switch --flake .#nixos-btw
```

## Templates

Templates provide pre-configured development environments. They use `direnv` for automatic loading when entering project directories.

### Available Templates

| Template | Description | Language/Tools |
|----------|-------------|----------------|
| `default` | Base devshell | None (empty template) |
| `go` | Go development | Go, air, golangci-lint, go-migrate, gosec, sqlc, templ |
| `js` | JavaScript/TypeScript | Bun, pnpm |
| `python` | Python development | Python3 |
| `rust` | Rust development | rust-analyzer, cargo-watch, openssl, pkg-config |

### Using Templates

```bash
# Initialize a new project with a template
nix flake init -t ~/dotfiles/nix#go

# Or from within dotfiles directory
cd ~/dotfiles/nix
nix flake init -t .#go

# Enable automatic loading with direnv
eval "$(direnv hook zsh)"
```

When entering a project directory with a `flake.nix`, devshell environment loads automatically.

### Template Details

#### Go Development

Provides complete Go toolchain:
- `go` - Go compiler
- `air` - Live reload tool for Go applications
- `golangci-lint` - Fast Go linters runner
- `go-migrate` - Database migration CLI tool
- `gosec` - Golang security checker
- `sqlc` - Convert SQL to type-safe Go
- `templ` - HTML templating language for Go

#### JavaScript/TypeScript

Provides JS/TS runtime and package manager:
- `bun` - Fast JavaScript runtime, bundler, and package manager
- `pnpm` - Fast, disk space efficient package manager

#### Python Development

Provides Python interpreter:
- `python3` - Python 3 interpreter

Note: Dependency management handled via `uv` (in common packages).

#### Rust Development

Provides Rust tooling complements:
- `rust-analyzer` - LSP server for code completion and diagnostics
- `cargo-watch` - Watch for file changes and compile automatically
- `openssl` - Cryptography library (common dependency)
- `pkg-config` - Build tool for C library dependencies

Note: The Rust toolchain (cargo, rustc, clippy, rustfmt) is managed via `rustup` in common packages.

#### Default Template

Empty template with base structure for custom projects.

## Configuration Details

### Shared Packages

Common tools managed by `nix/common/home-manager.nix`:

**Shell & Terminal:**
- `bat` - Cat clone with syntax highlighting
- `eza` - Modern replacement for ls
- `fd` - Fast find alternative
- `fzf` - Fuzzy finder
- `oh-my-posh` - Cross-platform prompt theme engine
- `ripgrep` - Fast search tool
- `tmux` - Terminal multiplexer
- `tree` - Directory listing
- `zoxide` - Smart cd command

**Editor & Git:**
- `neovim` - Vim-fork text editor
- `lazygit` - Terminal UI for git commands

**Version Managers:**
- `fnm` - Fast Node.js version manager
- `rustup` - Rust toolchain installer
- `uv` - Fast Python package installer

**Utilities:**
- `direnv` - Directory-based environment switcher

### Platform-Specific Packages

**macOS only:**
- `git` - Version control system
- `gnupg` - GNU Privacy Guard
- `go` - Go programming language

**NixOS only:**
- `brightnessctl`, `cliphist`, `fuzzel`, `hypridle`, `hyprlock`, `hyprpaper`, `hyprshot`, `libnotify`, `swaynotificationcenter`, `waybar`, `wl-clipboard`, `wlogout`, `wlsunset` - Wayland/Hyprland tools
- `go` - Go programming language
- `binutils`, `gcc`, `gnumake`, `libffi`, `openssl`, `zlib` - Build tools
- `ollama`, `opencode`, `wget` - Additional utilities
- `brave`, `nerd-fonts.jetbrains-mono`, `alacritty` - Apps and fonts

### Dotfile Symlinks

Home Manager automatically symlinks dotfiles from `~/dotfiles` to your home directory:

| Target | Source |
|--------|--------|
| `~/.config/alacritty` | `~/dotfiles/.config/alacritty` |
| `~/.config/nvim` | `~/dotfiles/.config/nvim` |
| `~/.config/oh-my-posh` | `~/dotfiles/.config/oh-my-posh` |
| `~/.config/tmux` | `~/dotfiles/.config/tmux` |
| `~/.zshrc` | `~/dotfiles/.zshrc` |
| `~/.gitconfig` | `~/dotfiles/.gitconfig` |
| `~/.local/scripts` | `~/dotfiles/.local/scripts` |

Note: The `backupFileExtension = "backup"` setting ensures existing files are backed up before being replaced.
