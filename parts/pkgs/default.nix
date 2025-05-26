_: {
  # this equals perSystem.packages but with all .nix files imported recursively
  # https://flake.parts/options/flake-parts#opt-perSystem
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages = lib.packagesFromDirectoryRecursive {
        inherit (pkgs) callPackage;
        directory = ./packages;
      };
    };
}
