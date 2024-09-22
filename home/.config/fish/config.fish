if status is-interactive
    set fish_greeting
    export PATH="/home/doman/.path:/usr/lib/emscripten:$PATH:/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/"
    export EDITOR=nvim
    export VISUAL=nvim
    export ANDROID_NDK_ROOT=/opt/android-ndk/
    export ANDROID_SDK_ROOT=/home/doman/Android/Sdk/
    alias clear="clear && fastfetch"
    alias startx="startx && clear"
    zoxide init --cmd cd fish | source
    starship init fish | source
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

function mkvtomp4
    ffmpeg -i $argv[1].mkv -codec copy $argv[1].mp4
end
