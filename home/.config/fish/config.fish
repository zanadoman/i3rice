if status is-interactive
    set fish_greeting
    export PATH="/home/doman/.path/:/usr/lib/emscripten/:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
    export EDITOR=nvim
    export VISUAL=nvim
    export ANDROID_NDK_ROOT=/opt/android-ndk/
    export ANDROID_SDK_ROOT=/home/doman/Android/Sdk/
    alias clear="clear && fastfetch"
    alias startx="startx && clear"
    zoxide init --cmd cd fish | source
    starship init fish | source
    bind \cs tmux-sessionizer
    clear
end

function cyclexkbmap
    switch (setxkbmap -query | awk '(NR == 3) {print $2}')
        case hu
            setxkbmap us
        case us
            setxkbmap hu
    end
end

function tmux-sessionizer
    if test (count $argv) -eq 1
        set selected "$argv[1]"
    else
        set selected (find ~/Projects ~/ -mindepth 1 -maxdepth 3 -type d | fzf)
    end

    if test -z "$selected"
        exit 0
    end

    set selected_name (basename "$selected")

    if test -z (pgrep tmux)
        tmux new-session -s "$selected_name" -c "$selected"
        exit 0
    end

    tmux new-session -ds "$selected_name" -c "$selected" 2>/dev/null

    if test -n "$TMUX"
        tmux switch-client -t "$selected_name"
    else
        tmux attach -t "$selected_name"
    end
end
