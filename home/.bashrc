#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

source /etc/profile.d/debuginfod.sh
export PATH="/home/doman/.path:/usr/lib/emscripten:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
export EDITOR=nvim
export VISUAL=nvim
export ANDROID_NDK_ROOT=/opt/android-ndk/
alias clear="clear && fastfetch"
alias startx="startx && clear"
clear
eval "$(starship init bash)"
