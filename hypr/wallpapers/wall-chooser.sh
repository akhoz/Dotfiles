#!/bin/zsh

SCRIPT_DIR="$(cd -- "$(dirname -- "${(%):-%N}")" && pwd)"

extensions=("jpg" "jpeg" "png" "webp" "bmp" "gif")

images=()
for ext in $extensions; do
    images+=($SCRIPT_DIR/*.$ext(.N))  # .N prevents errors if no matches are found
done

if [[ ${#images[@]} -eq 0 ]]; then
    notify-send "No wallpapers found in $SCRIPT_DIR."
    exit 1
fi

file_names=("${(@f)$(basename -a "${images[@]}")}")

selected_file=$(printf "%s\n" "${file_names[@]}" | rofi -dmenu -p "Choose a wallpaper")

if [[ -z "$selected_file" ]]; then
    exit 0
fi

selected_path="$SCRIPT_DIR/$selected_file"

hyprctl hyprpaper reload ,"$selected_path"
