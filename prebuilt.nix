{
  pname,
  version,
  mkDerivation,
  fetchurl,
  unzip,
}:
let
  hashes = import ./hashes.nix;
in
mkDerivation {
  inherit pname version;
  name = "${pname}-prebuilt-v${version}";

  src = fetchurl {
    url = "https://github.com/calops/iosevka-aporetic/releases/download/v${version}/${pname}.zip";
    hash = hashes.${pname};
  };

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  doBuild = false;

  installPhase = ''
    dest=$out/share/fonts
    mkdir -p $dest/{truetype,woff2}
    cp -r ./TTF/* $dest/truetype
    cp -r ./WOFF2/* $dest/woff2
  '';
}
