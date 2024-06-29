#!/system/bin/sh

LOG_FILE="/sdcard/uninstall_log.txt"

# Clear the log file
echo "" > $LOG_FILE

count=0

# Read the apps from a file
while read app; do
    # Remove any whitespace
    app=$(echo "$app" | tr -d '[:space:]')
    [ -z "$app" ] && continue
    
    ((count++))
    
    echo "Processing app #$count: $app..." | tee -a $LOG_FILE

    if pm list packages | grep -q "$app"; then
        if pm uninstall --user 0 "$app"; then
            echo "Successfully uninstalled $app" | tee -a $LOG_FILE
        else
            echo "Failed to uninstall $app" | tee -a $LOG_FILE
        fi
    else
        echo "$app is not installed on the device" | tee -a $LOG_FILE
    fi

    echo "Finished processing $app. Moving to next app." | tee -a $LOG_FILE
done < /sdcard/apps.txt

echo "Script execution completed. Processed $count apps. Check $LOG_FILE for details."
