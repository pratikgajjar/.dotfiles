# nix-darwin

## Install nix-shell

```sh
sh <(curl -L https://nixos.org/nix/install)
```

## Setup

```sh
nix flake init -t nix-darwin --extra-experimental-features  "nix-command flakes"

nix run nix-darwin --extra-experimental-features  "nix-command flakes" -- switch --flake ~/nix#m3max

darwin-rebuild switch --flake ~/nix#m3max

```
