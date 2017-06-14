# .zshenv
# This file is always processed when it exists.  Use to initialize some important environment
# variables at the start.

# -------------------------------------
# Startup variables.
# -------------------------------------
export CONFIGDIR="${HOME}/.config"
export ZDOTDIR="${CONFIGDIR}/zsh"
export ZWORKDIR="${ZDOTDIR}/.work"
export HISTFILE="${ZWORKDIR}/zhistory"
export COMPDUMPFILE="${ZWORKDIR}/zcompdump"
export DIRSTACKFILE="${ZWORKDIR}/zdirstack"
export GRML_COMP_CACHE_DIR="${ZWORKDIR}/cache"

# System env
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
export DISPLAY=:0.0

# -------------------------------------
# Paths
# -------------------------------------
PATH="${HOME}/.local/bin:./bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
CDPATH="${HOME}/.config"

export PATH CDPATH

# -------------------------------------
# Default programs
# -------------------------------------

# Pager
export PAGER='less'

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4 --ignore-case --raw-control-chars'
#export GREP_OPTIONS='--color=always'

# Editors
export EDITOR='vim'
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'

# -------------------------------------
# Configure variable, prompt and ls_colors colors.
# -------------------------------------

# The variables are wrapped in \%\{\%\}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval RESET='$reset_color'
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE 
export PR_BOLD_WHITE PR_BOLD_BLACK

# LSCOLORS/LS_COLORS
autoload colors; colors;

LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
LSCOLORS="ExGxFxDxCxDxDxhbhdacEc";

# Do we need Linux or BSD Style?
if ls --color -d . &>/dev/null 2>&1
then
  # Linux Style
  export LS_COLORS=$LS_COLORS
#  alias ls='ls --color=tty'
else
  # BSD Style
  export LSCOLORS=$LSCOLORS
#  alias ls='ls -G'
fi

export LS_COLORS=$LS_COLORS

# Use same colors for autocompletion
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
