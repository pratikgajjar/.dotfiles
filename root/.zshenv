# This file is sourced by all instances of Zsh and I want
# this config to be always available

command -v vim >/dev/null 2>&1 && export EDITOR=vim
command -v nvim >/dev/null 2>&1 && export EDITOR=nvim

[ -d $HOME/.local/bin ] && export PATH=$PATH:$HOME/.local/bin
[ -d $HOME/.local/share/nvim/mason/bin ] && export PATH=$PATH:$HOME/.local/share/nvim/mason/bin
[ -f $HOME/.shell/aliases ] && source $HOME/.shell/aliases
[ -f $HOME/.shell/funcs ] && source $HOME/.shell/funcs

# NNN
export NNN_OPTS=aidRU
export NNN_TRASH=1 # trash-cli
export NNN_PLUG='t:autojump;d:diffs;p:preview-tui'
export NNN_FIFO=/tmp/nnn.fifo

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

export LEDGER_DIR=$HOME/data/obsidian/privat/ledger/
export LEDGER_FILE=${LEDGER_DIR}main.ledger

export EXCLUDE_STRING=.git/*,node_modules/*,target/*,.idea/*,.vscode/*,.terraform/*,.gem/*,.cache,**/cache/*,**go/pkg/*,lib/*,bin/*,include/*

# fzf
# WARNING: fd is filtered by ~/.fdignore!
export FZF_COMPLETION_TRIGGER=',,'
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# The first argument to the function ($1) is the base path to start traversal
_fzf_compgen_path() {
  fd --hidden --follow . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow . "$1"
}
# add support for ctrl+o to open selected file
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute:nvim {} > /dev/tty'"
# Preview files
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# Preview directories with tree
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
command -v fd >/dev/null 2>&1 && export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden'
command -v fd >/dev/null 2>&1 && export FZF_ALT_C_COMMAND='fd --type directory --follow --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [[ "$OSTYPE" =~ "darwin" ]]
then
  export LC_CTYPE=UTF-8
  export TERMINAL=xterm
  export TERM=xterm-256color
  export BROWSER="open -a firefox"
fi

export LF_ICONS="\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.vimrc=:\
*.viminfo=:\
*.gitignore=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

. "$HOME/.cargo/env"

