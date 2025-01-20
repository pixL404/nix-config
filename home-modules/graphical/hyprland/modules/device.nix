{ keyboard, ... }:
[
  {
    name = "logitech-mx-master-2s-1";
    accel_profile = "flat";

    sensitivity = -0.75;
  }

  {
    name = "logitech-mx-master-2s-mouse";
    accel_profile = "flat";

    sensitivity = -0.75;
  }

  # this is unnecessary - evremap changes the name to something dynamic
  # {
  #   name = "kensington-slimblade-pro(2.4ghz-receiver)-kensington-slimblade-pro-trackball(2.4ghz-receiver)";
  #   accel_profile = "adaptive";
  #   sensitivity = -0.9;
  # }

  {
    name = keyboard;
    kb_layout = "us";
    kb_options = "caps:escape,compose:menu";
  }

]
