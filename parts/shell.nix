_: {
  # this equals perSystem.devShells.default but with all .nix files imported recursively
  # https://flake.parts/options/flake-parts#opt-perSystem
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixfmt-rfc-style
          nil
        ];
      };
    };
}
