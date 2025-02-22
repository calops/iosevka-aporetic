{
  pname,
  version,
  mkDerivation,
  fetchurl,
  unzip,
}:
mkDerivation {
  inherit pname version;
  name = "${pname}-prebuilt-v${version}";

  src = fetchurl {
    # FIXME:
    url = "https://github.com/calops/iosevka-aporetic/releases/download/v${version}/aporetic-sans.zip";
    hash = "sha256-gaNbLmuO0sIs54bwnI6Jp9BeV5/S/IJvSAJCm2ruKIY=";
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
