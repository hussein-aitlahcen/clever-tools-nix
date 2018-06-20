{ stdenv, fetchurl, curl, glibc, openssl }:

assert stdenv.system == "x86_64-linux";

stdenv.mkDerivation rec {
  name = "nodegit-${version}";
  version = "0.20.3";

  src = fetchurl {
    url = "https://nodegit.s3.amazonaws.com/nodegit/nodegit/nodegit-v${version}-node-v51-linux-x64.tar.gz";
    sha256 = "d022a88e58fa70f78b59b475fa6ecc6724d372a779b132264cf571f71bc50020";
  };

  libPath = stdenv.lib.makeLibraryPath [
              stdenv.cc.cc
              (curl.override {
                  sslSupport = false;
                  gnutlsSupport = true;
              })
              glibc
              openssl
            ];

  installPhase = ''
    tar --extract --file=$src Release/nodegit.node --transform 's/Release\//linux-/'
    lib=$out/lib/nodegit.node
    mkdir -p $out/lib
    mv linux-nodegit.node $lib
  '';

  preFixup = ''
    lib=$out/lib/nodegit.node
    patchelf --set-rpath "$libPath" "$lib"
  '';
}
