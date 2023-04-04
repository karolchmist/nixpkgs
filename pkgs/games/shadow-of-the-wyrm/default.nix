{ lib,fetchFromGitHub, stdenv, premake4, boost, xercesc, zlib, ncurses, lua5_1, SDL2, SDL2_image, gtest }:

stdenv.mkDerivation {
  name = "shadow-of-the-wyrm";
  version = "1.4.7";
  src = /home/karol/workspace/open-source/shadow-of-the-wyrm;
  buildInputs = [
    premake4
    boost
#    gtest
    xercesc
    zlib
    ncurses
    lua5_1
    SDL2
    SDL2_image
  ];
  NIX_CFLAGS_COMPILE = [
    "-I${SDL2.dev}/include/SDL2"
  ];

  enableParallelBuilding = true;

  buildPhase = ''
    premake4 gmake

    make config=debug -j $NIX_BUILD_CORES
  '';

#  separateDebugInfo = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    pwd
    ls -al
    mkdir -p $out
    cp -R * $out

    runHook postInstall
  '';

  fixupPhase = ''
      runHook preFixup

      sed -i "s@=data/@=$out/data/@" $out/swyrm.ini
      sed -i "s@log_dir=@log_dir=/var/sotw@" $out/swyrm.ini
      sed -i "s@syschardump_dir==@syschardump_dir==/var/sotw@" $out/swyrm.ini

      runHook postFixup
    '';

}