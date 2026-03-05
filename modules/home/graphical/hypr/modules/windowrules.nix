{ ... }:
[
  "match:class ^(lxqt-policykit-agent), float on"
  "match:title ^(MainPicker)$, float on"

  # no longer works: https://stackoverflow.com/a/77412823
  # fake fullscreen for vs-code to hide custom bar
  # "fullscreenstate, -1, 2, class:^(code-url-handler)$"

  # float file and folder dialog
  "match:title ((o|O)pen ((f|F)ile|(f|F)older)), float on"
  "match:title ((s|S)ave ((f|F)ile|(f|F)older)), float on"

  # steam friends list floating
  "match:title Friends List, float on"

  # remove tearing, leads to stutters
  # # allow tearing
  # "immediate, class:^(cs2)$"
  # "fullscreen, class:^(cs2)$"
  # "immediate, class:^(Minecraft)"
  # "immediate, title:^(TEKKEN)"

  # atuostart applications
  "match:class ^((V|v)ivaldi-stable)$, workspace 3 silent"
  "match:class ^(vesktop)$, workspace 3 silent"
  "match:title ^(Steam)$, workspace 2 silent"

  # hide window controls in vscode (equivalent to deprecated option fakefullscreen)
  "match:class ^(code)$, fullscreen_state 0 2"
]
