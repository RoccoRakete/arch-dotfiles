#!/bin/bash

      sudo pacman -S --needed --noconfirm git base-devel &&
        git clone https://aur.archlinux.org/yay-bin.git &&
        cd yay-bin &&
        makepkg -si &&
        cd .. &&
        rm -rf yay-bin
      yay
