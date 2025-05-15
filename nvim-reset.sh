#!/bin/bash
# Reset NeoVim and reload plugins

echo "Resetting NeoVim plugins..."
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
echo "Done. Restart NeoVim to reinstall plugins."
