# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

#bindkey    "${terminfo[khome]}"    beginning-of-line
#bindkey    "${terminfo[kend]}"     end-of-line

# Default to standard vi bindings, regardless of editor string
bindkey -v

# key bindings
bindkey     "e[1~"                  beginning-of-line
bindkey     "e[4~"                  end-of-line
bindkey     "e[5~"                  beginning-of-history
bindkey     "e[6~"                  end-of-history
bindkey     "e[3~"                  delete-char
bindkey     "e[2~"                  quoted-insert
bindkey     "e[5C"                  forward-word
bindkey     "e[5D"                  backward-word
bindkey     "ee[C"                  forward-word
bindkey     "ee[D"                  backward-word
#bindkey    "eOc"                   emacs-forward-word
#bindkey    "eOd"                   emacs-backward-word

bindkey     "^H"                    backward-delete-word
bindkey     "^K"                    kill-whole-line                         # ctrl-k
bindkey     "^R"                    history-incremental-search-backward     # ctrl-r
bindkey     "^A"                    beginning-of-line                       # ctrl-a
bindkey     "^E"                    end-of-line                             # ctrl-e
bindkey     "^D"                    delete-char                             # ctrl-d
bindkey     "^F"                    forward-char                            # ctrl-f
bindkey     "^B"                    backward-char                           # ctrl-b
bindkey     "^I"                    expand-or-complete-prefix               # ctrl-i: Completion in the middle of a line
bindkey     "^R"                    history-incremental-search-backward     # ctrl-r: Search backward incrementally for a specified string.
                                                                            # The string may begin with ^ to anchor the search to the beginning of the line.

bindkey     "[B"                    history-search-forward                  # down arrow
bindkey     "[A"                    history-search-backward                 # up arrow

bindkey     " "                     magic-space                             # [Space] - do history expansion

bindkey     "^[[1;5C"               forward-word                            # [Ctrl-RightArrow] - move forward one word
bindkey     "^[[1;5D"               backward-word                           # [Ctrl-LeftArrow] - move backward one word

bindkey     "\ew"                   kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s  "\el" "ls\n"                                                    # [Esc-l] - run command: ls

bindkey '^?' backward-delete-char                                           # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey   "${terminfo[kdch1]}"    delete-char                             # [Delete] - delete forward
else
  bindkey   "^[[3~"                 delete-char
  bindkey   "^[3;5~"                delete-char
  bindkey   "\e[3~"                 delete-char
fi

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey   "${terminfo[khome]}"    beginning-of-line                       # [Home] - Go to beginning of line
fi

if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey   "${terminfo[kend]}"     end-of-line                             # [End] - Go to end of line
fi

if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey   "${terminfo[kpp]}"      up-line-or-history                      # [PageUp] - Up a line of history
fi

if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey   "${terminfo[knp]}"      down-line-or-history                    # [PageDown] - Down a line of history
fi

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey   "${terminfo[kcbt]}"     reverse-menu-complete                   # [Shift-Tab] - move through the completion menu backwards
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi
