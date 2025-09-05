# local-env

- Clone this into your home directory
- Create a symlink between your local .zshrc file and the one in this repo `ln -s ~/local-env/.zshrc ~/.zshrc`
- Create a secrets.zshrc in local-env for any secrets you don't want to be committed (its gitignored)
- Any other *.zsh files will be automatically sourced
- Set up Vundle https://github.com/VundleVim/Vundle.vim#quick-start 
- Create a symlink in your local .vimrc file and the one in this repo `ln -s ~/local-env/.vimrc ~/.vimrc`
- Launch vim and run `:PluginInstall`