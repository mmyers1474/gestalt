# Window theme settings {{
  set -g window-style default
  set -g window-active-style default

  set -g window-status-style fg=colour121,bg=colour235
  set -g window-status-current-style default
  set -g window-status-last-style default
  set -g window-status-activity-style fg=colour154,bg=colour235
  set -g window-status-bell-style reverse

  set -g window-status-separator ""
  set -g window-status-format "#[fg=colour121,bg=colour235] #I #[fg=colour121,bg=colour235] #W "
  set -g window-status-current-format "#[fg=colour235,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] #I #[fg=colour222,bg=colour238] #W #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]"

  set -g pane-border-style fg=colour238
  set -g pane-active-border-style fg=colour154

  set -g display-panes-colour blue
  set -g display-panes-active-colour red

  set -g mode-style fg=black,bg=yellow
  set -g clock-mode-colour blue
# }}

# Status line theme settings {{
  set -g status on
  set -g status-justify left
  set -g status-position bottom

  set -g status-left-length 100
  set -g status-right-length 100

  set -g status-style fg=black,bg=colour235

  set -g status-left-style default
  set -g status-left "#[fg=colour232,bg=colour154] #S #[fg=colour154,bg=colour235,nobold,nounderscore,noitalics]"

  set -g status-right-style default
  set -g status-right "#[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] %Y-%m-%d  %H:%M #[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour154] #h "

  set -g message-style fg=colour222,bg=colour238
  set -g message-command-style fg=colour222,bg=colour238
# }}
