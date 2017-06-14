# Notes and Modeline {{
# vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={{,}} foldlevel=9 foldmethod=marker nospell:
# }}

# Position and Format {{
    status                          on
    status-left-length              10
    status-right-length             40
    status-justify                  left
    status-position                 bottom
    status-left                     "[#S] "
    status-right                    " "#{=21:pane_title}" %H:%M %d-%b-%y"
    window-status-separator         ""
# }}

# Colors and Styles {{
    # Colors
    clock-mode-colour               blue
    display-panes-colour            blue
    display-panes-active-colour     red

    # Mode and messages
    mode-style                      fg=black,bg=yellow
    message-style                   fg=black,bg=yellow
    message-command-style           fg=yellow,bg=black

    # Windows
    window-style                    default
    window-active-style             default

    # Panes
    pane-border-style               fg=colour238
    pane-active-border-style        fg=colour154

    # Main status line
    status-style                    fg=black,bg=green
    status-left-style               default
    status-right-style              default

    # Window labels on the status line
    window-status-style             fg=colour121,bg=colour235
    window-status-last-style        default
    window-status-current-style     default
    window-status-bell-style        reverse
    window-status-activity-style    fg=colour154,bg=colour235
}}
