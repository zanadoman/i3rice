[[ $- != *i* ]] && return
export PATH="$HOME/.path/:/usr/lib/emscripten/:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
export EDITOR=nvim
export VISUAL=nvim
export ANDROID_NDK_ROOT=/opt/android-ndk/
export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
alias clear='clear && fastfetch'
alias startx='startx && clear'
eval "$(zoxide init --cmd cd bash)"
eval "$(fzf --bash)"
eval "$(starship init bash)"
clear

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
