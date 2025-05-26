{
  system,
  ...
}:
{
  nixpkgs = {
    hostPlatform = system;
    config.allowUnfree = true;
  };
}
