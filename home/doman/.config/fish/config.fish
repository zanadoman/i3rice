if status is-interactive
    export PATH="/home/doman/.path:$PATH"
    alias clear="clear && fastfetch"
    alias startx="startx && clear"
    clear
    starship init fish | source
end
