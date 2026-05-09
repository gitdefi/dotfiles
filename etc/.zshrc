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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:eza' sort false
zstyle ':completion:files' sort false

# 一些样板代码（未来可能会改变）
local extract="
# 提取当前选择的内容
in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# 获取当前补全状态的上下文
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
"

zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'eza -1 --color=always ${~ctxt[hpre]}$in'

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


# 注意：
# 本补丁依赖较新的 sindresorhus/pure。
# 要求 Pure 的 PROMPT 中保留 ${prompt_newline} 作为第一行/第二行分隔点。
#
# 如果时间不显示，不要改 zsh 版本，优先更新 Pure：
#   zinit update sindresorhus/pure
#
# 不建议使用兼容旧 Pure 的 fallback install 逻辑；
# 实测增强版 _pure_right_time_install() 在新旧 Pure 上都可能导致时间不显示。
# chore(zsh): 放弃兼容旧版 Pure 的时间注入逻辑
# >
# Pure prompt
# Fixed version: v1.27.1 / dbefd0d
# Reason: older Pure versions may not expose the ${prompt_newline} structure needed by the adaptive clock patch.
# # > zinit update sindresorhus/pure

# # > Load pure theme
# zinit ice pick"async.zsh" src"pure.zsh"
# >zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zstyle :prompt:pure:git:stash show yes

# zinit ice ver"v1.27.1" compile'(pure|async).zsh' pick"async.zsh" src"pure.zsh"
zinit ice ver"dbefd0d" compile'(pure|async).zsh' pick"async.zsh" src"pure.zsh"
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


# GOROOT=/usr/local/go
# GOPATH=$HOME/go
# PATH=$GOPATH/bin:$GOROOT/bin:$PATH


# # > zsh command-not-found
[ -r /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found


# > 半自动小函数：输入命令名，它帮你查包、显示简介，但不自动安装。

# Debian / Ubuntu command-not-found support
[ -r /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found

# 保存系统原始 command_not_found_handler
if (( $+functions[command_not_found_handler] )); then
  functions[_debian_command_not_found_handler]=$functions[command_not_found_handler]
fi

# 用 apt-file 查找命令所属软件包
_cmd_apt_file_lookup() {
  local cmd="$1"

  if ! command -v apt-file >/dev/null 2>&1; then
    echo
    echo "apt-file 未安装，无法进一步搜索。"
    echo "安装命令:"
    echo "  apt install -y apt-file"
    echo "  apt-file update"
    return 127
  fi

  local results
  results="$(
    apt-file search "/$cmd" 2>/dev/null \
      | awk -F': ' -v c="/$cmd" '
          $2 ~ c "$" {
            print
          }
        ' \
      | sort -u \
      | head -50
  )"

  if [ -z "$results" ]; then
    echo
    echo "command-not-found 和 apt-file 都没有找到命令：$cmd"
    echo
    echo "可以尝试更新 apt-file 数据库："
    echo "  apt-file update"
    return 127
  fi

  echo
  echo "下面是 apt-file 搜索结果："
  echo

  local pkgs
  pkgs="$(echo "$results" | cut -d: -f1 | sort -u | head -10)"

  local pkg desc paths

  echo "$pkgs" | while read -r pkg; do
    [ -z "$pkg" ] && continue

    desc="$(
      apt-cache show "$pkg" 2>/dev/null \
        | awk -F': ' '
            /^Description-en: / { print $2; exit }
            /^Description: / { print $2; exit }
          '
    )"

    [ -z "$desc" ] && desc="暂无简介，可用 apt show $pkg 查看。"

    echo "软件包: $pkg"
    echo "用途: $desc"
    echo "包含路径:"

    echo "$results" \
      | awk -F': ' -v p="$pkg" '$1 == p { print "  " $2 }' \
      | head -8

    echo "安装命令:"
    echo "  apt install -y $pkg"
    echo
  done

  return 127
}

# 自动增强版 command-not-found
command_not_found_handler() {
  local cmd="$1"
  local output=""

  if (( $+functions[_debian_command_not_found_handler] )); then
    output="$(_debian_command_not_found_handler "$@" 2>&1)"
    [ -n "$output" ] && echo "$output"

    # 如果系统 command-not-found 已经给出安装建议，就不再 apt-file 搜索
    if echo "$output" | grep -Eq "can be installed with:|^apt install |^apt-get install "; then
      return 127
    fi
  fi

  _cmd_apt_file_lookup "$cmd"
  return 127
}

# 手动查询命令：findcmd rustc
findcmd() {
  if [ -z "$1" ]; then
    echo "用法: findcmd 命令名"
    return 1
  fi

  _cmd_apt_file_lookup "$1"
}



# 右侧显示本机时间和日期：19:16:18 2026-05-09
# 右侧显示本机时间和日期，橙色


# ------------------------------------------------------------
# Pure right time patch
#
# 功能：
# - 保留 Pure 原有全部功能：
#   Git 分支 / dirty 状态 / 执行耗时 / virtualenv / ❯ 成功失败颜色等
# - 第一行够宽：时间显示在第一行右侧
# - 第一行不够宽：时间自动显示到 ❯ 所在行右侧，也就是 RPROMPT
# - 第一行重新够宽：时间自动回到第一行右侧
# - 两行都不够宽：隐藏时间，避免覆盖 Pure 原有信息
# - 每次新 prompt 随机换色，并避免连续两次同色
# ------------------------------------------------------------

autoload -Uz add-zsh-hook
setopt prompt_subst

# 清理旧版尝试的 hook
add-zsh-hook -d precmd _set_random_time_rprompt 2>/dev/null
add-zsh-hook -d precmd _set_multiline_prompt_with_time 2>/dev/null
add-zsh-hook -d precmd _pure_right_time_update 2>/dev/null
add-zsh-hook -d precmd _pure_right_time_inject_once 2>/dev/null
add-zsh-hook -d precmd _pure_right_time_install 2>/dev/null

# 清理旧版函数
unset -f _set_random_time_rprompt _set_multiline_prompt_with_time 2>/dev/null
unset -f _pure_right_time_segment _pure_right_time_inject_once _pure_right_time_install 2>/dev/null
unset -f _pure_right_time_update _pure_right_time_pick_color 2>/dev/null

# 初始清空右提示符；后面只在第一行放不下时动态启用 RPROMPT
RPROMPT=''
RPS1=''

# 柔和 256 色，避开黑、白、灰
typeset -ga _pure_time_colors
_pure_time_colors=(
  39 45 51 75 81 87
  111 117 123 147 153 159
  114 120 121 150 156 157
  141 177 183 189 213
  168 169 204 205 210 211
  208 209 214 215 220 222
)

typeset -g prompt_pure_right_time_first=''
typeset -g prompt_pure_right_time_color=''
typeset -g _pure_time_last_color=''

_pure_right_time_pick_color() {
  emulate -L zsh

  local n=${#_pure_time_colors[@]}
  (( n == 0 )) && return 1

  local color=''
  local tries=0

  while (( tries < 16 )); do
    color=${_pure_time_colors[$(( RANDOM % n + 1 ))]}
    [[ "$color" != "$_pure_time_last_color" ]] && break
    (( tries++ ))
  done

  _pure_time_last_color="$color"
  prompt_pure_right_time_color="$color"
}

_pure_right_time_update() {
  emulate -L zsh

  prompt_pure_right_time_first=''
  RPROMPT=''
  RPS1=''

  local width=${COLUMNS:-80}
  (( width < 30 )) && return

  local time_text=''

  if zmodload zsh/datetime 2>/dev/null && (( $+EPOCHSECONDS )); then
    strftime -s time_text '%H:%M:%S %Y-%m-%d' "$EPOCHSECONDS"
  else
    time_text="$(date '+%H:%M:%S %Y-%m-%d')"
  fi

  local time_len=${#time_text}
  local gap=2

  # 估算 Pure 第一行已有可见长度：
  # jobs / user@host / path / git branch / dirty / action / arrows / stash / exec time
  local line1_text=''

  [[ -n ${psvar[12]} ]] && line1_text+="${psvar[12]} "
  [[ -n ${psvar[13]} ]] && line1_text+="${(%):-%n@%m} "

  line1_text+="${(%):-%~}"

  [[ -n ${psvar[14]} ]] && line1_text+=" ${psvar[14]}${psvar[15]}"
  [[ -n ${psvar[16]} ]] && line1_text+=" ${psvar[16]}"
  [[ -n ${psvar[17]} ]] && line1_text+=" ${psvar[17]}"
  [[ -n ${psvar[18]} ]] && line1_text+=" ${PURE_GIT_STASH_SYMBOL:-≡}"
  [[ -n ${psvar[19]} ]] && line1_text+=" ${psvar[19]}"

  local line1_len=${#line1_text}

  # 估算 Pure 第二行已有可见长度：
  # virtualenv / conda / nix-shell + prompt symbol
  local prompt_symbol="${prompt_pure_state[prompt]:-${PURE_PROMPT_SYMBOL:-❯}}"
  local line2_text=''

  [[ -n ${psvar[20]} ]] && line2_text+="${psvar[20]} "
  line2_text+="${prompt_symbol} "

  local line2_len=${#line2_text}

  _pure_right_time_pick_color

  local color="$prompt_pure_right_time_color"
  [[ -z "$color" ]] && return

  local esc=$'\e'

  # 第一行够宽：把时间画到第一行右侧
  if (( line1_len + gap + time_len <= width )); then
    local col=$(( width - time_len + 1 ))
    (( col < 1 )) && return

    prompt_pure_right_time_first="%{${esc}7${esc}[${col}G${esc}[38;5;${color}m${time_text}${esc}[0m${esc}8%}"
    RPROMPT=''
    RPS1=''
    return
  fi

  # 第一行不够宽，但第二行够宽：
  # 使用 RPROMPT，让 zsh 自己把时间放到 ❯ 所在行右侧
  if (( line2_len + gap + time_len <= width )); then
    prompt_pure_right_time_first=''
    RPROMPT="%{${esc}[38;5;${color}m%}${time_text}%{${esc}[0m%}"
    RPS1="$RPROMPT"
    return
  fi

  # 两行都不够宽：隐藏时间，避免覆盖 Pure 原有信息
  prompt_pure_right_time_first=''
  RPROMPT=''
  RPS1=''
}

_pure_right_time_install() {
  emulate -L zsh
  setopt prompt_subst

  # 清理旧版变量注入残留
  PROMPT=${PROMPT//\$\{prompt_pure_right_time_segment\}/}
  PROMPT=${PROMPT//\$\{prompt_pure_right_time_first\}/}
  PROMPT=${PROMPT//\$\{prompt_pure_right_time_second\}/}

  # 清理旧版命令替换注入残留
  PROMPT=${PROMPT//\$(_pure_right_time_segment first)/}
  PROMPT=${PROMPT//\$(_pure_right_time_segment second)/}

  local marker='${prompt_pure_right_time_first}${prompt_newline}'

  [[ "$PROMPT" == *"$marker"* ]] && return

  local needle='${prompt_newline}'
  local replacement='${prompt_pure_right_time_first}${prompt_newline}'

  if [[ "$PROMPT" == *"$needle"* ]]; then
    PROMPT=${PROMPT/$needle/$replacement}
  fi
}

_pure_right_time_update
_pure_right_time_install

add-zsh-hook precmd _pure_right_time_update


# ------------------------------------------------------------
# Optional hardening:
# Pure async Git redraw 时，也重新计算时间位置。
# 作用：
# - Git dirty / arrows / stash 异步刷新后，时间位置也跟着重算
# - 避免异步刷新导致第一行长度变化后，时间位置仍按旧长度判断
# ------------------------------------------------------------

if (( $+functions[prompt_pure_reset_prompt] )) && (( ! $+functions[_pure_right_time_original_reset_prompt] )); then
  functions[_pure_right_time_original_reset_prompt]=$functions[prompt_pure_reset_prompt]

  prompt_pure_reset_prompt() {
    _pure_right_time_update 2>/dev/null
    _pure_right_time_original_reset_prompt "$@"
  }
fi





