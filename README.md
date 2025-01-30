# Dotfiles

Collection of my dotfiles

## Setup

```shell
# 1. Clone it
git clone https://github.com/Mon4ik/dotfiles.git
cd dotfiles

# 2. Link all directories
chmod +x ./create-links.py

./create-links.py links-xdg.manifest # for Linux distros with ~/.config/<...>
# ./create-links.py links-mac.manifest # for Mac (WIP) 
```
