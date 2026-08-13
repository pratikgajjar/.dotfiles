# NeoVim

My NeoVim config lives in its own repo: **[pratikgajjar/nvim](https://github.com/pratikgajjar/nvim)**

It used to be a git submodule here, but that meant bumping the pin on every nvim tweak. It is now cloned independently — this repo just points at it.

## Setup

```sh
git clone git@github.com:pratikgajjar/nvim.git $HOME/config/nvim
ln -sfn $HOME/config/nvim $HOME/.config/nvim
```

Update it like any other repo:

```sh
git -C $HOME/config/nvim pull
```
