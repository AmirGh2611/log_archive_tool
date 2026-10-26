#!/bin/bash

# ==============================================================================
# Tool Name: log-archive
# Description: Compresses and archives a target log directory into a tar.gz file 
#              with a timestamp and logs the action history.
# Usage: log-archive <log-directory>
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Validate arguments
if [ $# -eq 0 ]; then
    echo "Error: No log directory provided."
    echo "Usage: log-archive <log-directory>"
    exit 1
fi

LOG_DIR="$1"

# 2. Check if the provided directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# 3. Define and create archive destination directory
ARCHIVE_DIR="/var/log/archived_logs"
sudo mkdir -p "$ARCHIVE_DIR"

# 4. Generate timestamp and archive filename (e.g., logs_archive_20260330_143000.tar.gz)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"

echo "--------------------------------------------------------"
echo "Starting log archival for: $LOG_DIR"
echo "Destination: $ARCHIVE_PATH"
echo "--------------------------------------------------------"

# 5. Compress the log directory into a tar.gz file
PARENT_DIR=$(dirname "$LOG_DIR")
DIR_NAME=$(basename "$LOG_DIR")

sudo tar -czf "$ARCHIVE_PATH" -C "$PARENT_DIR" "$DIR_NAME"

# 6. Log the archive date, time, and file details to a history log
HISTORY_FILE="$ARCHIVE_DIR/archive_history.log"
LOG_ENTRY="[$(date '+%Y-%m-%d %H:%M:%S')] Successfully archived '$LOG_DIR' -> '$ARCHIVE_PATH'"
echo "$LOG_ENTRY" | sudo tee -a "$HISTORY_FILE" > /dev/null

echo "--------------------------------------------------------"
echo "Archival complete! Stored at: $ARCHIVE_PATH"
echo "History logged to: $HISTORY_FILE"
echo "--------------------------------------------------------"
