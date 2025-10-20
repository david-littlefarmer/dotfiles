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

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#chsh -s $(which zsh)

print_box "Set config links"

create_symlink() {
    source_file=$1
    link=$2

    if [ -L $link ]; then
        target=$(readlink -f $link)
        if [ $target != $source_file ]; then
            echo -e "\e[1;31mDifferent link exists\e[0m \e[1;34m$target\e[0m \e[1;33m<-\e[0m \e[1;34m$link\e[0m"
            sudo ln -is $source_file $link
        else
            echo -e "\e[1;32mLink already exists\e[0m \e[1;34m$source_file\e[0m \e[1;33m<-\e[0m \e[1;34m$link\e[0m"
        fi
    elif [ -f $link ]; then
        echo -e "\e[1;31mFile exists\e[0m \e[1;34m$link\e[0m"
        rm -i $link
        ln -s $source_file $link
    elif [ -d $link ]; then
        echo -e "\e[1;31mDirectory already exists\e[0m \e[1;34m$link\e[0m"
        echo -e "Do you want to delete it and replace it with a symbolic link to \e[1;34m$source_file\e[0m? (y/n)"
        read choice
        case $choice in
        y | Y)
            rm -rf $link
            ln -s $source_file $link
            echo -e "\e[1;32mCreated\e[0m \e[1;34m$source_file\e[0m \e[1;33m<-\e[0m \e[1;34m$link\e[0m"
            ;;
        esac
    else
        ln -is $source_file $link
        echo -e "\e[1;32mCreated\e[0m \e[1;34m$source_file\e[0m \e[1;33m<-\e[0m \e[1;34m$link\e[0m"
    fi
}

# Create symbolic links
create_symlink "$PWD/zsh/.zshenv" "$HOME/.zshenv"
create_symlink "$PWD/x/xinitrc" "$HOME/.xinitrc"
create_symlink "$PWD/x/Xresources" "$HOME/.Xresources"
create_symlink "$PWD/x/xbindkeysrc" "$HOME/.xbindkeysrc"
create_symlink "$PWD/cdm/cdmrc" "$HOME/.cdmrc"

create_symlink "$PWD/alacritty" "$HOME/.config/alacritty"
create_symlink "$PWD/bspwm" "$HOME/.config/bspwm"
create_symlink "$PWD/dunst" "$HOME/.config/dunst"
create_symlink "$PWD/picom" "$HOME/.config/picom"
create_symlink "$PWD/ncdu" "$HOME/.config/ncdu"
create_symlink "$PWD/nvim" "$HOME/.config/nvim"
create_symlink "$PWD/polybar" "$HOME/.config/polybar"
create_symlink "$PWD/rofi" "$HOME/.config/rofi"
create_symlink "$PWD/sxhkd" "$HOME/.config/sxhkd"
create_symlink "$PWD/tmux" "$HOME/.config/tmux"
create_symlink "$PWD/zsh" "$HOME/.config/zsh"

# Yay
if ! command -v yay &> /dev/null; then
    print_box "Installing Yay"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd ..
else
    print_box "Yay is already installed."
fi

# ASDF VM
print_box "ASDF-VM"
yay -S --needed asdf-vm

asdf plugin add duckdb https://github.com/asdf-community/asdf-duckdb.git
asdf install duckdb latest
asdf set -u duckdb latest

asdf plugin add go https://github.com/kennyp/asdf-golang.git
asdf install go latest
asdf set -u go latest

asdf plugin add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf install kubectl latest
asdf set -u kubectl latest

asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git
asdf install lua latest
asdf set -u lua latest

asdf plugin add neovim https://github.com/richin13/asdf-neovim.git
asdf install neovim nightly
asdf set -u neovim nightly

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf set -u nodejs latest

asdf plugin add pnpm https://github.com/jonathanmorley/asdf-pnpm.git
asdf install pnpm latest
asdf set -u pnpm latest

asdf plugin add yarn https://github.com/twuni/asdf-yarn.git
asdf install yarn latest
asdf set -u yarn latest

asdf plugin add rust
asdf install rust latest
asdf set -u rust latest

# Neovim Lazy Sync
print_box "Neovim Lazy Sync"
nvim --headless "+Lazy! sync" +qa

# Install packages
yay -S --needed - <pkglist.txt
