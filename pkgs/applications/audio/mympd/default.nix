{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, libmpdclient
, openssl
, lua5_3
, libid3tag
, flac
, pcre2
, gzip
, perl
, jq
}:

stdenv.mkDerivation rec {
  pname = "mympd";
  version = "10.3.0";

  src = fetchFromGitHub {
    owner = "jcorporation";
    repo = "myMPD";
    rev = "v${version}";
    sha256 = "sha256-iO/Ogh3G67GYoputrxAiA1i0fAon2NDrgPCMYxxn/o4=";
  };

  nativeBuildInputs = [
    pkg-config
    cmake
    gzip
    perl
    jq
  ];
  preConfigure = ''
    env MYMPD_BUILDDIR=$PWD/build ./build.sh createassets
  '';
  buildInputs = [
    libmpdclient
    openssl
    lua5_3
    libid3tag
    flac
    pcre2
  ];

  cmakeFlags = [
    "-DENABLE_LUA=ON"
    # Otherwise, it tries to parse $out/etc/mympd.conf on startup.
    "-DCMAKE_INSTALL_SYSCONFDIR=/etc"
    # similarly here
    "-DCMAKE_INSTALL_LOCALSTATEDIR=/var/lib/mympd"
  ];
  # See https://github.com/jcorporation/myMPD/issues/315
  hardeningDisable = [ "strictoverflow" ];

  meta = {
    homepage = "https://jcorporation.github.io/myMPD";
    description = "A standalone and mobile friendly web mpd client with a tiny footprint and advanced features";
    maintainers = [ lib.maintainers.doronbehar ];
    platforms = lib.platforms.linux;
    license = lib.licenses.gpl2Plus;
  };
}
