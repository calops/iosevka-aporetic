{
  pname,
  version,
  mkDerivation,
  fetchurl,
  unzip,
}:
mkDerivation {
  inherit pname version;
  name = pname;

  src = fetchurl {
    url = "https://github.com/calops/iosevka-aporetic/releases/download/v${version}/aporetic-sans.zip";
    hash = "sha256-y0Cfc8yUrOYTXRJttJhIh/CA9wPx9FK/QjT5YYuPd+k=";
  };

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  doBuild = false;

  installPhase = ''
    dest=$out/share/fonts/truetype/aporetic-sans
    mkdir -p $dest
    cp -r ./TTF/* $dest
  '';
}
