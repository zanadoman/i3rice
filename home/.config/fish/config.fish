if status is-interactive
    set fish_greeting
    export PATH="$HOME/.path/:/usr/lib/emscripten/:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
    export EDITOR=nvim
    export VISUAL=nvim
    export ANDROID_NDK_ROOT=/opt/android-ndk/
    export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
    alias clear='clear && fastfetch'
    alias startx='startx && clear'
    zoxide init --cmd cd fish | source
    starship init fish | source
    clear
end

function fd
    if test (count $argv) -eq 0
        set root "$HOME"
    else
        set root $argv
    end
    set selected (dirname "$(find $root -mindepth 1 | fzf)" 2>/dev/null)
    if test -n "$selected"
        cd "$selected"
    end
end

function cyclexkbmap
    switch (setxkbmap -query | awk '(NR == 3) {print $2}')
        case hu
            setxkbmap us
        case us
            setxkbmap hu
        case '*'
            setxkbmap hu
    end
end
