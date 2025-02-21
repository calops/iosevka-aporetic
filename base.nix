{
  pname,
  buildNpmPackage,
  remarshal,
  ttfautohint-nox,
  upstream,
}:
buildNpmPackage rec {
  inherit pname;
  name = pname;
  version = "1.1.0";
  src = upstream;

  npmDepsHash = "sha256-HeqwpZyHLHdMhd/UfXVBonMu+PhStrLCxAMuP/KuTT8=";

  nativeBuildInputs = [
    remarshal
    ttfautohint-nox
  ];

  postPatch = ''
    cp -v ${./private-build-plans.toml} private-build-plans.toml
  '';

  enableParallelBuilding = true;

  buildPhase = ''
    export HOME=$TMPDIR
    runHook preBuild
    npm run build --no-update-notifier --targets contents::${pname} -- --jCmd=$NIX_BUILD_CORES --verbose=9
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -avL dist/${pname}/* $out
    runHook postInstall
  '';
}
