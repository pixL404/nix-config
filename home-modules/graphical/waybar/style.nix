
{
  colors ? "",
  ...
}:
''
${colors}

* {
  font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: @text;
  margin: 0px;
  padding: 0px;
}

window#waybar {
  background-color: transparent;
  min-height: 0;
  margin-top: 10px;
}

.modules-left,.modules-center,.modules-right {
  background-color: @base;
  padding: 0 1rem;
  margin: 0 1rem;
  border-radius: 2rem;
}

.modules-right > #power,#tray {
  margin: 0 0.25rem;
}
#power label {
  margin: 0;
  padding: 0;
}

.modules-right label {
  margin: 0 0.25rem;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
  background: inherit;
  box-shadow: inset 0 -0.3rem @surface2;
  border: 1px solid @surface2;
  border-radius: 0.75rem;
}

#workspaces button {
  padding: 0 0.5rem;
  background-color: inherit;
  border-radius: 0.75rem;
}

#workspaces button.urgent {
  background-color: @red;
  border-radius: 0.75rem;
}
#workspaces button.urgent label {
  color: @base;
}

#workspaces button.active {
  background-color: @lavender;
  border-radius: 0.75rem;
}
#workspaces button.active label {
  color: @base;
}

#mode {
  /* what is this? */
  background-color: rgb(255,0,0);
  border-bottom: 3px solid #ffffff;
  border-radius: 0.75rem;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#mode,
#idle_inhibitor,
#scratchpad,
#mpd {
  padding: 0 0.5rem;
  color: @text;
  background-color: @base;
  border: 1px solid @surface2;
  border-radius: 0.75rem;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > * {
  margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > * {
  margin-right: 100px;
}

@keyframes blink {
  to {
    background-color: inherit;
    color: inherit;
  }
}

#battery.critical:not(.charging) {
  background-color: @red;
  color: @base;
  animation-name: blink;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#network.disconnected {
  background-color: @surface1;
}

#wireplumber.muted {
  background-color: @surface1;
}


#custom-media {
  background-color: #66cc99;
  color: #2a5c45;
  min-width: 100px;
}

#custom-media.custom-spotify {
  background-color: @green;
  color: @base;
}


#tray {
  padding: 0 0.5rem;
  color: @text;
  background-color: @base;
  border: 1px solid @surface2;
  border-radius: 0.75rem;
  min-width: 0px;
}

#tray > .passive {
  -gtk-icon-effect: dim;
}

#tray > .needs-attention {
  -gtk-icon-effect: highlight;
  background-color: @lavender;
}

#tray menu {
  color: @text;
  background-color: @base;
}


#idle_inhibitor {
  background-color: #2d3436;
}

#idle_inhibitor.activated {
  background-color: #ecf0f1;
  color: #2d3436;
}


#language {
  border: 1px solid @surface2;
  border-radius: 0.75rem;
  color: @text;
  padding: inherit;
  margin: 0px;
  min-width: 2rem; /* 2 character lang code */
}

#scratchpad {
  background: inherit;
  border: 1px solid @surface2;
  border-radius: 0.75rem;
}

#scratchpad.empty {
  background-color: transparent;
  border: none;
  border-radius: 0.75rem;
}

#taskbar {
  padding: 0 0.5rem;
}

#taskbar > * {
  margin: 0 0.2rem;
  padding: 0 0.5rem
}

/* container for power, logoff, hibernate, reboot */
#power {
  border: 1px solid @surface2;
  border-radius: inherit;
  padding: inherit;
}

#custom-power {
  color: @red;
}
#custom-lock {
  color: @teal;
}
#custom-hibernate {
  color: @sky;
}
#custom-reboot {
  color: @green;
}
#custom-quit {
  color: @mauve;
}
''