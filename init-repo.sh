#!/usr/bin/env bash
set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}

# You want this available globally
dotdir="$HOME/.dotfiles"
GIT_BIN="$(command -v git)"

# Define cfg so the user can use it after sourcing this script
cfg() {
    "$GIT_BIN" --git-dir="$dotdir" --work-tree="$HOME" "$@"
}

print "Setting up bare dotfiles repository…"

if [[ ! -d "$dotdir" || ! -f "$dotdir/HEAD" ]]; then
    print "Cloning bare repo into $dotdir"
    rm -rf "$dotdir"
    "$GIT_BIN" clone --bare "https://github.com/sandyberko/dotfiles" "$dotdir"

    print "Checking out 'main' into \$HOME"
    if ! cfg checkout main; then
        echo "⚠️  Checkout failed due to conflicts in your home directory."
        echo "    Fix conflicts and run this script again."
        return 1
    fi

    cfg branch --set-upstream-to=origin/main main
    cfg config status.showUntrackedFiles no
else
    print "⚪ Dotfiles repo already exists — skipping clone"
fi

print "🎉 dotfiles setup complete"
