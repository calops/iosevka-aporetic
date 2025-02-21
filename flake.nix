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
            aporetic-sans = rec {
              base = pkgs.callPackage ./base.nix {
                pname = "aporetic-sans";
                upstream = iosevka-upstream;
              };

              # ready for linux use, though IFD
              default = pkgs.runCommand "aporetic-sans-ttf" { } ''
                dest=$out/share/fonts/truetype
                mkdir -p $dest
                cp -avL ${base}/TTF/*.ttf $dest
              '';
            };

            default = aporetic-sans.base;
          };
        };
    };
}
