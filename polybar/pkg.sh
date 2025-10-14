#!/bin/sh

# Initialize update counts
updates_arch=$(pacman -Qu 2>/dev/null | wc -l || echo 0)
updates_aur=$(yay -Qua 2>/dev/null | wc -l || echo 0)

updates=$((updates_arch + updates_aur))

if [ "$updates" -gt 0 ]; then
    echo "$updates_arch : $updates_aur"
else
    echo ""
fi
