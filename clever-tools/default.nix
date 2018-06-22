{ stdenv, fetchurl, glibc, nodegit }:

stdenv.mkDerivation rec {
  name    = "clever-tools-${version}";
  version = "0.10.1";

  src = fetchurl {
    url    = "https://clever-tools.cellar.services.clever-cloud.com/releases/${version}/clever-tools-${version}_linux.tar.gz";
    sha256 = "0654d178d7z90vqz0lvrcmhh1sn64xp8iyfifriij6plqf77lbik";
  };

  buildInputs = [ nodegit ];

  libPath = stdenv.lib.makeLibraryPath [ stdenv.cc.cc glibc ];

  nodegitLibrary = stdenv.lib.makeLibraryPath [ nodegit ];

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  dontStrip = "true";

  installPhase = ''
    tar --extract --file=$src clever
    bin=$out/bin/clever
    mkdir -p $out/bin
    mv clever $bin
    ln -s "$nodegitLibrary/nodegit.node" "$out/bin/nodegit.node"
  '';

  preFixup = ''
    bin=$out/bin/clever
    patchelf \
      --set-rpath "$libPath" \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      "$bin"
  '';
}
