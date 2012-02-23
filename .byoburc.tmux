unbind-key -n F2

set -g prefix C-a
bind-key C-a last-window

set-window-option -g mode-keys vi
bind C-h select-pane -L
bind c-j select-pane -D
bind C-k select-pane -U
bind C-l select-pane -R

# Sane scrolling
#set -g mode-mouse on
