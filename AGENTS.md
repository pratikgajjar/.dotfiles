# AGENTS.md — dotfiles

Scope: these rules apply only when you change files tracked by the dotfiles
repo (`dot ls-files`). For any other work under `$HOME`, ignore this file.

## This repo is PUBLIC

`github.com/pratikgajjar/.dotfiles` is public. Anyone can read every commit.

- Never commit secrets: API keys, tokens, passwords, private keys, cookies.
- Never commit private info: employer, client, or company names; work account,
  AWS profile, SSO, cluster, host, or bucket names; internal URLs; IP addresses;
  personal email addresses.
- Put these values in `~/shell/private` (untracked, mode 0600). `.zshrc`
  sources it if it exists.
- Installers often append `export FOO=...` to `.zshrc`. Move those lines to
  `~/shell/private` before you commit.
- Before every commit, read the full staged diff (`dot diff --cached`) and
  search it for keys and names. If you are not sure, stop and ask.

## Bare repo

- `dot` = `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME`. The alias exists
  only in interactive zsh; in bash, define it as a function.
- The work tree is the whole home directory. Stage explicit paths only.
  Never run `dot add -A`, `dot add .`, or `dot commit -a`.
- `main` is the only branch and is protected. Do not force-push.
- Untracked by design: `~/.gitconfig`, `~/shell/private`, SSH/GPG keys,
  `.pi/` (except `.pi/agent/keybindings.json`).

## Works on macOS and Linux

The same files run on a macOS laptop and on an Ubuntu server.

- Guard OS-specific code: `[[ $OSTYPE == darwin* ]]`, `[[ $OSTYPE == linux* ]]`.
- Guard optional tools and paths: `command -v foo >/dev/null && ...`,
  `[ -f file ] && ...`. A missing tool must not print an error.
- Keep machine-specific setup out of the repo. Load it only if the file
  exists (example: `~/.config/pi-agents-env.sh` on the server).
- `.zshenv` runs for every zsh, including `ssh host cmd`, scp, and rsync.
  Keep it fast and silent.

## Check before you commit

- Syntax: `zsh -n <file>` for zsh files, `bash -n <script>` for scripts.
- A clean interactive login shell prints no errors:
  `env -i HOME=$HOME TERM=xterm-256color PATH=/usr/bin:/bin zsh -lic exit`
- Startup stays fast (about 100 ms): `time zsh -lic exit`.
