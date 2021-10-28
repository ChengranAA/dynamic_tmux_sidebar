#!/usr/bin/env zsh

function pwdx {
  lsof -a -d cwd -p $1 -n -Fn | awk '/^n/ {print substr($0,2)}'
}

function tree_active_pane () {
  # get the active pane's pid and wd
  active_pane_pid=$(tmux list-panes -F '#{pane_active} #{pane_pid}' | grep -o '^1[[:space:]][0-9]\+$' | grep -o '\w[0-9]\+')
  active_wd=$(pwdx $active_pane_pid)
  # 2 layer tree view of file with color
  tree -LC 2 $active_wd
}

export -f pwdx
export -f tree_active_pane

function sidebar() {

  watch -tcn 1 tree_active_pane
}
