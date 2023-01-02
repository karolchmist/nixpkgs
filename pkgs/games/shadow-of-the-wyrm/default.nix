{ lib,fetchFromGitHub, stdenv, premake4, boost, xercesc, zlib, ncurses, lua5_1, SDL2, SDL2_image }:

stdenv.mkDerivation {
  name = "shadow-of-the-wyrm";
  version = "1.4.7";
  src = fetchFromGitHub {
    owner = "prolog";
    repo = "shadow-of-the-wyrm";
    rev = "d91f44921d21d0a176415a9ed3b70ef55dd77138";
    sha256 = "sha256-v00tDCZ2MEszdQYFjg99HxP3in/jLqUuERasSJZ1S38=";
  };
  buildInputs = [
    premake4
    boost
#    googletest
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

    make config=release -j $NIX_BUILD_CORES
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/sotw
    cp -R sotw/* $out/sotw
    runHook postInstall
  '';
}