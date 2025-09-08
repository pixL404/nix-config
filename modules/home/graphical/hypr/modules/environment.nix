{ ... }:
[
  "HYPRCURSOR_THEME,McMojave"
  "HYPRCURSOR_SIZE,32"
  "XCURSOR_SIZE,32"
  "XCURSOR_THEME,McMojave"
  # "GTK_THEME,Catppuccin-Frappe-Standard-Lavender-Dark"

  "WLR_DRM_NO_ATOMIC,1" # allow tearing

  "GDK_BACKEND,wayland,x11,*"
  "QT_QPA_PLATFORM,wayland;xcb"
  "SDL_VIDEODRIVER,wayland" # disable if games give error
  "CLUTTER_BACKEND,wayland"

  "XDG_CURRENT_DESKTOP,Hyprland"
  "XDG_SESSION_TYPE,wayland"
  "XDG_SESSION_DESKTOP,Hyprland"

  "QT_AUTO_SCREEN_SCALE_FACTOR,1"
  "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
]
