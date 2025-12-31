#!/bin/bash

# Directory containing the CSS files
CSS_DIR="$HOME/.config/hypr/waybar/base16"
FINAL_SCRIPT="$HOME/.config/hypr/scripts/statusbar"

# File to edit
TARGET_FILE="$HOME/.config/hypr/waybar/style.css"

# Use fzf to select a CSS file from the directory
# Use fzf to select a CSS file from the folder
SELECTED_FILE=$(find "$CSS_DIR" -type f -name "*.css" | fzf --prompt="Select a CSS file: ")

# Check if a file was selected
if [[ -n "$SELECTED_FILE" ]]; then
  # Get the relative path of the selected file (e.g., base16/base16-twilight.css)
  RELATIVE_PATH=$(realpath --relative-to="$(dirname "$TARGET_FILE")" "$SELECTED_FILE")

  # Escape slashes in the path for use in sed
  ESCAPED_PATH=$(echo "$RELATIVE_PATH" | sed 's/[\/&]/\\&/g')

  # Update the @import line in the target file
  # This assumes only one @import line in the format "@import './base16/...css';"
  sed -i "s|@import \".*base16/.*\.css\";|@import \"$ESCAPED_PATH\";|" "$TARGET_FILE"

  # Confirm the change
  echo "Updated @import to \"$RELATIVE_PATH\" in $TARGET_FILE"
  if [[ -x "$FINAL_SCRIPT" ]]; then
    "$FINAL_SCRIPT"
    echo "Final script executed successfully."
  else
    echo "Error: Final script is not executable or not found at $FINAL_SCRIPT"
  fi

else
  echo "No file selected."
fi
