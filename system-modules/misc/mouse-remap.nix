{
  config,
  pkgs,
  ...
}:
{
  # https://github.com/wez/evremap
  services.evremap = {
    enable = true;
  
    settings = {
      # stupid name
      device_name = "Kensington SlimBlade Pro(2.4GHz Receiver) Kensington SlimBlade Pro Trackball(2.4GHz Receiver)";
      phys = "usb-0000:10:00.0-4.1.2/input0";
      remap = [
        # left + right = middle
        {
          input = [
            "BTN_LEFT"
            "BTN_RIGHT"
          ];
          output = [
            "BTN_MIDDLE"
          ];
        }
        # top left = back
        {
          input = [
            "BTN_MIDDLE"
          ];
          output = [
            "BTN_BACK"
          ];
        }
        # top right = forward
        {
          input = [
            "BTN_SIDE"
          ];
          output = [
            "BTN_FORWARD"
          ];
        }
      ];
    };
  };
}