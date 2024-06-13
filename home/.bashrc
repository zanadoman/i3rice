#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

source /etc/profile.d/debuginfod.sh
export PATH="/home/doman/.path:$PATH"
export EDITOR=nvim
export VISUAL=nvim
alias clear="clear && fastfetch"
alias startx="startx && clear"
clear
eval "$(starship init bash)"
