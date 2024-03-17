if status is-interactive
    export PATH="/home/doman/.path:$PATH"
    alias clear="clear && fastfetch"
    alias startx="startx && clear"
    alias xampp="sudo /opt/lampp/lampp start"
    clear
    starship init fish | source
end
