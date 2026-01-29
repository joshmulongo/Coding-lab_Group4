#!/bin/bash

# -------------------------------
# Simple Log Archiver Script
# -------------------------------
# Features:
# 1. Archives ONLY the selected log file.
# 2. Moves it to its archive folder.
# 3. Renames it with a timestamp (YYYY-MM-DD_HH:MM:SS).
# 4. Creates a new empty log for continued monitoring.
# 5. Handles invalid input, missing logs, and archive directory issues.
# -------------------------------

# Display menu
echo "Select a log file to archive:"
echo "1) heart_rate_log.log"
echo "2) temperature_log.log"
echo "3) water_usage_log.log"

read -p "Enter your choice [1-3]: " choice

# Determine log file and archive directory based on user input
if [ "$choice" == "1" ]; then
    log_file="heart_rate_log.log"
    archive_dir="archived_logs/heart_data_archive"
elif [ "$choice" == "2" ]; then
    log_file="temperature_log.log"
    archive_dir="archived_logs/temperature_data_archive"
elif [ "$choice" == "3" ]; then
    log_file="water_usage_log.log"
    archive_dir="archived_logs/water_data_archive"
else
    echo "Invalid choice. Please run the script again and choose 1, 2, or 3."
    exit 1
fi

# Check if the log file exists
if [ ! -f "active_logs/$log_file" ]; then
    echo "Error: Log file '$log_file' not found."
    exit 1
fi

# Ensure the archive directory exists
if [ ! -d "$archive_dir" ]; then
    mkdir -p "$archive_dir" || { echo "Error: Could not create archive directory '$archive_dir'."; exit 1; }
fi

# Generate timestamp for renaming
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

# Create archived file name
archived_file="$archive_dir/${log_file%.*}_$timestamp.log"

# Move the active log to archive folder
mv "active_logs/$log_file" "$archived_file" || { echo "Error: Could not move log file to archive."; exit 1; }

# Create a new empty log file
touch "active_logs/$log_file" || { echo "Error: Could not create new log file."; exit 1; }

echo "Success! '$log_file' archived as '$archived_file'. New empty log created."

