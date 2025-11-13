#!/bin/sh

# Script to replace "Guitar Rig 4" with "Guitar Rig 6" in .ngrr files
# Usage: ./fix-guitar-rig.sh [directory]
# If no directory is provided, uses current directory

# Set target directory (default to current directory if not provided)
TARGET_DIR="${1:-.}"

# Check if directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

# Counter for modified files
count=0

echo "Searching for .ngrr files in: $TARGET_DIR"
echo "----------------------------------------"

# Find all .ngrr files in the target directory and subdirectories
find "$TARGET_DIR" -type f -name "*.ngrr" | while read -r file; do
    # Check if file contains "Guitar Rig 4"
    if LC_ALL=C grep -q "Guitar Rig 4" "$file"; then
        echo "Processing: $file"

        # Create a backup file
        cp "$file" "${file}.backup"

        # Replace "Guitar Rig 4" with "Guitar Rig 6"
        # Using LC_ALL=C to handle binary files properly
        # Using perl for better binary file handling
        if command -v perl >/dev/null 2>&1; then
            # Use perl if available (best for binary files)
            LC_ALL=C perl -pi -e 's/Guitar Rig 4/Guitar Rig 6/g' "$file"
        else
            # Fallback to sed with LC_ALL=C
            if sed --version 2>/dev/null | grep -q GNU; then
                # GNU sed (Linux)
                LC_ALL=C sed -i 's/Guitar Rig 4/Guitar Rig 6/g' "$file"
            else
                # BSD sed (macOS)
                LC_ALL=C sed -i '' 's/Guitar Rig 4/Guitar Rig 6/g' "$file"
            fi
        fi

        echo "  ✓ Replaced 'Guitar Rig 4' with 'Guitar Rig 6'"
        echo "  ✓ Backup saved as: ${file}.backup"

        count=$((count + 1))
    fi
done

echo "----------------------------------------"
echo "Processing complete!"
echo "Modified $count file(s)"
echo ""
echo "Note: Backup files were created with .backup extension"
echo "If everything looks good, you can remove them with:"
echo "  find \"$TARGET_DIR\" -name \"*.ngrr.backup\" -exec rm {} \\;"
