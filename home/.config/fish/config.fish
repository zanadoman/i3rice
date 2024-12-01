if status is-interactive
    set fish_greeting
    export PATH="$HOME/.local/bin/:/usr/lib/emscripten/:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
    export EDITOR=nvim
    export VISUAL=nvim
    export ANDROID_NDK_ROOT=/opt/android-ndk/
    export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
    alias clear='clear && fastfetch'
    alias startx='startx && clear'
    zoxide init --cmd cd fish | source
    fzf --fish | source
    starship init fish | source
    clear
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
