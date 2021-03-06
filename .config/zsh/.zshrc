# Path to your oh-my-zsh installation.
export ZSH="/home/ichirou2910/.oh-my-zsh"

source $HOME/.local/bin/virtualenvwrapper.sh
source $HOME/.local/bin/alacritty.sh

export LIBVIRT_DEFAULT_URI="qemu:///system"

# For Unity-devs' sake
export FrameworkPathOverride=/lib/mono/4.7.2-api
export MSBuildSDKsPath=/opt/dotnet/sdk/$(dotnet --version)/Sdks

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

source /usr/share/z/z.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zaliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zaliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zfuncs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zfuncs"

_comp_options+=(globdots)		# Include hidden files.

#autoload -U promptinit; promptinit
autoload -Uz compinit

for dump in ~/.config/zsh/.zcompdump(N.mh+24); do
    compinit
done

compinit -C
#prompt spaceship
  # char
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_CHAR_SYMBOL_SECONDARY="> "
SPACESHIP_VI_MODE_SHOW=false
  # git prompt
SPACESHIP_GIT_STATUS_DELETED="X"
SPACESHIP_GIT_STATUS_BEHIND=""
SPACESHIP_GIT_STATUS_AHEAD=""
SPACESHIP_GIT_STATUS_DIVERGED=""
  # jobs
SPACESHIP_JOBS_PREFIX=" "
SPACESHIP_JOBS_SUFFIX=" "
SPACESHIP_JOBS_AMOUNT_PREFIX=" "
  # misc
SPACESHIP_EXEC_TIME_COLOR=magenta

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export TERM=xterm-256color

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey "^P" up-line-or-history
bindkey "^[OA" up-line-or-history
bindkey "^[[5~" up-line-or-history
bindkey "^[[A" up-line-or-search
bindkey "^N" down-line-or-history
bindkey "^[OB" down-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[B" down-line-or-search

