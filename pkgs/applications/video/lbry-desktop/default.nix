{ lib, stdenv, fetchFromGitHub, electron, mkYarnPackage}:

let
  executableName = "lbry-desktop";
  version = "0.45.2";
  src = fetchFromGitHub {
    owner = "lbryio";
    repo = "lbry-desktop";
    rev = "v${version}";
    sha256 = "13sllyk3n67y5cp5rwqsh6l6hi60kfb2xiwp0pl4s0p76nmzjiq1";
  };
in mkYarnPackage rec {
  name = executableName;
  inherit version src;
 
  installPhase = ''
    ls -Ral
    
  '';

  meta = with lib; {
    description = "The most complete, free, teleprompter app on the web";
    license = [ licenses.gpl3 ];
    homepage = "https://github.com/lbryio/lbry-desktop";
    platforms = platforms.linux;
    maintainers = with maintainers; [ Scriptkiddi ];
  };
}

