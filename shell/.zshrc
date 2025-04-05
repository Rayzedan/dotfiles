# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/.local/go/bin/"
export GOBIN="$HOME/.local/go/bin/bin/"
export PATH="${PATH}:${GOBIN}"
export DOOM_PATH="/home/daniil/.config/emacs/bin/"
export PATH="${PATH}:${DOOM_PATH}"
export PATH="${PATH}:${GOPATH}"
export PATH="${PATH}:${HOME}/.local/bin/"
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export VCPKG_ROOT="$HOME/.local/share/vcpkg/"
export CLASSPATH=".:/usr/local/lib/antlr-4.13.2-complete.jar:$CLASSPATH"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
HIST_STAMPS="yyyy-mm-dd"
setopt EXTENDED_HISTORY      # Делать записи в файле истории в формате ':start:elapsed;command'.
setopt INC_APPEND_HISTORY    # Писать данные в файл истории немедленно, а не тогда, когда осуществляется выход из оболочки.
setopt SHARE_HISTORY         # Использовать во всех сессиях общее хранилище истории.
setopt HIST_IGNORE_DUPS      # Не делать повторную запись о только что записанном событии.
setopt HIST_IGNORE_ALL_DUPS  # Удалять старую запись о событии в том случае, если новое событие является дубликатом старого.
setopt HIST_IGNORE_SPACE     # Не делать записи о командах, начинающихся с пробела.
setopt HIST_SAVE_NO_DUPS     # Не записывать дубликаты событий в файл истории.
setopt HIST_VERIFY           # Перед выполнением команд показывать записи о них из истории команд.
setopt APPEND_HISTORY        # Добавлять записи к файлу истории (по умолчанию).
setopt HIST_NO_STORE         # Не хранить записи о командах history.
setopt HIST_REDUCE_BLANKS    # Убирать лишние пробелы из командных строк, добавляемых в историю.

plugins=(
    git
    archlinux
    tmux
    history
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
)

# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
#  --color=fg:#bbbac1,bg:#171719,hl:#559ba3,gutter:#171719
#  --color=fg+:#bbbac1,bg+:#1d1d22,hl+:#e3a462
#  --color=info:#555568,prompt:#559ba3,pointer:#559ba3
#  --color=marker:#8a88db,spinner:#8a88db,header:#8a88db"
source $ZSH/oh-my-zsh.sh

alias -g kr='docker run --rm -it -v $(pwd):/keeper -w /keeper --user $(id -u):$(id -g) --name $(date +%Y-%m-%d-%H-%M)-release keeper:release /bin/bash'
alias -g kt='docker run --rm -it -v $(pwd):/keeper -w /keeper --user $(id -u):$(id -g) --name $(date +%Y-%m-%d-%H-%M)-test docker.prosyst.ru/keeper/test:0.19 /bin/bash'
alias -g k='cd ~/work/keeper/ && nvim ~/work/keeper/'
alias -g ssh='TERM=screen-256color ssh'

# Set-up icons for files/folders in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.13.2-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
