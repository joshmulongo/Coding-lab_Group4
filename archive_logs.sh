#!/bin/bash
 
# Log Archiving Script - archive_logs.sh
# This script allows the user to select a log file,
# archive it with a timestamp, and create a new empty log file. 

# Display menu options to the user
echo "Select a log file to archive:"
echo "1) heart_rate_log.log"
echo "2) temperature_log.log"
echo "3) water_usage_log.log"

# Read user input and store it in the variable "choice"
read -p "Enter your choice [1-3]: " choice

# Determine the log file and archive directory based on user input
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
    # Handle invalid menu selection
    echo "Invalid choice. Please run the script again and choose 1, 2, or 3."
    exit 1
fi

# Check if the selected log file exists in the active_logs directory
# Exit the script if the log file is missing
if [ ! -f "active_logs/$log_file" ]; then
    echo "Error: Log file '$log_file' not found."
    exit 1
fi

# Check if the archive directory exists
# Create it if it does not exist
if [ ! -d "$archive_dir" ]; then
    mkdir -p "$archive_dir" || {
        echo "Error: Could not create archive directory '$archive_dir'."
        exit 1
    }
fi

# Generate a timestamp to uniquely name the archived log file
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

# Create the archived file name using the original log name and timestamp
archived_file="$archive_dir/${log_file%.*}_$timestamp.log"

# Move the active log file to the archive directory
# Exit if the move operation fails
mv "active_logs/$log_file" "$archived_file" || {
    echo "Error: Could not move log file to archive."
    exit 1
}

# Create a new empty log file for continued logging
touch "active_logs/$log_file" || {
    echo "Error: Could not create new log file."
    exit 1
}

# Display success message to the user
echo "Success! '$log_file' archived as '$archived_file'. New empty log created."
