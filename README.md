# dotfiles

My personal dotfiles for macOS (and Linux), managed as a **bare git repo** checked out directly into `$HOME` — no symlinks, no install scripts.

```sh
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot status
dot add .zshrc && dot commit -m "..."
```

## Setup on a new machine

```sh
git clone --bare git@github.com:pratikgajjar/.dotfiles.git $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout
dot config status.showUntrackedFiles no

# NeoVim config is a separate repo (see config/nvim.md)
git clone git@github.com:pratikgajjar/nvim.git $HOME/config/nvim

# XDG symlinks (configs live under ~/config, apps read ~/.config)
ln -sfn $HOME/config/ghostty $HOME/.config/ghostty   # without this, Cmd->tmux keybinds don't load
ln -sfn $HOME/config/nvim    $HOME/.config/nvim

# tmux plugin manager (then press prefix + I inside tmux)
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# nix-darwin system
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake $HOME/nix#m3max
```

Not in the repo, set up by hand: `~/.gitconfig`, SSH/GPG keys, `~/shell/private` (work-specific aliases), `atuin login`.

## What's inside

| Area | Config |
|------|--------|
| Shell | Zsh + Oh-My-Zsh, [starship](https://starship.rs) prompt, [atuin](https://atuin.sh) history, direnv + nix-direnv — split into `shell/{aliases,funcs,options,plugins,tools}` |
| Terminal | [Ghostty](https://ghostty.org) (`config/ghostty`), Wezterm as backup |
| Multiplexer | tmux (`.config/tmux`) — Catppuccin theme, extended-keys (csi-u), resurrect + continuum session restore |
| Editor | NeoVim — separate repo, cloned not vendored → [pratikgajjar/nvim](https://github.com/pratikgajjar/nvim) (`config/nvim.md`) |
| System | nix-darwin flake (`nix/`) — declarative macOS packages, homebrew casks, firewall settings |
| Git | gitui + tig configs, global gitignore |
| Scripts | `local/bin/` — tmux-sessionizer, fuzzy-sys, clipboard helpers, misc utilities |

## Conventions

- Modern CLI replacements aliased when installed: `eza`, `fd`, `rg`, `delta`, `dust`, `btop`, `procs`, etc. (see `shell/aliases`). Bypass any alias with a backslash: `\grep`.
- Nothing machine- or work-specific lives in the repo. Secrets, work aliases, and account names go in `~/shell/private` (gitignored), sourced by `.zshrc` if present. Helpers like `ec2-ssm` discover AWS profiles dynamically via `aws configure list-profiles` instead of hardcoding them.
- Configs follow XDG paths where the tool supports it (`$XDG_CONFIG_HOME=~/.config`).

## Note

These are tuned for my workflow — clone for inspiration, copy snippets, don't expect it to work as-is.
