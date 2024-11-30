[[ $- != *i* ]] && return

export PATH="$HOME/.path:/usr/lib/emscripten:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
export EDITOR=nvim
export VISUAL=nvim
export ANDROID_NDK_ROOT=/opt/android-ndk/
export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
alias clear='clear && fastfetch'
alias startx='startx && clear'
eval "$(zoxide init --cmd cd bash)"
eval "$(starship init bash)"
clear

fd() {
    if [ $# -eq 0 ]; then
        root="$HOME"
    else
        root=$@
    fi
    selected=$(dirname "$(find $root -mindepth 1 | fzf)" 2>/dev/null)
    if [ -n "$selected" ]; then
        cd "$selected"
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
