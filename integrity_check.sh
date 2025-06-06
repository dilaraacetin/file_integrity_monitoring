#!/bin/bash

SCRIPT_DIR="/opt/scripts"
BASELINE="baseline_hashes.txt"
REPORT="integrity_report.txt"
TEMP_HASHES="current_hashes.txt"

# If baseline doesn't exist, create it
if [ ! -f "$BASELINE" ]; then
    sha256sum "$SCRIPT_DIR"/* > "$BASELINE"
    exit 0
fi

# Create current hash list
sha256sum "$SCRIPT_DIR"/* > "$TEMP_HASHES"

# Clear previous report
> "$REPORT"

# Check for content changes
comm -3 <(sort "$BASELINE") <(sort "$TEMP_HASHES") > "$REPORT"

# Check for added or deleted files
baseline_files=$(cut -d ' ' -f3- "$BASELINE" | sort)
current_files=$(cut -d ' ' -f3- "$TEMP_HASHES" | sort)
added_files=$(comm -13 <(echo "$baseline_files") <(echo "$current_files"))
deleted_files=$(comm -23 <(echo "$baseline_files") <(echo "$current_files"))

{
    echo "----- Newly Added Files -----"
    echo "$added_files"
    echo ""
    echo "----- Deleted Files -----"
    echo "$deleted_files"
    echo ""
    echo "----- Modified Files -----"
    grep -vFxf "$BASELINE" "$TEMP_HASHES"
} >> "$REPORT"

rm "$TEMP_HASHES"
