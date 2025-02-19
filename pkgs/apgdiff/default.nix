{ lib, stdenv, fetchurl, makeWrapper, jre }:
let
  version = "2.7.0";
in
stdenv.mkDerivation {
  inherit version;
  pname = "apgdiff";

  src = fetchurl {
    url =
      "https://github.com/fordfrog/apgdiff/raw/release_${version}/releases/apgdiff-${version}.jar";
    sha256 = "sha256-6OempDmedl6LOwP/s5y0hOIxGDWHd7qM7/opW3UwQ+I=";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    install -Dm644 $src $out/lib/apgdiff.jar

    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/apgdiff \
      --argv0 apgdiff \
      --add-flags "-jar $out/lib/apgdiff.jar"
  '';

  meta = with lib; {
    description = "Another PostgreSQL diff tool";
    homepage = "https://apgdiff.com";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
