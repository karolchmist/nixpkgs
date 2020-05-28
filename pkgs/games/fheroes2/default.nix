{ stdenv, fetchFromGitHub, fetchurl,
SDL2, SDL2_image, SDL2_mixer, SDL2_ttf, 
gettext, libpng, unzip, zlib }:

stdenv.mkDerivation rec {
  version = "0.7";
  pname = "fheroes2";

  # src = "/home/karol/workspace/open-source/fheroes2";

  src = fetchFromGitHub {
    owner = "ihhub";
    repo = "fheroes2";
    rev = "${version}";
    sha256 = "1rbm9xxs42qvi0nab1smz5zbw9xqkmxikcgbk2j7b5hkg46ypclp";
  };
  buildInputs = [ gettext SDL2 SDL2_image SDL2_mixer SDL2_ttf 
  libpng zlib ];

  preBuild = ''
    export WITH_SDL2="ON"    
    mkdir -p $out
    ls -R $out
    
    mkdir -p ~/.local/share/fheroes/{data,maps}
    
    ln -s  ~/.local/share/fheroes/data $out/data
    ln -s  ~/.local/share/fheroes/maps $out/maps
  '';
  
  installPhase = ''
    runHook preInstall

    echo src:$src
    
    ls -R /build/source/src/dist

    mkdir -p $out/bin

    install -Dm755  /build/source/src/dist/fheroes2 $out/fheroes2
    install -D  $src/fheroes2.cfg $out/fheroes2.cfg
    install -D  $src/fheroes2.key $out/fheroes2.key
    
    ls -R $out        

    runHook postInstall
  '';


  meta = with stdenv.lib; {
    homepage = "https://github.com/diasurgical/devilutionX";
    description = "Diablo build for modern operating systems";
    longDescription = "In order to play this game a copy of diabdat.mpq is required. Place a copy of diabdat.mpq in ~/.local/share/diasurgical/devilution before executing the game.";
    license = licenses.unlicense;
    maintainers = [ maintainers.karolchmist ];
    platforms = platforms.linux ++ platforms.darwin ++ platforms.windows;
  };
}
