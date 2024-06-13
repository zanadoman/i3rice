if status is-interactive
    export PATH="/home/doman/.path:$PATH"
    export EDITOR=nvim
    export VISUAL=nvim
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
