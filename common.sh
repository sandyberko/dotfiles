#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}
