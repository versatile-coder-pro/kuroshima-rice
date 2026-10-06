# Kuroshima

> A dark, glassy Hyprland rice focused on making a beautiful desktop that is still practical to use every day.

Kuroshima is my personal Arch Linux / Hyprland setup, built around a dark glass aesthetic, dynamic colors, smooth animations, and a setup that doesn't sacrifice everyday usability just to look good in screenshots.

It brings together Hyprland, Quickshell, Matugen, awww, Rofi, Yazi, Kitty, Cava and several smaller utilities into one cohesive desktop.

This is not meant to be a "minimal everything" rice. The goal is simple:

**Make the desktop look good, feel good, and still get out of the way when you actually need to work.**

---

## Screenshots

> Screenshots coming soon.

---

## What's inside

| Component | Used for |
|---|---|
| [Hyprland](https://hyprland.org/) | Wayland compositor |
| [Quickshell](https://quickshell.org/) | Desktop shell, pill, dock and system UI |
| [Matugen](https://github.com/InioX/matugen) | Dynamic color generation |
| [awww](https://codeberg.org/LGFae/awww) | Wallpaper handling |
| [Rofi](https://github.com/davatorium/rofi) | Application launcher |
| [Yazi](https://yazi-rs.github.io/) | Terminal file manager |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal |
| [Cava](https://github.com/karlstav/cava) | Audio visualizer |
| [Zsh](https://www.zsh.org/) + Powerlevel10k | Shell |
| [Nitch](https://github.com/ssleert/nitch) | System information |
| [Silent](https://github.com/uiriansan/SilentSDDM) | Login screen |

---

## Features

- Dark glass-inspired interface
- Dynamic wallpaper-based colors
- Quickshell desktop pill and system controls
- Custom Hyprland configuration
- Rofi launcher with custom styling
- Kitty configuration with custom colors and shaders
- Yazi terminal file manager
- Cava integration
- Custom lock screen
- Wallpaper controls
- Clipboard utilities
- Media controls
- Network and Bluetooth controls
- System monitoring
- Power controls
- Zsh + Powerlevel10k configuration
- SDDM Silent theme
- Backup creation before installation

---

# Installation

## Requirements

Kuroshima is designed for **Arch Linux**.

The installer expects:

- Arch Linux
- `sudo`
- `yay`
- An active internet connection

The installer will install the required official Arch packages and AUR packages automatically.

### Before installing

This is a full desktop configuration, not just a theme.

It will modify your:

- Hyprland configuration
- Kitty configuration
- Rofi configuration
- Zsh configuration
- Powerlevel10k configuration
- Quickshell configuration
- SDDM configuration

**Please make sure you understand this before running the installer.**

---

## Install

Clone the repository:

```bash
git clone https://github.com/versatile-coder-pro/kuroshima-rice.git
cd kuroshima-rice
```

Make the installer executable:

```bash
chmod +x install.sh
```

Run it:

```bash
./install.sh
```

The installer will:

1. Check that you are running Arch Linux.
2. Install the required packages.
3. Install the required AUR packages through `yay`.
4. Back up your existing configurations.
5. Install the Kuroshima Hyprland configuration.
6. Install the Quickshell configuration.
7. Install Kitty and Rofi configurations.
8. Install Zsh and Powerlevel10k configurations.
9. Configure Silent SDDM.
10. Enable SDDM.

---

# Backups

Kuroshima automatically creates a backup before replacing your existing configurations.

Backups are stored at:

```text
~/.config/rice-backup-YYYYMMDD-HHMMSS/
```

For example:

```text
~/.config/rice-backup-20261006-203000/
```

If something goes wrong, switch to a TTY:

```text
Ctrl + Alt + F3
```

Log in and restore your previous configuration from the backup directory.

---

# Important configuration notes

## Monitor

The current Hyprland configuration assumes the monitor is named:

```text
DP-1
```

If your monitor has a different name, edit:

```text
config/hypr/modules/monitors.lua
```

before using the configuration.

You can find your monitor name with:

```bash
hyprctl monitors
```

---

## Quickshell

Kuroshima installs its Quickshell configuration to:

```text
~/.local/share/quickshell/ukishima
```

This location is intentional because the configuration and Hyprland startup commands reference it.

---

## Wallpapers

The wallpaper system uses **awww** and the Quickshell wallpaper interface.

Your own wallpaper directory can be configured to suit your setup.

---

# Customization

Kuroshima is meant to be customized.

Most of the important configuration lives inside:

```text
config/
```

### Hyprland

```text
config/hypr/
```

Includes:

- keybinds
- animations
- decorations
- input
- layouts
- window rules
- monitors
- environment variables
- startup applications

### Kitty

```text
config/kitty/
```

### Rofi

```text
config/rofi/
```

### Quickshell

```text
config/quickshell/ukishima/
```

### Zsh

```text
home/.zshrc
home/.p10k.zsh
```

---

# Philosophy

Kuroshima started as a personal rice.

I didn't want to build a desktop that looked amazing in a screenshot but became annoying after using it for a few hours.

So the goal became a balance:

**Looks matter. Performance matters. Usability matters.**

Some parts of Kuroshima are based on existing open-source projects and components. Instead of reinventing every component, I focused on putting the pieces together, configuring them, modifying what I needed, and making the whole desktop feel consistent.

That's what Kuroshima is about.

---

# Credits & Attribution

Kuroshima would not exist without the work of the developers whose projects it builds upon.

A huge thank you to everyone who made these projects possible.

## UKUSHIMA

A significant part of Kuroshima's Quickshell desktop interface is based on **UKUSHIMA**.

The original project provides the foundation for many of the Quickshell components used here, including the pill, system surfaces, lock screen and supporting components.

**Original project:**  
https://github.com/your-upstream-ukishima-repository

Please refer to the included `LICENSE` and `README.md` inside:

```text
config/quickshell/ukishima/
```

for the original project's licensing and attribution information.

Kuroshima does **not** claim ownership of the original UKUSHIMA code.

My contribution is primarily the configuration, integration, modifications and overall Kuroshima setup built around it.

---

## Silent SDDM

Kuroshima uses the **Silent SDDM theme** for the login screen.

**Project:**  
https://github.com/uiriansan/SilentSDDM

Please respect the original project's license and attribution requirements.

The theme itself is not bundled as part of Kuroshima; the installer installs it separately through the AUR.

---

## Other projects

Kuroshima also depends on or makes use of several excellent open-source projects:

- Hyprland
- Quickshell
- Matugen
- awww
- Rofi
- Yazi
- Kitty
- Cava
- Zsh
- Powerlevel10k
- Nitch
- wl-clipboard
- grim
- slurp
- and many other smaller utilities

Please check the respective projects for their licenses and original authors.

---

# Disclaimer

This configuration is primarily tested on my own Arch Linux setup.

Your hardware, monitor names, installed packages, fonts, drivers and existing configuration may be different.

**Don't blindly run configuration installers you don't understand.**

Read the installer first if you're unsure about what it changes.

---

# License

Kuroshima's own configuration and scripts are provided under the license included in this repository.

Some files contained in this repository originate from or are derived from other open-source projects and remain subject to their respective licenses.

See the individual project files and licenses for details.

---

# Contributing

Found something broken?

Have a cleaner solution?

Want to improve part of the configuration?

Feel free to open an issue or pull request.

I'm still improving Kuroshima, so suggestions and fixes are welcome.

---

## Final note

Kuroshima is a work in progress.

It's built around the way **I** use my desktop right now, so some things will probably change over time.

If you end up using it, modifying it, or building your own setup from it, I'd love to see what you do with it.

**Have fun ricing.**
