#!/bin/bash

print_box() {
	local text="$1"
	local length=${#text}
	local width=$((length + 4))

	local line=""
	for ((i = 0; i < width; i++)); do
		line="${line}#"
	done

	echo
	echo "$line"
	echo "# $text #"
	echo "$line"
}

print_box "set ZSH"
# SET ZSH AS DEFAULT

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s $(which zsh)

print_box "Set config links"
# ZSHENV
ZSHENV=~/.zshenv
if [ -f "$ZSHENV" ]; then
	echo "Link exists  $ZSHENV"
else
	ln -s ~/.config/zsh/.zshenv $ZSHENV
	echo "Link created $ZSHENV"
fi

# XINITRC
XINITRC=~/.xinitrc
if [ -f "$XINITRC" ]; then
	echo "Link exists  $XINITRC"
else
	ln -s ~/.config/x/xinitrc $XINITRC
	chmod +x $XINITRC
	echo "Link created $XINITRC"
fi

# XRESOURCES
XRESOURCES=~/.Xresources
if [ -f "$XRESOURCES" ]; then
	echo "Link exists  $XRESOURCES"
else
	ln -s ~/.config/x/Xresources $XRESOURCES
	echo "Link created $XRESOURCES"
fi

# XBINDKEYSRC
XBINDKEYSRC=~/.xbindkeysrc
if [ -f "$XBINDKEYSRC" ]; then
	echo "Link exists  $XBINDKEYSRC"
else
	ln -s ~/.config/x/xbindkeysrc $XBINDKEYSRC
	echo "Link created $XBINDKEYSRC"
fi

# KEYBOARD LAYOUT
XKEYBOARD=/etc/X11/xorg.conf.d/00-keyboard.conf
if [ -f "$XKEYBOARD" ]; then
	echo "Link exists  $XKEYBOARD"
else
	sudo ln -s ~/.config/x/00-keyboard.conf $XKEYBOARD
	echo "Link created $XKEYBOARD"
fi

# CDMRC
CDMRC=~/.cdmrc
if [ -f "$CDMRC" ]; then
	echo "Link exists  $CDMRC"
else
	ln -s ~/.config/cdm/cdmrc $CDMRC
	echo "Link created $CDMRC"
fi

# YAY
print_box "Installing Yay"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..

# ASDF VM
print_box "ASDF-VM"
yay -S --needed asdf-vm

asdf plugin add duckdb https://github.com/asdf-community/asdf-duckdb.git
asdf install duckdb latest
asdf global duckdb latest

asdf plugin add go https://github.com/kennyp/asdf-golang.git
asdf install go latest
asdf global go latest

asdf plugin add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf install kubectl latest
asdf global kubectl latest

asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git
asdf install lua latest
asdf global lua latest

asdf plugin add neovim https://github.com/richin13/asdf-neovim.git
asdf install neovim nightly
asdf global neovim nightly

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

asdf plugin add pnpm https://github.com/jonathanmorley/asdf-pnpm.git
asdf install pnpm latest
asdf global pnpm latest

asdf plugin add yarn https://github.com/twuni/asdf-yarn.git
asdf install yarn latest
asdf global yarn latest

# Neovim Lazy Sync
print_box "Neovim Lazy Sync"
nvim --headless "+Lazy! sync" +qa

# Install packages
yay -S --needed - <pkglist.txt
