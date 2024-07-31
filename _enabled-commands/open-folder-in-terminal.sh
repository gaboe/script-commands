#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open root folder in Terminal
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 🚀
# @raycast.argument1 { "type": "text", "placeholder": "folder", "optional": true, "default": "p" }

# Documentation:
# @raycast.description Opens the specified folder (p, pp, pb) in the Terminal.

# Function to open terminal at the specific path
open_terminal() {
  local path="$1"
  if [ -d "$path" ]; then
    osascript <<EOF
      tell application "Terminal"
        do script "cd \"$path\""
        activate
      end tell
EOF
  else
    echo "The path '$path' does not exist."
    exit 1
  fi
}

# Main execution
case "$1" in
  "pp")
    path="$HOME/pp"
    ;;
  "pb")
    path="$HOME/pb"
    ;;
  *)
    path="$HOME/p"
    ;;
esac

open_terminal "$path"