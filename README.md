# My dotfiles and terminal customizations
My dotfiles with the aim to keep things simple with minimal configuration.

## Terminal theme
I use a One Dark colorscheme across Gnome Terminal, tmux and lvim. 

<div style="display:flex;">
  <img src="https://github.com/juicy-g/dotfiles/blob/main/screenshots/Screenshot_1.png?raw=true" alt="Screenshot of LunarVim with One Dark colorscheme" width="48%"/>
  <img src="https://github.com/juicy-g/dotfiles/blob/main/screenshots/Screenshot_2.png?raw=true" alt="Screenshot of Teminal with One Dark colorscheme" width="48%"/>
</div>

To replicate do the following:

1. Set the terminal color palette. See [denysdovhan/one-gnome-terminal](https://github.com/denysdovhan/one-gnome-terminal).
    ```bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"
    ```
    You may need to close the terminal manually.

2. Set the LunarVim colorscheme in `~/.config/lvim/config.lua` and save the file.
    ```lua
    lvim.colorscheme = "onedark"
    ...
    lvim.plugins = {
      {"navarasu/onedark.nvim"},
    }
    ```
3. Install the tmuxline plugin and save the config file again. See [edkolev/tmuxline.vim](https://github.com/edkolev/tmuxline.vim)
    ```lua
    lvim.plugins = {
      {"navarasu/onedark.nvim"},
      {"edkolev/tmuxline.vim"},
    }
    ```
    I prefer to remove the powerline separators. To do so add this line to the config file:
    ```lua
    vim.cmd("let g:tmuxline_powerline_separators = 0")
    ```
    You can change the style of the tmux status line by this command in LunarVim:
    ```vim
    :Tmuxline vim_statusline_3
    ```
    While in LunarVim, take a snapshot of tmuxline:
    ```vim
    :TmuxlineSnapshot ~/.tmuxline.conf
    ```
    Finally, in `.tmux.conf` source `.tmuxline.conf`:
    ```bash
    source-file .tmuxline.conf
    ```
