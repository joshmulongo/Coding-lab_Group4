LOG MANAGEMENT AND ANALYSIS SYSTEM

PROJECT OVERVIEW

This project is a simple Bash scripting application used to manage and analyze log files. It allows users to archive logs safely and generate basic analysis reports using command-line tools.

LEARNING OBJECTIVES

Practice writing interactive shell scripts

Work with files and directories using Bash

Automate log archiving with timestamps

Analyze log data using command-line tools

SCRIPT FUNCTIONALITY

Download the file Coding-lab_group4 to your local machine

Ensure that you have Execute permission

archive_logs.sh

Displays a menu to select a log file

Archives the selected log with a timestamp

Moves the log to an archive folder

Creates a new empty log file

Handles invalid input and missing files

analyze_logs.sh

Displays a menu to select the log file

Analyzes the selected log file

Counts device IDs

Finds first and last timestamps per device

Saves results to the report file

TOOLS we USED

Bash

awk

grep

sort

uniq

HOW TO RUN

Make the scripts executable
chmod +x archive_logs.sh analyze_logs.sh

Run the scripts
./archive_logs.sh
./analyze_logs.sh

FILE STRUCTURE

 Coding-lab_Group4/
├── active_logs
│   ├── heart_rate_log.log
│   ├── temperature_log.log
│   └── water_usage_log.log
├── analyze_logs.sh
├── archived_logs
│   ├── heart_data_archive
│   │   └── heart_rate_log_2026-01-29_14:54:28.log
│   ├── temperature_data_archive
│   │   ├── temperature_log_2026-01-29_14:54:01.log
│   │   └── temperature_log_2026-01-29_14:54:46.log
│   └── water_data_archive
│       └── water_usage_log_2026-01-29_14:54:39.log
├── archive_logs.sh
├── hospital_data
│   ├── active_logs
│   │   ├── heart_rate_log.log
│   │   ├── temperature_log.log
│   │   └── water_usage_log.log
│   ├── archives
│   ├── heart_rate_monitor.py
│   ├── temperature_recorder.py
│   └── water_consumption.py
├── README.md
└── reports
    └── analysis_report.txt



TEAM MEMBERS

Benitha Anny Akuzwe

Benson Mwai Maina
Joshua Gunnogere Mulongo

Kevine Niyonkuru

Tchatchum Chassem Stephane

CONCLUSION

This project shows how Bash scripting can be used to automate log management and perform basic data analysis using Linux command-line tools.
