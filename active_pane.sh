#!/usr/bin/env bash

function pwdx {
  lsof -a -d cwd -p $1 -n -Fn | awk '/^n/ {print substr($0,2)}'
}


active_pane_pid=$(tmux list-panes -F '#{pane_active} #{pane_pid}' | grep -o '^1[[:space:]][0-9]\+$' | grep -o '\w[0-9]\+')
active_wd=$(pwdx "$active_pane_pid")


#watch -tcn 2 'tree -LC 2 $current_wd'

while true
do
active_pane_pid=$(tmux list-panes -F '#{pane_active} #{pane_pid}' | grep -o '^1[[:space:]][0-9]\+$' | grep -o '\w[0-9]\+')
active_wd=$(pwdx $active_pane_pid)
watch -tcn 2 'tree -LC 2 $active_wd'
done
