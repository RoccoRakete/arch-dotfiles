#!/bin/bash

# set source path of dotfiles
SORCE_DIR="$(dirname "$(pwd)")"

# Check current default shell
CURREN_SHELL=$(basename "$SHELL")

# Files containing the packages to be installed
PACMAN_PKG_FILE="pkgs.txt"
AUR_PKG_FILE="pkgs_aur.txt"

# Theme Name
NEW_THEME="Orchis-Grey-Dark"
# Cursor Theme Name
CURSOR_THEME="Bibata-Modern-Classic"
# Font Name
FONT_NAME="Ubuntu Nerd Font 13"
# Path to GTK3 Config File
GTK3_CONFIG="$HOME/.config/gtk-3.0/settings.ini"

# Function to prompt for yes or no
prompt_yes_no() {
  while true; do
    read -p "$1 (y/n): " response
    case "$response" in
    [yY]) return 0 ;;
    [nN]) return 1 ;;
    *) echo "Please answer with y or n." ;;
    esac
  done
}

# 'gretting' function
greeting() {
  echo "This Script will install the Configuration for RoccoRakete's Hyprland Setup."
  if prompt_yes_no "Do you want to start?"; then
    for i in {3..1}; do
      echo -n "$i... "
      sleep 1
    done
    echo " "
    echo "Let's goooo!"
    echo " "
  else
    echo "Installation canceled"
    exit
  fi
}

# Fuction to configure pacman
pacman_conf() {
  # Backup the original pacman.conf
  sudo cp /etc/pacman.conf /etc/pacman.conf.bak
  echo "Backup of existing pacman.conf created at '/etc/pacman.conf.bak'!"
  # Uncomment ParallelDownloads if it is commented
  if grep -q '^#ParallelDownloads' /etc/pacman.conf; then
    if prompt_yes_no "Do you want to configure parallel downloads?"; then
      while true; do
        echo "How many parallel downloads do you want to allow? (2-10):"
        read NUM_DOWNLOADS
        # Check if input is valid
        if [[ "$NUM_DOWNLOADS" =~ ^[2-9]$ ]] || [[ "$NUM_DOWNLOADS" -eq 10 ]]; then
          echo "Setting ParallelDownloads to $NUM_DOWNLOADS."
          break
        else
          echo "Invalid input. Please enter a number between 2 and 10."
        fi
      done
      sudo sed -i "s/^#ParallelDownloads = .*/ParallelDownloads = $NUM_DOWNLOADS/" /etc/pacman.conf
    else
      echo "Parallel downloads not configured..."
    fi
  else
    echo "ParallelDownloads is already set or not commented."
    # Optionally, add it if not present
    if ! grep -q '^ParallelDownloads = 10' /etc/pacman.conf; then
      echo "Parallel downloads already configured!"
    fi
  fi

  # Add extra repository if not already present
  if ! grep -q '^\[extra\]' /etc/pacman.conf; then
    echo " "
    if prompt_yes_no "Configure Pacman to use the 'extra repository'? (This is needed!)"; then
      echo "Adding extra repository."
      echo -e "\n[extra]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
    else
      echo "'Extra repository' not configured... Aborting!"
      exit
    fi
  else
    echo "Extra repository is already enabled."
  fi

  # Add multilib repository if not already present
  if ! grep -q '^\[multilib\]' /etc/pacman.conf; then
    echo " "
    if prompt_yes_no "Configure Pacman to use the 'multilib repository'? (This is needed!)"; then
      echo "Adding multilib repository."
      echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
    else
      echo "'Multilib repository' not configured... Aborting!"
      exit
    fi
  else
    echo "Multilib repository is already enabled."
  fi

  # Update pacman
  echo " "
  sudo pacman -Sy

  echo " "
  echo "Configuration completed."
  echo " "
}

# yay install fuction
install_yay() {
  if ! command -v yay &>/dev/null; then
    echo "yay is not installed."
    if prompt_yes_no "Do you want to install yay?"; then
      echo "Installing yay..."
      sudo pacman -S --needed git base-devel &&
        git clone https://aur.archlinux.org/yay-bin.git &&
        cd yay-bin &&
        makepkg -si &&
        cd .. &&
        rm -rf yay-bin
      yay
    else
      echo "Installation of yay canceled."
      exit
    fi
  else
    echo "yay is already installed."
    yay
  fi
}

# Function to install packages with pacman
install_pacman_pkgs() {
  if [[ ! -f "$PACMAN_PKG_FILE" ]]; then
    echo "Error: File $PACMAN_PKG_FILE not found."
  else
    if prompt_yes_no "Do you want to proceed with the installation?"; then
      echo "Installing packages from $PACMAN_PKG_FILE..."
      sudo pacman -S --needed - <"$PACMAN_PKG_FILE"
    else
      echo "Package installation canceled."
      exit
    fi
  fi
}

# Function to install packages with yay
install_yay_pkgs() {
  if [[ ! -f "$AUR_PKG_FILE" ]]; then
    echo "Error: File $AUR_PKG_FILE not found."
  else
    if prompt_yes_no "Do you want to proceed with the installation?"; then
      echo "Installing packages from $AUR_PKG_FILE..."
      yay -S --needed - <"$AUR_PKG_FILE"
    else
      echo "AUR package installation canceled."
      exit
    fi
  fi
}

# Install Bun
fn_bun() {
  if prompt_yes_no "Do you want to install Bun (This is needed for HyprPanel to work!)?"; then
    curl -fsSL https://bun.sh/install | bash &&
      sudo ln -s $HOME/.bun/bin/bun /usr/local/bin/bun
  else
    echo "Bun not installed. Exiting! :("
    exit
  fi
}

# Function to install GTK-Theme
install_theme() {
  if prompt_yes_no "Do you want to install the 'Orchis-GTK-Theme'?"; then
    git clone https://github.com/vinceliuice/Orchis-theme.git
    cd Orchis-theme
    ./install.sh --tweaks solid black --theme grey --round 10
    cd -
    if prompt_yes_no "Do you want to set the installed theme?"; then
      # Check if File exists
      if [ ! -f "$GTK3_CONFIG" ]; then
        # Create File
        mkdir -p "$(dirname "$GTK3_CONFIG")"
        echo -e "[Settings]\ngtk-theme-name=$NEW_THEME" >"$GTK3_CONFIG"
      else
        # Set GTK Theme
        if grep -q "gtk-theme-name=" "$GTK3_CONFIG"; then
          sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$NEW_THEME/" "$GTK3_CONFIG"
        else
          echo "gtk-theme-name=$NEW_THEME" >>"$GTK3_CONFIG"
        fi
      fi
      echo "GTK Theme '$NEW_THEME' set."
    else
      echo "Theme not set!"
      exit
    fi
  else
    echo "$NEW_THEME not installed!"
    exit
  fi
}

# Function to set Cursor Theme
set_cursor() {
  if prompt_yes_no "Do you want to set the cursor theme to $CURSOR_THEME?"; then
    # Check if File exists
    if [ ! -f "$GTK3_CONFIG" ]; then
      # Create File
      mkdir -p "$(dirname "$GTK3_CONFIG")"
      echo -e "[Settings]\ngtk-cursor-theme-name=$CURSOR_THEME" >"$GTK3_CONFIG"
    else
      # Set Cursor Theme
      if grep -q "gtk-cursor-theme-name=" "$GTK3_CONFIG"; then
        sed -i "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$CURSOR_THEME/" "$GTK3_CONFIG"
      else
        echo "gtk-cursor-theme-name=$CURSOR_THEME" >>"$GTK3_CONFIG"
      fi
    fi
    echo "Cursor Theme '$CURSOR_THEME' set."
  else
    echo "Cursor Theme not set!"
    exit
  fi
}

# Function to set Font
set_font() {
  if prompt_yes_no "Do you want to set the Font to $FONT_NAME?"; then
    # Check if File exists
    if [ ! -f "$GTK3_CONFIG" ]; then
      # Create File
      mkdir -p "$(dirname "$GTK3_CONFIG")"
      echo -e "[Settings]\ngtk-font-name=$FONT_NAME" >"$GTK3_CONFIG"
    else
      # Set Font
      if grep -q "gtk-font-name=" "$GTK3_CONFIG"; then
        sed -i "s/^gtk-font-name=.*/gtk-font-name=$FONT_NAME/" "$GTK3_CONFIG"
      else
        echo "gtk-font-name=$FONT_NAME" >>"$GTK3_CONFIG"
      fi
    fi
    echo "Font '$FONT_NAME' set."
  else
    echo "Font not set!"
    exit
  fi
}

# Function to copy dotfiles
copy_dots() {
  # copy dotfiles to ~/.config/
  if prompt_yes_no "Do you want to copy my dotfiles now?"; then
    for dir in "$SORCE_DIR"/*/; do
      cp -r "$dir" ~/.config/
    done

    # Copy .zshrc to ~
    for file in "$SORCE_DIR"/*; do
      if [ -f "$file" ]; then
        cp "$file" ~/
      fi
    done
  else
    echo "Dotfiles not copied!"
    exit
  fi
}

# Function to set shell to zsh
set_shell() {
  # Check if zsh is already the default shell
  if [ "$CURREN_SHELL" == "zsh" ]; then
    echo "zsh is already set as your default shell."
  else
    if prompt_yes_no "Do you want to set zsh as your default shell"; then
      # Check if zsh is installed
      if command -v zsh >/dev/null 2>&1; then
        chsh -s "$(which zsh)"
        echo "Default shell changed to zsh."
      else
        echo "zsh is not installed. Please install it first."
        exit
      fi
    else
      echo "Shell change canceled!"
    fi
  fi
}

# Enable Services
fn_services() {
  if prompt_yes_no "Do you want to enable the reccomended System Services?"; then
    if prompt_yes_no "Enable GDM (login manager)?"; then
      sudo systemctl enable gdm.service
    else
      echo "GDM not enabled!"
    fi
    if prompt_yes_no "Enable Power-Profiles-Daemon?"; then
      sudo systemctl enable power-profiles-daemon.service
    else
      echo "Power-Profiles-Daemon not enabled!"
    fi
    if prompt_yes_no "Enable upower?"; then
      sudo systemctl enable upower.service
    else
      echo "upower not enabled!"
    fi
    if prompt_yes_no "Enable Bluetooth"; then
      sudo systemctl enable bluetooth.service
    else
      echo "Bluetooth not enabled"
    fi
  else
    echo "No System Services enabled!"
  fi
}

# Reboot Function
fn_reboot() {
  echo "Installation is now completed! <3"
  echo "It's now time to reboot your System!"
  if prompt_yes_no "Do you want to reboot now?"; then
    echo "Rebooting!"
    for i in {3..1}; do
      echo -n "$i... "
      sleep 1
    done
    echo "Bye! :)"
    for i in {1}; do
      echo -n "$i... "
      sleep -1
    done
    reboot
  else
    echo "Please make sure to reboot manually!"
    echo "Done, exiting! Bye :)"
  fi
}

##### Function calls #####

# Execture "greet" function
echo ' 
 _______  _______  _______  _______  _______  _______  _______  _        _______ _________ _______ 
(  ____ )(  ___  )(  ____ \(  ____ \(  ___  )(  ____ )(  ___  )| \    /\(  ____ \\__   __/(  ____ \
| (    )|| (   ) || (    \/| (    \/| (   ) || (    )|| (   ) ||  \  / /| (    \/   ) (   | (    \/
| (____)|| |   | || |      | |      | |   | || (____)|| (___) ||  (_/ / | (__       | |   | (__    
|     __)| |   | || |      | |      | |   | ||     __)|  ___  ||   _ (  |  __)      | |   |  __)   
| (\ (   | |   | || |      | |      | |   | || (\ (   | (   ) ||  ( \ \ | (         | |   | (      
| ) \ \__| (___) || (____/\| (____/\| (___) || ) \ \__| )   ( ||  /  \ \| (____/\   | |   | (____/\
|/   \__/(_______)(_______/(_______/(_______)|/   \__/|/     \||_/    \/(_______/   )_(   (_______/
'
greeting

# Configure Pacman
echo "################################"
echo "###### Configuring Pacman ######"
echo "################################"
echo " "
pacman_conf

# Check for yay and install if necessary
echo "###################################"
echo "###### Installation of 'yay' ######"
echo "###################################"
echo " "
install_yay

# Install Packages from Arch-Repos
echo ""
echo "######################################"
echo "###### Insatlling Arch Packages ######"
echo "######################################"
echo " "
install_pacman_pkgs

# Install AUR-Packages
echo ""
echo "#####################################"
echo "###### Insatlling AUR Packages ######"
echo "#####################################"
echo " "
install_yay_pkgs

# Install BUN
echo ""
echo "############################"
echo "###### Insatlling BUN ######"
echo "############################"
echo " "
fn_bun

# Install GTK-Theme
echo ""
echo "##################################"
echo "###### Insatlling GTK Theme ######"
echo "##################################"
echo " "
install_theme

# Install Cursor-Theme
echo ""
echo "#####################################"
echo "###### Insatlling Cursor Theme ######"
echo "#####################################"
echo " "
set_cursor

# Set Font
echo ""
echo "######################"
echo "###### Set Font ######"
echo "######################"
echo " "
set_font

# Copy dotfiles
echo ""
echo "###########################"
echo "###### Copy dotfiles ######"
echo "###########################"
echo " "
copy_dots

# Set default shell to zsh
echo ""
echo "##################################"
echo "###### Change default shell ######"
echo "##################################"
echo " "
set_shell

# Finish Installation
echo ""
echo "#################################"
echo "###### Finish Installation ######"
echo "#################################"
echo " "
fn_reboot

# Display installation result
echo "Installation process completed."
