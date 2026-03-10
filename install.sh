#!/usr/bin/env bash
# =============================================================================
#  VPS Wizard — Installer
#  Usage:
#    curl -fsSL https://raw.githubusercontent.com/scott-lexium/forge/main/install.sh | sudo bash
#  Or locally:
#    sudo bash install.sh
# =============================================================================
set -euo pipefail

TOOL_NAME="forge"
INSTALL_PATH="/usr/local/bin/${TOOL_NAME}"
CHANNEL="stable"
[[ "${1:-}" == "--canary" ]] && CHANNEL="canary"
GITHUB_RAW="https://raw.githubusercontent.com/scott-lexium/forge/${CHANNEL}"
LOG_DIR="/var/log/forge"
CONFIG_DIR="/etc/forge"

# ─── Colours ──────────────────────────────────────────────────────────────────
G='\033[0;32m' Y='\033[1;33m' R='\033[0;31m' C='\033[0;36m'
W='\033[1;37m' D='\033[2;37m' RESET='\033[0m'
OK="${G}✔${RESET}" ERR="${R}✘${RESET}" ARROW="${C}❯${RESET}"

ok()    { echo -e "  ${OK} $1"; }
info()  { echo -e "  ${ARROW} ${W}$1${RESET}"; }
error() { echo -e "  ${ERR} ${R}$1${RESET}"; exit 1; }
warn()  { echo -e "  ${Y}⚠  $1${RESET}"; }

# ─── Root check ───────────────────────────────────────────────────────────────
[[ $EUID -ne 0 ]] && error "Installer must be run as root. Use: sudo bash install.sh"

# ─── Detect OS ────────────────────────────────────────────────────────────────
if [[ ! -f /etc/os-release ]]; then
    error "Cannot detect OS. This installer supports Ubuntu 20.04/22.04/24.04."
fi
source /etc/os-release
if [[ "$ID" != "ubuntu" ]]; then
    warn "Detected OS: ${PRETTY_NAME:-unknown}. This tool is optimised for Ubuntu."
    echo -en "  ${C}?${RESET} Continue anyway? [y/${W}N${RESET}]: "
    read -r ans
    [[ "$ans" =~ ^[Yy] ]] || { echo "  Aborted."; exit 0; }
fi

# ─── Header ───────────────────────────────────────────────────────────────────
echo ""
echo -e "${C}${W}"
echo "  ┌───────────────────────────────────────────────────────────┐"
echo "  │          VPS Wizard — Installer                           │"
echo "  └───────────────────────────────────────────────────────────┘"
echo -e "${RESET}"
echo -e "  ${D}Installing to: ${W}${INSTALL_PATH}${RESET}"
echo -e "  ${D}OS detected:   ${W}${PRETTY_NAME:-unknown}${RESET}"
echo ""

# ─── Dependencies ─────────────────────────────────────────────────────────────
info "Checking dependencies..."
MISSING=()
for dep in curl bash; do
    command -v "$dep" &>/dev/null || MISSING+=("$dep")
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    info "Installing missing deps: ${MISSING[*]}"
    apt-get update -qq
    apt-get install -y "${MISSING[@]}" -qq
fi
ok "Dependencies satisfied"

# ─── Determine source ─────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BINARY="${SCRIPT_DIR}/forge"

if [[ -f "$LOCAL_BINARY" ]]; then
    # Installing from a local clone / directory
    info "Local binary found at ${LOCAL_BINARY} — installing from local source"
    cp "$LOCAL_BINARY" "$INSTALL_PATH"
    ok "Copied from local source"
else
    # Download from GitHub
    info "Downloading latest forge from GitHub..."
    if curl -fsSL "${GITHUB_RAW}/forge" -o "$INSTALL_PATH"; then
        ok "Downloaded from GitHub"
    else
        error "Download failed. Check your internet connection or install manually:\n  curl -fsSL ${GITHUB_RAW}/forge -o ${INSTALL_PATH}"
    fi
fi

# ─── Permissions ──────────────────────────────────────────────────────────────
chmod +x "$INSTALL_PATH"
ok "Executable bit set"

# ─── Create directories ───────────────────────────────────────────────────────
mkdir -p "$LOG_DIR"   && chmod 750 "$LOG_DIR"
mkdir -p "$CONFIG_DIR" && chmod 750 "$CONFIG_DIR"
ok "Log dir:    ${LOG_DIR}"
ok "Config dir: ${CONFIG_DIR}"

# ─── Verify ───────────────────────────────────────────────────────────────────
if command -v "$TOOL_NAME" &>/dev/null; then
    INSTALLED_VER=$("$TOOL_NAME" version 2>/dev/null | awk '{print $NF}')
    echo ""
    echo -e "  ${G}${W}✔  forge ${INSTALLED_VER} installed successfully!${RESET}"
else
    error "Installation failed — binary not found in PATH"
fi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "  ${W}Get started:${RESET}"
echo -e "  ${C}  sudo forge${RESET}           ${D}# run the full wizard${RESET}"
echo -e "  ${C}  sudo forge status${RESET}    ${D}# check server hardening status${RESET}"
echo -e "  ${C}  sudo forge phase 5${RESET}   ${D}# run a single phase${RESET}"
echo -e "  ${C}  sudo forge help${RESET}      ${D}# see all commands${RESET}"
echo -e "  ${C}  sudo forge update${RESET}    ${D}# self-update to latest version${RESET}"
echo ""
echo -e "  ${D}Logs are saved to: ${W}${LOG_DIR}/${RESET}"
echo ""
