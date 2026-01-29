#/bin/bash

# Display menu
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"

# Read user input and store in variable named choice
read -p "Enter choice (1-3): " choice

# Determine log file selected based on user "choice" variable
if [ "$choice" = "1" ]; then
    log_file="active_logs/heart_rate_log.log"
elif [ "$choice" = "2" ]; then
    log_file="active_logs/temperature_log.log"
elif [ "$choice" = "3" ]; then
    log_file="active_logs/water_usage_log.log"
else
    echo "Invalid input. Please enter 1, 2, or 3."
    exit 1
fi

# Check if log file exists. If not, display error and exit
if [ ! -f "$log_file" ]; then
    echo "Error: $log_file does not exist."
    exit 1
fi

# Create reports directory if it does not exist in directory tree
if [ ! -d "reports" ]; then
    mkdir reports
fi

# Report file
report_file="reports/analysis_report.txt"

# Write report header by appending to file
echo "-----------------------------------" >> "$report_file"
echo "Log Analysis Report" >> "$report_file"
echo "File analyzed: $log_file" >> "$report_file"
echo "Date: $(date)" >> "$report_file"
echo "" >> "$report_file"

# Count how many times each device appears with repect to the third column that holds device IDs
echo "Device Count:" >> "$report_file"
awk '{print $3}' "$log_file" | sort | uniq -c >> "$report_file"
echo "" >> "$report_file"

# Find first and last timestamp for each device
echo "First and Last Timestamps per Device:" >> "$report_file"
#device IDs from column 3 of the logs
devices=$(awk '{print $3}' "$log_file" | sort | uniq)

#loop through each device in the column 3 list from devices variable above
for device in $devices
do
#get first and last timestamps for each device
    first_time=$(grep "$device" "$log_file" | head -n 1 | awk '{print $1, $2}')
    last_time=$(grep "$device" "$log_file" | tail -n 1 | awk '{print $1, $2}')
# write result for each device and subsequently append to report file
    echo "$device - First: $first_time | Last: $last_time" >> "$report_file"
done

echo "" >> "$report_file"
echo "Analysis completed successfully."
echo "Results saved in $report_file"
