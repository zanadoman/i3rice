if status is-interactive
    set fish_greeting
    export PATH="$HOME/.local/bin/:/usr/lib/emscripten/:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
    export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
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

function ff
    if test (count $argv) -eq 0
        set root ./
    else
        set root $argv
    end
    find $root -mindepth 1 -type f | fzf
end

function fd
    if test (count $argv) -eq 0
        set root ./
    else
        set root $argv
    end
    find $root -mindepth 1 -type d | fzf
end

function fcd
    if test (count $argv) -eq 0
        set root ./
    else
        set root $argv
    end
    set selected (find $root -mindepth 1 | fzf)
    if test -n "$selected"
        if test -d $selected
            cd $selected
        else
            cd (dirname $selected)
        end
    end
end

function frg
    if test (count $argv) -eq 0
        set root ./
    else
        set root $argv
    end
    set selected (cat (find $root -mindepth 1 -type f) | fzf)
    if test -n "$selected"
        rg -.lF $selected
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
