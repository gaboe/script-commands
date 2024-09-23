#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean code from imports
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🧹
# @raycast.packageName Code Utilities

# Documentation:
# @raycast.description Removes import statements from clipboard content
# @raycast.author Gabriel Ecegi

# Read from clipboard
clipboard_content=$(pbpaste)

# Create a temporary file for debug output
debug_file="/tmp/import_remover_debug.log"
echo "Debug log started at $(date)" > "$debug_file"

# Remove import statements
cleaned_content=$(echo "$clipboard_content" | awk -v debug_file="$debug_file" '
    BEGIN { in_multiline = 0; brace_count = 0 }
    {
        print "Processing line: " $0 >> debug_file
        if ($0 ~ /^import /) {
            print "  Found import statement" >> debug_file
            if ($0 ~ /;$/ && in_multiline == 0) {
                print "    Single line import - skipping" >> debug_file
                next  # Single line import
            } else {
                print "    Start of multiline import" >> debug_file
                in_multiline = 1
                brace_count += gsub(/{/, "{")
                brace_count -= gsub(/}/, "}")
                if (brace_count == 0) {
                    in_multiline = 0
                    next
                }
                next
            }
        } else if (in_multiline) {
            brace_count += gsub(/{/, "{")
            brace_count -= gsub(/}/, "}")
            if (brace_count == 0 && $0 ~ /;$/) {
                print "    End of multiline import" >> debug_file
                in_multiline = 0
                next
            }
            print "  In multiline import" >> debug_file
            next
        }
        print "  Not an import - keeping line" >> debug_file
        print $0  # Not an import, print the line
    }
')

# Write back to clipboard
echo "$cleaned_content" | pbcopy

echo "Imports removed successfully!"
echo "Debug log written to $debug_file"