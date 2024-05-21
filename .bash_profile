# Shell
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Show Git Branch in Shell
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
alias ls='ls -G'
alias ll='ls -hAltG'

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

