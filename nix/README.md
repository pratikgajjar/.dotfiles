# nix-darwin Configuration

My personal nix-darwin configuration for macOS with automatic system setup, package management, and system defaults.

## Initial Setup

### 1. Install Nix

```sh
sh <(curl -L https://nixos.org/nix/install)
```

### 2. Clone this repository

```sh
git clone <your-repo-url> ~/nix
cd ~/nix
```

### 3. Build and apply the configuration

```sh
# Initial setup with experimental features
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/nix#m3max

# After initial setup, you can use (if darwin-rebuild is in PATH):
darwin-rebuild switch --flake ~/nix#m3max

# Or continue using nix run:
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake ~/nix#m3max
```

## Fixing Nix After macOS Updates

macOS system updates often break the Nix installation by removing or modifying essential components. Here's how to fix it:

### Quick Fix (Try First)

```sh
# 1. Restore the Nix store volume (if it was unmounted)
sudo diskutil list | grep Nix
sudo diskutil mount "Nix Store"

# 2. Re-run the Nix installer to repair the installation
sh <(curl -L https://nixos.org/nix/install) --repair

# 3. Restart your terminal or source your shell profile
source ~/.zshrc

# 4. Rebuild your nix-darwin configuration
cd ~/nix
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#m3max
```

### Complete Recovery (If Quick Fix Fails)

If the quick fix doesn't work, you may need to do a more thorough recovery:

```sh
# 1. Check if /nix exists and is mounted
ls -la /nix
mount | grep nix

# 2. If /nix is missing or not mounted, recreate it
sudo diskutil apfs list
# Look for "Nix Store" volume

# 3. If the Nix Store volume exists but isn't mounted:
sudo diskutil mount "Nix Store"

# 4. If the Nix Store volume is missing, recreate it:
sudo diskutil apfs addVolume disk1 APFS "Nix Store" -mountpoint /nix
sudo diskutil enableOwnership /nix
sudo chown -R $(whoami) /nix

# 5. Reinstall Nix
sh <(curl -L https://nixos.org/nix/install)

# 6. Re-clone and apply your configuration
cd ~/nix
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#m3max
```

### Fix Missing Synthetic.conf

macOS updates sometimes remove the `/etc/synthetic.conf` file which is needed for the `/nix` mount point:

```sh
# Check if synthetic.conf exists and has nix entry
cat /etc/synthetic.conf

# If missing or doesn't contain "nix", add it:
echo "nix" | sudo tee -a /etc/synthetic.conf

# Reboot for synthetic.conf changes to take effect
sudo reboot
```

### Fix Shell Integration

If your shell isn't loading Nix after an update:

```sh
# For zsh (default on macOS)
echo 'if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi' >> ~/.zshrc

# For bash
echo 'if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi' >> ~/.bash_profile

# Reload shell
source ~/.zshrc  # or ~/.bash_profile for bash
```

## Daily Usage

### Update all packages

```sh
# Update flake inputs (nixpkgs, nix-darwin, etc.)
cd ~/nix
nix flake update

# Apply the updated configuration
darwin-rebuild switch --flake ~/nix#m3max
# Or if darwin-rebuild is not in PATH:
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#m3max
```

### Search for packages

```sh
# Search for packages in nixpkgs
nix search nixpkgs <package-name>

# Example:
nix search nixpkgs neovim
```

### Temporary shell with specific packages

```sh
# Enter a shell with specific packages available
nix shell nixpkgs#<package-name>

# Example with multiple packages:
nix shell nixpkgs#nodejs nixpkgs#yarn nixpkgs#git
```

## Configuration Structure

- `flake.nix` - Main configuration file containing:
  - System packages (installed via Nix)
  - Homebrew packages (casks and brews)
  - macOS system defaults
  - Application firewall settings
  - Font configurations

## Troubleshooting

### Permission Errors

If you encounter permission errors:

```sh
# Fix Nix store permissions
sudo chown -R $(whoami) /nix

# Fix Nix daemon
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
```

### Homebrew Integration Issues

If Homebrew packages aren't installing:

```sh
# Ensure Homebrew is installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# For Apple Silicon Macs, ensure both paths are set:
export PATH="/opt/homebrew/bin:$PATH"  # ARM64 Homebrew
export PATH="/usr/local/bin:$PATH"     # x86_64 Homebrew (Rosetta)
```

### Experimental Features Error

If you see errors about experimental features:

```sh
# Add to ~/.config/nix/nix.conf
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Or use the flag with each command:
nix --extra-experimental-features "nix-command flakes" <command>
```

## Adding darwin-rebuild to PATH

To make `darwin-rebuild` permanently available:

```sh
# Add to ~/.zshrc
echo 'export PATH="/run/current-system/sw/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Now you can use darwin-rebuild directly:
darwin-rebuild switch --flake ~/nix#m3max
```

## Backup Before macOS Updates

Before installing major macOS updates, it's recommended to:

1. Note your current Nix version: `nix --version`
2. Backup your configuration: `cp -r ~/nix ~/nix-backup-$(date +%Y%m%d)`
3. Export installed packages list: `nix profile list > ~/nix-packages-$(date +%Y%m%d).txt`

## Resources

- [Nix Darwin Documentation](https://github.com/LnL7/nix-darwin)
- [Nix Package Search](https://search.nixos.org/packages)
- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer) (alternative installer with better macOS support)
