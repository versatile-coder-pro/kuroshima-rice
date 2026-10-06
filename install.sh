#!/usr/bin/env bash

set -e

# ============================================================
# Kuroshima - Installer
# Arch Linux
# ============================================================

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
LOCAL_SHARE="$HOME/.local/share"
BACKUP_DIR="$HOME/.config/rice-backup-$(date +%Y%m%d-%H%M%S)"

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
RESET='\033[0m'

info() {
    echo -e "${CYAN}[INFO]${RESET} $1"
}

success() {
    echo -e "${GREEN}[OK]${RESET} $1"
}

warning() {
    echo -e "${YELLOW}[WARN]${RESET} $1"
}

error() {
    echo -e "${RED}[ERROR]${RESET} $1"
}

# ------------------------------------------------------------
# Header
# ------------------------------------------------------------

clear

echo
echo "=============================================="
echo "       Kuroshima Installer"
echo "=============================================="
echo

# ------------------------------------------------------------
# Check operating system
# ------------------------------------------------------------

if [[ ! -f /etc/arch-release ]]; then
    error "This installer is intended for Arch Linux."
    exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
    error "pacman was not found."
    exit 1
fi

success "Arch Linux detected."

# ------------------------------------------------------------
# Check sudo
# ------------------------------------------------------------

if ! command -v sudo >/dev/null 2>&1; then
    error "sudo is required."
    exit 1
fi

# ------------------------------------------------------------
# Required official repository packages
# ------------------------------------------------------------

OFFICIAL_PACKAGES=(
    hyprland
    sddm

    rofi
    yazi
    cava

    kitty
    zsh
    zsh-autocomplete
    zsh-autosuggestions

    nitch

    hyprlock
    wlogout

    brightnessctl
    playerctl

    grim
    slurp
    wl-clipboard

    jq
    imagemagick
    libnotify

    network-manager-applet

    pipewire-pulse

    qt6-svg
    qt6-imageformats
    qt6-multimedia
    qt6-virtualkeyboard

    xdg-desktop-portal-hyprland

    noto-fonts
    noto-fonts-emoji
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    ttf-material-symbols-variable
    ttf-nerd-fonts-symbols
)

echo
info "Installing official Arch packages..."
echo

sudo pacman -S --needed "${OFFICIAL_PACKAGES[@]}"

success "Official packages installed."

# ------------------------------------------------------------
# Check yay
# ------------------------------------------------------------

echo
info "Checking for yay..."

if ! command -v yay >/dev/null 2>&1; then
    error "yay is not installed."
    echo
    echo "Please install yay first, then run this installer again."
    echo
    exit 1
fi

success "yay detected."

# ------------------------------------------------------------
# AUR packages
# ------------------------------------------------------------

AUR_PACKAGES=(
    awww
    matugen-bin
    quickshell-git
    sddm-silent-theme
)

echo
info "Installing AUR packages..."
echo

yay -S --needed "${AUR_PACKAGES[@]}"

success "AUR packages installed."

# ------------------------------------------------------------
# Create backup
# ------------------------------------------------------------

echo
info "Creating configuration backup..."

mkdir -p "$BACKUP_DIR"

backup_path() {
    local source="$1"
    local destination="$2"

    if [[ -e "$source" ]]; then
        mkdir -p "$(dirname "$destination")"
        cp -a "$source" "$destination"
    fi
}

# Hyprland
backup_path \
    "$HOME/.config/hypr" \
    "$BACKUP_DIR/config/hypr"

# Kitty
backup_path \
    "$HOME/.config/kitty" \
    "$BACKUP_DIR/config/kitty"

# Rofi
backup_path \
    "$HOME/.config/rofi" \
    "$BACKUP_DIR/config/rofi"

# Zsh
backup_path \
    "$HOME/.zshrc" \
    "$BACKUP_DIR/home/.zshrc"

# Powerlevel10k
backup_path \
    "$HOME/.p10k.zsh" \
    "$BACKUP_DIR/home/.p10k.zsh"

# UKUSHIMA / Quickshell
backup_path \
    "$HOME/.local/share/quickshell/ukishima" \
    "$BACKUP_DIR/quickshell/ukishima"

success "Backup created at:"
echo "  $BACKUP_DIR"

# ------------------------------------------------------------
# Install Hyprland configuration
# ------------------------------------------------------------

echo
info "Installing Hyprland configuration..."

mkdir -p "$CONFIG_DIR"

rm -rf "$CONFIG_DIR/hypr"
cp -a "$REPO_DIR/config/hypr" "$CONFIG_DIR/"

success "Hyprland configuration installed."

# ------------------------------------------------------------
# Install Kitty configuration
# ------------------------------------------------------------

info "Installing Kitty configuration..."

rm -rf "$CONFIG_DIR/kitty"
cp -a "$REPO_DIR/config/kitty" "$CONFIG_DIR/"

success "Kitty configuration installed."

# ------------------------------------------------------------
# Install Rofi configuration
# ------------------------------------------------------------

info "Installing Rofi configuration..."

rm -rf "$CONFIG_DIR/rofi"
cp -a "$REPO_DIR/config/rofi" "$CONFIG_DIR/"

success "Rofi configuration installed."

# ------------------------------------------------------------
# Install UKUSHIMA / Quickshell
# ------------------------------------------------------------

info "Installing UKUSHIMA Quickshell configuration..."

if [[ -d "$REPO_DIR/config/quickshell/ukishima" ]]; then

    mkdir -p "$LOCAL_SHARE/quickshell"

    rm -rf "$LOCAL_SHARE/quickshell/ukishima"

    cp -a \
        "$REPO_DIR/config/quickshell/ukishima" \
        "$LOCAL_SHARE/quickshell/"

    success "UKUSHIMA installed to:"
    echo "  $LOCAL_SHARE/quickshell/ukishima"

else

    error "UKUSHIMA configuration was not found in the repository."
    error "Kuroshima cannot be installed without it."
    exit 1

fi
# ------------------------------------------------------------
# Install Zsh configuration
# ------------------------------------------------------------

echo
info "Installing Zsh configuration..."

if [[ -f "$REPO_DIR/home/.zshrc" ]]; then
    cp "$REPO_DIR/home/.zshrc" "$HOME/.zshrc"
    success ".zshrc installed."
fi

if [[ -f "$REPO_DIR/home/.p10k.zsh" ]]; then
    cp "$REPO_DIR/home/.p10k.zsh" "$HOME/.p10k.zsh"
    success ".p10k.zsh installed."
fi

# ------------------------------------------------------------
# Make scripts executable
# ------------------------------------------------------------

echo
info "Setting executable permissions..."

if [[ -d "$CONFIG_DIR/hypr" ]]; then
    find "$CONFIG_DIR/hypr" \
        -type f \
        -name "*.sh" \
        -exec chmod +x {} \;
fi

if [[ -d "$LOCAL_SHARE/quickshell/ukishima" ]]; then
    find "$LOCAL_SHARE/quickshell/ukishima" \
        -type f \
        -name "*.sh" \
        -exec chmod +x {} \;
fi

success "Permissions configured."

# ------------------------------------------------------------
# Configure SDDM
# ------------------------------------------------------------

echo
info "Configuring SDDM..."

sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/10-silent.conf > /dev/null <<EOF
[General]
InputMethod=qtvirtualkeyboard

[Theme]
Current=silent
EOF

success "SDDM configured to use Silent."

# ------------------------------------------------------------
# Enable SDDM
# ------------------------------------------------------------

echo
info "Enabling SDDM..."

sudo systemctl enable sddm.service

success "SDDM enabled."

# ------------------------------------------------------------
# Final information
# ------------------------------------------------------------

echo
echo "=============================================="
echo -e "             ${GREEN}Installation Complete${RESET}"
echo "=============================================="
echo

echo "Your rice has been installed."

echo
echo "Backup:"
echo "  $BACKUP_DIR"

echo
echo "Important:"
echo "  • Your Hyprland config assumes monitor DP-1."
echo "  • UKUSHIMA is installed in ~/.local/share/quickshell/ukishima"
echo "  • SDDM is configured to use Silent."
echo

echo "Reboot to start using the complete setup."

echo
echo "If something goes wrong:"
echo "  1. Switch to a TTY with Ctrl+Alt+F3"
echo "  2. Log in"
echo "  3. Restore your backup from:"
echo "     $BACKUP_DIR"

echo
echo "Enjoy your rice."
echo
