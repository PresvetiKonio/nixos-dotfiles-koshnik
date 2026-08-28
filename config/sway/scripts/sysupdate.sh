#!/usr/bin/env bash

if grep -qi "nixos" /etc/os-release; then
  echo ">>> NixOS detected — rebuilding..."
#  sudo -v && nh os switch /etc/nixos
    sudo nixos-rebuild switch --flake ~/nixos-dotfiles#shitbox
elif grep -qi "arch" /etc/os-release; then
  echo ">>> Arch detected — running pacman..."
  sudo -v && yay --noconfirm
else
  echo ">>> Unknown OS, don't know how to update."
fi

echo ""
echo "Done. Press enter to close."
read
