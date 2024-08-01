if status is-interactive
    set fish_greeting
    export PATH="/home/doman/.path:$PATH"
    export EDITOR=nvim
    export VISUAL=nvim
    export ANDROID_NDK_HOME=/opt/android-ndk/
    alias clear="clear && fastfetch"
    alias startx="startx && clear"
    clear
    starship init fish | source
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
