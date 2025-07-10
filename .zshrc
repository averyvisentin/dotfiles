#            _              
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|
#                           

# You can define your custom configuration by adding
# files in ~/.config/zshrc 
# or by creating a folder ~/.config/zshrc/custom
# with copies of files from ~/.config/zshrc 
# -----------------------------------------------------

# -----------------------------------------------------
# Load modular configarion
# -----------------------------------------------------

#for f in ~/.config/zshrc/*; do
#    if [ ! -d $f ] ;then
#        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
#        [[ -f $c ]] && source $c || source $f
#    fi
#done

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

#if [ -f ~/.zshrc_custom ] ;then
#    source ~/.zshrc_custom
#fi
#
#

#---------------------------------PROMPT------------------------------------------------#
fastfetch
# To customize prompt, https://ohmyposh.dev/docs/themes
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/tokyo3.json)"
#---------------------------------PROMPT------------------------------------------------#

# -----------------------------------------------------
# Pywal
# -----------------------------------------------------
#cat ~/.cache/wal/sequences

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found


# Load completions
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit

zinit cdreplay -q


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


###
###
###EXPORTS
###
###
#they are in .config/uwsm/env-hyprland now
# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='~/.config/ml4w/scripts/snapshot.sh'



#
#OLLAMA
#
alias ollama-restart="systemctl --user restart ollama.service"
alias ollama-start="systemctl --user start ollama.service"
alias ollama-stop="systemctl --user stop ollama.service"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



