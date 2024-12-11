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
      phys = "usb-0000:13:00.4-2.2/input0";
      remap = [
        # right + left = middle
        {
          input = [
            "BTN_RIGHT"
            "BTN_LEFT"
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