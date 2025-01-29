# Uninstall Script

## Overview

This project contains a shell script designed to uninstall a list of applications from any Android device. The current `apps.txt` includes a comprehensive list of standard Samsung bloatware, carrier-specific apps, and other common preinstalled apps, but you can edit the `apps.txt` file to include any Android app you want to try to remove. The script reads the package names of the applications to be uninstalled from a text file and attempts to uninstall each one, logging the results.

### New Features in This Version:
1. **Interactive Mode**:
   - You can now choose whether to review each app before uninstalling or let the script run automatically.
   - In review mode, you’ll be prompted with a `y/n` option for each app found on your device.

2. **Improved Logging**:
   - Skipped apps (in review mode) are now logged with reasons (e.g., "Skipped as per user request").
   - A summary of total processed, successfully uninstalled, and failed apps is provided at the end.

3. **Backup of Installed Apps**:
   - Before making any changes, the script creates a backup of all installed apps in `/sdcard/installed_apps_backup.txt`.

4. **No Notifications for Missing Apps**:
   - The script no longer notifies users about apps in `apps.txt` that aren’t installed on their device, reducing unnecessary clutter.

5. **Enhanced Compatibility**:
   - Works seamlessly across all major U.S. carriers (Verizon, AT&T, T-Mobile, Sprint) and Samsung devices running Android 11 or later.
   - Retains critical functionality by excluding essential apps like Smart Switch.

---

## Files Included

- **debloat.sh**: The main shell script that performs the uninstallation.
- **apps.txt**: A text file containing the package names of applications to be uninstalled.

---

## How It Works

1. **Initialize and Clear Log File**:
   - The script initializes a log file located at `/sdcard/uninstall_log.txt` and clears any previous content.

2. **Backup Installed Apps**:
   - Before processing, a backup of all currently installed apps is saved to `/sdcard/installed_apps_backup.txt`.

3. **User Interaction Option**:
   - At runtime, you are asked if you want to review each app before uninstalling:
     - Enter `y` to enable review mode (you’ll confirm each app before uninstalling).
     - Enter `n` to disable review mode (the script will run automatically).

4. **Read Applications from File**:
   - The script reads package names from `apps.txt`, which should be placed in the `/sdcard/` directory of the device.

5. **Uninstall Applications**:
   - For each application found on your device:
     - If review mode is enabled, you’ll be prompted with a `y/n` option before uninstalling.
     - If review mode is disabled, all matching apps will be uninstalled automatically.
     - Logs whether each app was successfully uninstalled or skipped (in review mode).

6. **Log Completion**:
   - Once all applications have been processed, the script logs a summary of total processed apps and advises checking the log file for detailed results.

---

## Usage Instructions

### Prerequisites
1. Install ADB drivers for your device and ensure ADB is installed on your computer.
2. Enable USB Debugging on your device:
   - Go to **Settings > Developer Options > USB Debugging** and enable it.
   - If Developer Options are not visible, go to **Settings > About Phone > Software Information**, and tap **Build Number** 7 times.

### Setup
1. Save `debloat.sh` to a location accessible by your phone’s shell (e.g., `/data/local/tmp/`).
2. Save `apps.txt` to `/sdcard/apps.txt`.

### Running the Script
1. Make the script executable:
   ```bash
   chmod +x /data/local/tmp/debloat.sh
   ```
2. Run it from an ADB shell or terminal emulator:
   ```bash
   sh /data/local/tmp/debloat.sh
   ```

3. When prompted:
   - Enter `y` to enable review mode (you’ll confirm each app before uninstalling).
   - Enter `n` to disable review mode (the script will run automatically).

---

## Example Workflow

### Review Mode Enabled (`y`)
If you choose to review each app, you'll see prompts like this for every installed app listed in `apps.txt`:

```
App #1: com.samsung.android.messaging is installed. Do you want to uninstall it? (y/n)
```

- Enter `y` to uninstall the app.
- Enter `n` to skip it.

At the end of execution, you’ll see a summary of processed apps.

### Automatic Mode (`n`)
If you choose not to review each app, all matching apps listed in `apps.txt` that are installed will be uninstalled without further input.

---

## Sample `apps.txt` Content

Here’s an example of what the `apps.txt` file might look like:

```plaintext
# Samsung Bloatware
com.samsung.android.app.sbrowser         # Samsung Internet Browser
com.samsung.android.messaging            # Samsung Messages
com.samsung.android.bixby.agent          # Bixby Agent

# Carrier-Specific Bloatware
com.verizon.mips.services                # Verizon Services
com.att.dh                               # AT&T Device Help
com.tmobile.pr.mytmobile                 # T-Mobile My Account App

# Facebook and LinkedIn Apps
com.facebook.katana                      # Facebook App
com.linkedin.android                     # LinkedIn App

# Other Preinstalled Apps
amazon.shopping                          # Amazon Shopping App
spotify.music                            # Spotify Music App
netflix.mediaclient                      # Netflix App
```

---

## Notes

- Be cautious when editing `apps.txt`. Removing critical system apps may cause issues with device functionality.
- If you're unsure about an app, consider disabling it instead of uninstalling by replacing `pm uninstall --user 0` with `pm disable-user --user 0`.
- Always back up your data before running this script.

---

## Contact

For any issues or further inquiries, please contact [davetmire85 AT gmail.com]. Include "GitHub Debloat" in the subject line so your email isn’t filtered into SPAM by mistake!
