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
        { pkgs, lib, ... }:
        let
          version = "1.1.0";
          fonts = [
            "aporetic-sans"
            "aporetic-sans-mono"
          ];

          mkPackage =
            pname:
            builtins.nameValuePair pname (
              pkgs.callPackage ./base.nix {
                inherit pname version;
                upstream = iosevka-upstream;
              }
            );

          mkPrebuiltPackage =
            pname:
            builtins.nameValuePair "${pname}-prebuilt" pkgs.callPackage ./prebuilt.nix {
              inherit pname version;
              mkDerivation = pkgs.stdenv.mkDerivation;
            };

          packages = builtins.lsitToAttrs (builtins.map mkPackage fonts);
          prebuiltPackages = lib.mkMerge (builtins.map mkPrebuiltPackage fonts);

          finalPackages = lib.mkMerge [
            packages
            prebuiltPackages
            # FIXME:
            # {
            #   all = pkgs.symlinkJoin {
            #     name = "all";
            #     paths = lib.attrValues packages;
            #   };
            # }
          ];
        in
        {
          packages = finalPackages;
        };
    };
}
