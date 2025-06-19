# Dotfiles

Collection of my dotfiles

> ![WARNING]
>
> I didn't make Neovim with fancy animations, design, etc. in mind. (because i don't like soy milk)
> 
> Also there's no W*ndows support (If you are using operating system for videogames with spyware/bloatware for coding, I have bad news for you...)

## `create-links.py`

Feel free to copy and use (`create-links.py`)[./create-links.py] utility in your own configs.

It's great, because:

 - It doesn't have any dependencies (all imports are builtin packages).
 - Requires only `python3.*`
 - Has human readable manifests (see `*.manifest`):
   ```
   /path/to/link > destination-relative-to-create-links.py
   /path/to/link2 > destination2
   # there's also comments
   ```

## Setup

1. Clone it
   ```shell
   git clone https://github.com/Mon4ik/dotfiles.git
   cd dotfiles
   ```
2. Link all directories
   ```shell
   chmod +x ./create-links.py
   
   ./create-links.py links-arch.manifest # for Linux (im using arch btw) with hyprland and other stuff 
   ./create-links.py links-mac.manifest # for Mac
   ```
3. Add this line to zsh config *(optional)*
   ```shell
   source $HOME/.dotfiles/.zshrc
   ```
