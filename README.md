# myConfigFile
##vimrc
1. cp myConfigFile/vimrc ~/.vimrc
2. Install [Vundle](https://github.com/VundleVim/Vundle.vim)
  * git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  * vim +PluginInstall +qall
3. Set ROOT for [scynastic](https://github.com/scrooloose/syntastic)
  * root-config --incdir
  * let g:syntastic_cpp_include_dirs = ['YourPathTo/root/include']
4. Set backgrond color scheme by [salorized](https://github.com/altercation/vim-colors-solarized)
  * set background=dark( or light)
