''
  # will start a submap called "resize"
  submap= resize

  # sets repeatable binds for resizing the active window
  binde = , right, resizeactive, 10 0
  binde = , left, resizeactive, -10 0
  binde = , up, resizeactive, 0 -10
  binde = , down, resizeactive, 0 10

  # use reset to go back to the global submap
  bind = , escape, submap, reset 

  # will reset the submap, meaning end the current one and return to the global one
  submap = reset
''