{
  ...
}:
[
  "float, class:^(lxqt-policykit-agent)"
  "float, title:^(MainPicker)$"

  # no longer works: https://stackoverflow.com/a/77412823
  # fake fullscreen for vs-code to hide custom bar
  # "fullscreenstate, -1, 2, class:^(code-url-handler)$"

  # float file and folder dialog
  "float, title:((o|O)pen ((f|F)ile|(f|F)older))"
  "float, title:((s|S)ave ((f|F)ile|(f|F)older))"

  # steam friends list floating
  "float, title:Friends List"

  # remove tearing, leads to stutters
  # # allow tearing
  # "immediate, class:^(cs2)$"
  # "fullscreen, class:^(cs2)$"
  # "immediate, class:^(Minecraft)"
  # "immediate, title:^(TEKKEN)"

  # atuostart applications
  "workspace 3 silent, class:^(vivaldi-stable)$"
  "workspace 3 silent, class:^(vesktop)$"
  "workspace 2 silent, title:^(Steam)$"
]