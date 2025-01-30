# Dotfiles

Collection of my dotfiles

## btw

I think the most useful part isn't the dotfiles themselves, but the (`create-links.py`)[./create-links.py] utility:

 - It doesn't have any dependencies (only builtin).
 - Requires only `python3.*` 
 - Has human readable manifests (see `*.manifest`)

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
