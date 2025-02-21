{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "systems";

    iosevka-upstream = {
      url = "github:be5invis/Iosevka";
      flake = false;
    };
  };

  outputs =
    inputs@{
      iosevka-upstream,
      flake-parts,
      systems,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      perSystem =
        { pkgs, ... }:
        {
          packages = rec {
            aporetic-sans = pkgs.callPackage ./base.nix {
              pname = "aporetic-sans";
              upstream = iosevka-upstream;
            };

            aporetic-sans-prebuilt = pkgs.callPackage ./prebuilt.nix {
              pname = "aporetic-sans-prebuilt";
              version = aporetic-sans.version;
              mkDerivation = pkgs.stdenv.mkDerivation;
            };

            default = aporetic-sans;
          };
        };
    };
}
