{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "opendiablo2";
  version = "515b66736d98ffcd2545fbaf77e7ff12770550e0";

  src = fetchFromGitHub {
    owner = "OpenDiablo2";
    repo = "OpenDiablo2";
    rev = "${version}";
    sha256 = "1x9gh42lrrfrfh3hk7pl3y6k47b7yw1ylf0y30zq02a5v3ik0akp";
  };

  #vendorSha256 = "1c16s5xiqr36azh2w90wg14jlw67ca2flbgjijpz7qd0ypxyfqlk";

#  subPackages = [ "." ];

  meta = with lib; {
    description = "OpenDialbo2";
    homepage = "https://github.com/OpenDiablo2/OpenDiablo2";
    license = licenses.mit;
    maintainers = with maintainers; [ ehmry filalex77 ];
  };
}