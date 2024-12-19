[[ $- != *i* ]] && return
export PATH="$HOME/.local/bin/:/usr/lib/emscripten/:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export EDITOR=nvim
export VISUAL=nvim
export ANDROID_NDK_ROOT=/opt/android-ndk/
export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
alias clear='clear && fastfetch'
alias startx='startx && clear'
eval "$(zoxide init --cmd cd bash)"
eval "$(starship init bash)"
clear

ff() {
    if [ $# -eq 0 ]; then
        root=./
    else
        root=$@
    fi
    find $root -mindepth 1 -type f | fzf
}

fd() {
    if [ $# -eq 0 ]; then
        root=./
    else
        root=$@
    fi
    find $root -mindepth 1 -type d | fzf
}

fcd() {
    if [ $# -eq 0 ]; then
        root=./
    else
        root=$@
    fi
    selected=$(find $root -mindepth 1 | fzf)
    if [ -n "$selected" ]; then
        if [ -d "$selected" ]; then
            cd "$selected"
        else
            cd "$(dirname "$selected")"
        fi
    fi
}

frg() {
    if [ $# -eq 0 ]; then
        root=./
    else
        root=$@
    fi
    selected=$(cat $(find $root -mindepth 1 -type f) | fzf)
    if [ -n "$selected" ]; then
        rg -.lF "$selected"
    fi
}

cyclexkbmap() {
    case $(setxkbmap -query | awk '(NR == 3) {print $2}') in
        hu)
            setxkbmap us
            ;;
        us)
            setxkbmap hu
            ;;
        *)
            setxkbmap hu
            ;;
    esac
}
