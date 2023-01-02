{ lib,fetchFromGitHub, stdenv, premake4, boost, xercesc, zlib, ncurses, lua5_1, SDL2, SDL2_image, SDL2_ttf, SDL2_mixer }:

stdenv.mkDerivation {
  name = "shadow-of-the-wyrm";
  version = "1.4.5";
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
    SDL2_ttf
    SDL2_mixer
  ];
  NIX_CFLAGS_COMPILE = [
    "-I${SDL2}/include/SDL2"
  ];
#-I ${SDL2}/include
#    nativeBuildInputs = [pkg-config ];
  buildPhase = ''
    premake4 gmake
    make config=release -j $NIX_BUILD_CORES -I ${SDL2}/include
  '';

  installPhase = ''
    mkdir -p $out/sotw
    cp -R sotw/* $out/sotw
  '';
}