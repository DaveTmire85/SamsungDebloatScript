
# Uninstall Script

## Overview

This project contains a shell script designed to uninstall a list of applications from an Android device. The script reads the package names of the applications to be uninstalled from a text file and attempts to uninstall each one, logging the results.

## Files Included

- **uninstall_script.sh**: The main shell script that performs the uninstallation.
- **apps.txt**: A text file containing the package names of the applications to be uninstalled.

## How It Works

1. **Initialize and Clear Log File**:
   - The script initializes a log file located at `/sdcard/uninstall_log.txt` and clears any previous content.

2. **Read Applications from File**:
   - The script reads the package names from `apps.txt`, which should be placed in the `/sdcard/` directory of the device.

3. **Uninstall Applications**:
   - For each application, the script:
     - Removes any whitespace from the package name.
     - Checks if the package name is not empty.
     - Logs the processing of the current application.
     - Checks if the application is installed on the device.
     - Attempts to uninstall the application if it is installed.
     - Logs the result of the uninstallation attempt (success or failure).
     - Logs if the application is not found on the device.

4. **Log Completion**:
   - Once all applications have been processed, the script logs the total number of applications processed and advises checking the log file for detailed results.

## Usage Instructions

1. **Prepare the Device**:
   - Ensure the device is rooted or has the necessary permissions to uninstall system applications.
   - Place the `apps.txt` file in the `/sdcard/` directory of the device.

2. **Run the Script**:
   - Execute the `uninstall_script.sh` script on the device. This can typically be done via a terminal emulator on the device or through an ADB (Android Debug Bridge) shell.

## Example Usage

```sh
sh /path/to/uninstall_script.sh
```

## Notes

- **Log File**:
  - The log file (`/sdcard/uninstall_log.txt`) contains detailed information about the uninstallation process for each application.
  - It logs the start and end of processing for each application, whether the application was found, and the result of the uninstallation attempt.

- **Modifying the Application List**:
  - To change the list of applications to be uninstalled, edit the `apps.txt` file and add or remove package names as needed.

- **Handling Errors**:
  - The script handles cases where the application is not found or the uninstallation fails, logging appropriate messages for troubleshooting.

## Sample `apps.txt` Content

Here is an example of what the `apps.txt` file might look like:

```
dsi.ant.sample.acquirechannels
dsi.ant.service.socket
samsung.android.messaging
samsung.android.drivelink.stub
sec.android.app.sbrowser
google.android.apps.tachyon
pandora.android
audible.application
```

Each line in the `apps.txt` file represents the package name of an application to be uninstalled.

## Contact

For any issues or further inquiries, please contact [Your Name/Email].
