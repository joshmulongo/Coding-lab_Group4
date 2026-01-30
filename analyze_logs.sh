#!/bin/bash
# -------------------------------
# The analyze_logs.sh Script allows the user to select a log file, and it will analyse its contents and generate a report saved to the reports directory
# -------------------------------

# Display menu options to the user
echo "Select log file to analyse:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"

# Read user input and store it in the variable "choice"
read -p "Enter choice (1-3): " choice

# Determine which log file to analyze based on user input
if [ "$choice" = "1" ]; then
    log_file="active_logs/heart_rate_log.log"
elif [ "$choice" = "2" ]; then
    log_file="active_logs/temperature_log.log"
elif [ "$choice" = "3" ]; then
    log_file="active_logs/water_usage_log.log"
else
    # Handle invalid menu selection
    echo "Invalid input. Please enter 1, 2, or 3."
    exit 1
fi

# Check if the selected log file exists
# Exit the script if the file is not found
if [ ! -f "$log_file" ]; then
    echo "Error: $log_file does not exist."
    exit 1
fi

# Create the reports directory if it does not already exist
if [ ! -d "reports" ]; then
    mkdir reports
fi

# Define the report file location
report_file="reports/analysis_report.txt"

# Write report header information (append mode)
echo "-----------------------------------" >> "$report_file"
echo "Log Analysis Report" >> "$report_file"
echo "File analyzed: $log_file" >> "$report_file"
echo "Date: $(date)" >> "$report_file"
echo "" >> "$report_file"

# Count how many times each device ID appears
# Device IDs are assumed to be in the third column of the log file
echo "Device Count:" >> "$report_file"
awk '{print $3}' "$log_file" | sort | uniq -c >> "$report_file"
echo "" >> "$report_file"

# Display section header for timestamp analysis
echo "First and Last Timestamps per Device:" >> "$report_file"

# Extract unique device IDs from the third column
devices=$(awk '{print $3}' "$log_file" | sort | uniq)

# Loop through each device ID
for device in $devices
do
    # Get the first timestamp for the current device
    first_time=$(grep "$device" "$log_file" | head -n 1 | awk '{print $1, $2}')

    # Get the last timestamp for the current device
    last_time=$(grep "$device" "$log_file" | tail -n 1 | awk '{print $1, $2}')

    # Append the results for the device to the report file
    echo "$device - First: $first_time | Last: $last_time" >> "$report_file"
done

# Add spacing and display completion messages
echo "" >> "$report_file"
echo "Analysis completed successfully."
echo "Results saved in $report_file"
