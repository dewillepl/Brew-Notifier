# Brew Notifier

A simple Zsh script that automatically checks for outdated Homebrew packages and displays a notification when you open your terminal.

## Features

- **Automatic Daily Checks:** A cron job runs in the background to check for updates.
- **Terminal Notification:** See a clean list of packages that need upgrading right in your terminal.
- **Lightweight:** Just a simple shell script, no heavy dependencies.

## How It Works

The system has two components:

1.  **The Update Script (`scripts/update_brew_notifier.sh`):** This script is run by `cron`. It calls `brew update` and `brew outdated`, saving the list of outdated packages to a file in your home directory (`~/.brew_updates_available`).
2.  **The `.zshrc` Hook:** A small piece of code in your `~/.zshrc` file checks if the above file exists and has content. If it does, it prints a formatted notification to your terminal.

## Installation

1.  **Clone or download** this repository to a location on your computer, for example `~/.local/share/brew-notifier`.

2.  **Make the script executable:**
    ```bash
    chmod +x scripts/update_brew_notifier.sh
    ```

3.  **Add the notification hook to your `.zshrc` file.** Open `~/.zshrc` with a text editor and add the following lines at the end:

    ```zsh
    # --- Brew Notifier ---
    _BREW_NOTIFIER_FILE="$HOME/.brew_updates_available"
    if [ -s "$_BREW_NOTIFIER_FILE" ]; then
      echo ""
      echo -e "\e[1;33m🍻 Homebrew updates available:\e[0m"
      echo "------------------------------------"
      sed 's/^/  /' "$_BREW_NOTIFIER_FILE"
      echo "------------------------------------"
      echo -e "To upgrade, run: \e[1;32mbrew upgrade\e[0m"
      echo ""
      # Remove the file to not show the notification again
      rm "$_BREW_NOTIFIER_FILE"
    fi
    unset _BREW_NOTIFIER_FILE
    # --- End Brew Notifier ---
    ```

4.  **Set up the cron job to run the script automatically.**
    - Open the cron editor:
      ```bash
      crontab -e
      ```
    - Add the following line. **Remember to replace `/path/to/your/brew-notifier` with the actual absolute path** to where you cloned the repository.

      ```crontab
      # Run the brew-notifier script daily at 10 AM.
      0 10 * * * /bin/zsh /path/to/your/brew-notifier/scripts/update_brew_notifier.sh > /tmp/brew_notifier.log 2>&1
      ```

That's it! The script will now run daily, and you'll be notified of any updates the next time you open a terminal.
