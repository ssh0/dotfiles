# vim: set ft=zsh

# Reload Configurations
#------------------------------------------------------------------------------

rld-xdefaults() { xrdb ~/.Xdefaults ;}
rld-xmodmap() { xmodmap ~/.Xmodmap ;}
rld-xresources() { xrdb -load ~/.Xresources ;}
rld-zshrc() { exec zsh -l ;}

