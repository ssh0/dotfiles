# vim: set ft=zsh

# Reload Configurations
#------------------------------------------------------------------------------

rl-xdefaults() { xrdb ~/.Xdefaults ;}
rl-xmodmap() { xmodmap ~/.Xmodmap ;}
rl-xresources() { xrdb -load ~/.Xresources ;}
rl-zshrc() { exec zsh -l ;}

