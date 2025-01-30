#!/bin/bash

LOG_FILE="/sdcard/uninstall_log.txt"
APPS_FILE="/sdcard/apps.txt"
BACKUP_FILE="/sdcard/installed_apps_backup.txt"

# Clear the log file
echo "" > $LOG_FILE

count=0
success_count=0
failure_count=0

# Verify if apps.txt exists
if [ ! -f $APPS_FILE ]; then
    echo "Error: $APPS_FILE not found. Please create the file with package names to uninstall." | tee -a $LOG_FILE
    exit 1
fi

# Backup installed apps before proceeding
pm list packages > $BACKUP_FILE
echo "Backup of installed apps saved to $BACKUP_FILE" | tee -a $LOG_FILE

# Detect if Shizuku is installed and running
if command -v rish >/dev/null 2>&1 && rish --version >/dev/null 2>&1; then
    SHIZUKU_AVAILABLE=true
    echo "Shizuku detected. Using Shizuku for ADB-level permissions." | tee -a $LOG_FILE
else
    SHIZUKU_AVAILABLE=false
    echo "Shizuku not detected. Falling back to standard pm commands." | tee -a $LOG_FILE
fi

# Ask user if they want to review each app before uninstalling
echo "Do you want to review each app before uninstalling? (y/n)"
read -r review_mode

# Read the apps from the file
while read -r app; do
    # Remove any whitespace or empty lines
    app=$(echo "$app" | tr -d '[:space:]')
    [ -z "$app" ] && continue

    count=$((count + 1))  # Increment count using POSIX-compatible syntax

    # Debugging output for each app being processed
    echo "Processing app #$count: $app" | tee -a $LOG_FILE

    # Check if the app is installed
    if pm list packages | grep -q "$app"; then
        # If review mode is enabled, prompt the user for confirmation
        if [ "$review_mode" = "y" ]; then
            echo "App #$count: $app is installed. Do you want to uninstall it? (y/n)"
            read -r user_choice

            if [ "$user_choice" != "y" ]; then
                echo "Skipping $app as per user request." | tee -a $LOG_FILE
                continue
            fi
        fi

        # Attempt to uninstall the app using Shizuku if available, otherwise fallback to pm
        echo "Uninstalling app #$count: $app..." | tee -a $LOG_FILE
        
        if [ "$SHIZUKU_AVAILABLE" = true ]; then
            if rish pm uninstall --user 0 "$app"; then
                echo "Successfully uninstalled $app using Shizuku." | tee -a $LOG_FILE
                success_count=$((success_count + 1))
            else
                echo "Failed to uninstall $app using Shizuku." | tee -a $LOG_FILE
                failure_count=$((failure_count + 1))
            fi
        else
            if pm uninstall --user 0 "$app"; then
                echo "Successfully uninstalled $app using standard pm command." | tee -a $LOG_FILE
                success_count=$((success_count + 1))
            else
                echo "Failed to uninstall $app using standard pm command." | tee -a $LOG_FILE
                failure_count=$((failure_count + 1))
            fi
        fi

    else
        echo "$app is not installed on this device." | tee -a $LOG_FILE
    fi

done < "$APPS_FILE"

# Summary of results
echo "Script execution completed." | tee -a $LOG_FILE
echo "Processed $count apps: $success_count successfully uninstalled, $failure_count failed." | tee -a $LOG_FILE
echo "Check the log file at $LOG_FILE for details."
