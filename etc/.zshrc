# Set up the prompt 加载 初始化 设置 主题

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
# HISTSIZE=1000
# SAVEHIST=1000
# HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# zsh 默认的补全选择菜单非常难用, 当然一般人都会进行配置. 比较常用的配置是:
# zstyle ':completion:*' menu yes select
# 这样可以使用 Tab 来滚动选择补全. 然而它其实还可以更强:
zstyle ':completion:*' menu yes select search

# zsh 的仿真模式
# 在命令行输入下面的一条命令:
# emulate bash

# 下面两条都可以,有字母"z"的是"zinit"专用的
# autoload -Uz compinit; compinit
zpcompinit; zpcdreplay

zinit light Aloxaf/fzf-tab

# 使用 tmux popup + fzf-tab 实现 zsh 悬浮补全菜单
# 默认使用原版 fzf，需要使用以下命令启用 tmux popup 支持
# 需求 tmux >= 3.2
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


# cd 时在右侧预览目录内容
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

zstyle ':completion:*:descriptions' format '[%d]'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


HISTFILE="$HOME/.zsh_history"

HISTSIZE=10000

SAVEHIST=10000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.

setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.

setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.

setopt SHARE_HISTORY             # Share history between all sessions.

setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.

setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.

setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.

setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.

setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# apt install fzf


# zinit ice depth='1' lucid wait='0'

# zinit light zsh-users/zsh-syntax-highlighting

# zinit ice depth='1'

# zinit light zsh-users/zsh-completions

# zinit ice depth='1'

# zinit light romkatv/powerlevel10k

# zinit ice lucid wait='0'

# zinit snippet OMZ::plugins/jsontools/jsontools.plugin.zsh

# zinit ice lucid wait='0'

# zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh

# zinit ice lucid wait='0'

# zinit snippet OMZ::lib/completion.zsh

# autoload -U compinit && compinit


# zinit ice lucid wait='1'
# zinit light skywind3000/z.lua


# == fzf-tab
zstyle ':fzf-tab:complete:_zlua:*' query-string input
# zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
# zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ':completion:files' sort false

# 一些样板代码（未来可能会改变）
local extract="
# 提取当前选择的内容
in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# 获取当前补全状态的上下文
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
"

zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'

zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap

# kill 结束进程时时提供预览
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'


# 加载插件
zinit ice depth='1' wait
zinit light zsh-users/zsh-completions

zinit ice wait
zinit light zdharma-continuum/history-search-multi-word

zinit ice depth='1' lucid wait='0' atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting
# # zinit light zsh-users/zsh-syntax-highlighting

# 类似 Fish 的 关键词 搜索
zinit light zsh-users/zsh-history-substring-search
# history substring search options:
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down


# the first call of zsh-z is slow in HDD, so call it in advance
zinit ice wait="0" lucid atload="zshz >/dev/null"
zinit light agkozak/zsh-z

# zinit light-mode for \
#     blockf \
#         zsh-users/zsh-completions \
#     as="program" atclone="rm -f ^(rgg|agv)" \
#         lilydjwg/search-and-view \
#     atclone="dircolors -b LS_COLORS > c.zsh" atpull='%atclone' pick='c.zsh' \
#         trapd00r/LS_COLORS \
#     src="etc/git-extras-completion.zsh" \
#         tj/git-extras

# zinit ice wait="1" lucid for \
#     OMZL::clipboard.zsh \
#     OMZL::git.zsh \
#     OMZP::systemd/systemd.plugin.zsh \
#     OMZP::sudo/sudo.plugin.zsh \
#     OMZP::git/git.plugin.zsh

# ice 修饰词
# ice 修饰词作用于下一句 zinit 定义，常用于自定义插件加载方式。
# 比如，对于包含补全文件的插件，需要使用 svn 协议下载整个目录，则应在加载语句前用 ice 声明一下：
# zinit ice svn
# zinit snippet OMZ::plugins/extract
zinit ice lucid wait='0' svn for \
    OMZP::extract \
    OMZP::pip

zinit ice lucid wait='0' as="completion" for \
    OMZP::docker/_docker \
    OMZP::rust/_rust \
    OMZP::fd/_fd

# zinit ice wait="0" lucid
# zinit snippet /usr/share/nvm/init-nvm.sh

# OMZ Library lib 必须有 "*.zsh" 后缀名的文件
# OMZ Plugins
zinit ice wait="1" lucid snippet for \
    OMZL::git.zsh \
    OMZL::clipboard.zsh \
    OMZ::lib/completion.zsh \
    OMZ::lib/history.zsh \
    OMZ::lib/key-bindings.zsh \
    OMZ::lib/theme-and-appearance.zsh \
    OMZ::lib/prompt_info_functions.zsh \
    OMZP::git \
    OMZP::z \
    OMZP::git-prompt \
    OMZP::systemd \
    OMZP::sudo \
    OMZ::plugins/jsontools/jsontools.plugin.zsh


# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# OMZ Themes
# zinit snippet OMZT::jonathan.zsh-theme

# P10k Theme
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"


# source /root/myenv/bin/activate



