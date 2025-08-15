#!/bin/zsh

echo "[BREW NOTIFIER] Starting script..."

OUTDATED_FILE="$HOME/.brew_updates_available"

# The script assumes brew is installed in /opt/homebrew/bin/brew (standard for Apple Silicon).
# If you have a different path (e.g., on an Intel Mac: /usr/local/bin/brew), change it here.
BREW_PATH="/opt/homebrew/bin/brew"

if [ ! -x "$BREW_PATH" ]; then
    echo "[BREW NOTIFIER] ERROR: brew executable not found at: $BREW_PATH"
    exit 1
fi

echo "[BREW NOTIFIER] Step 1/2: Updating Homebrew repositories (brew update)..."
$BREW_PATH update > /dev/null 2>&1
echo "[BREW NOTIFIER] Done."


echo "[BREW NOTIFIER] Step 2/2: Checking for outdated packages (brew outdated)..."
$BREW_PATH outdated > "$OUTDATED_FILE"
echo "[BREW NOTIFIER] Done."

if [ -s "$OUTDATED_FILE" ]; then
    echo "[BREW NOTIFIER] Found outdated packages. List saved to $OUTDATED_FILE"
else
    echo "[BREW NOTIFIER] All packages are up to date. $OUTDATED_FILE is empty."
fi

echo "[BREW NOTIFIER] Script finished."
