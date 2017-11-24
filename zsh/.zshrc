# export PATH="/usr/bin:/bin:/usr/local/bin"
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"

source ~/init.zsh

# (1) プラグインを定義する
zplug "yous/vanilli.sh"
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "themes/blinks", from:oh-my-zsh, as:theme

# (2) インストールする
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

alias ssh="ssh -A"
alias mv="mv -i"
alias rm="rm -i"
alias la="ls -la"
alias vi="vim"

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
