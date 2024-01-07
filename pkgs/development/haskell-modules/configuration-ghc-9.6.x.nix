{ pkgs, haskellLib }:

with haskellLib;

let
  inherit (pkgs) lib;

  jailbreakWhileRevision = rev:
    overrideCabal (old: {
      jailbreak = assert old.revision or "0" == toString rev; true;
    });
  checkAgainAfter = pkg: ver: msg: act:
    if builtins.compareVersions pkg.version ver <= 0 then act
    else
      builtins.throw "Check if '${msg}' was resolved in ${pkg.pname} ${pkg.version} and update or remove this";
  jailbreakForCurrentVersion = p: v: checkAgainAfter p v "bad bounds" (doJailbreak p);

  # Workaround for a ghc-9.6 issue: https://gitlab.haskell.org/ghc/ghc/-/issues/23392
  disableParallelBuilding = overrideCabal (drv: { enableParallelBuilding = false; });
in

self: super: {
  llvmPackages = lib.dontRecurseIntoAttrs self.ghc.llvmPackages;

  # Disable GHC core libraries
  array = null;
  base = null;
  binary = null;
  bytestring = null;
  Cabal = null;
  Cabal-syntax = null;
  containers = null;
  deepseq = null;
  directory = null;
  exceptions = null;
  filepath = null;
  ghc-bignum = null;
  ghc-boot = null;
  ghc-boot-th = null;
  ghc-compact = null;
  ghc-heap = null;
  ghc-prim = null;
  ghci = null;
  haskeline = null;
  hpc = null;
  integer-gmp = null;
  libiserv = null;
  mtl = null;
  parsec = null;
  pretty = null;
  process = null;
  rts = null;
  stm = null;
  system-cxx-std-lib = null;
  template-haskell = null;
  # terminfo is not built if GHC is a cross compiler
  terminfo = if pkgs.stdenv.hostPlatform == pkgs.stdenv.buildPlatform then null else doDistribute self.terminfo_0_4_1_6;
  text = null;
  time = null;
  transformers = null;
  unix = null;
  xhtml = null;

  #
  # Version deviations from Stackage LTS
  #

  # Too strict upper bound on template-haskell
  # https://github.com/mokus0/th-extras/pull/21
  th-extras = doJailbreak super.th-extras;

  #
  # Too strict bounds without upstream fix
  #

  # Forbids transformers >= 0.6
  quickcheck-classes-base = doJailbreak super.quickcheck-classes-base;
  # Forbids mtl >= 2.3
  ChasingBottoms = doJailbreak super.ChasingBottoms;
  # Forbids base >= 4.18
  cabal-install-solver = doJailbreak super.cabal-install-solver;
  cabal-install = doJailbreak super.cabal-install;

  # Forbids base >= 4.18, fix proposed: https://github.com/sjakobi/newtype-generics/pull/25
  newtype-generics = jailbreakForCurrentVersion super.newtype-generics "0.6.2";

  #
  # Too strict bounds, waiting on Hackage release in nixpkgs
  #

  #
  # Compilation failure workarounds
  #

  # Add support for time 1.10
  # https://github.com/vincenthz/hs-hourglass/pull/56
  hourglass = appendPatches [
      (pkgs.fetchpatch {
        name = "hourglass-pr-56.patch";
        url =
          "https://github.com/vincenthz/hs-hourglass/commit/cfc2a4b01f9993b1b51432f0a95fa6730d9a558a.patch";
        sha256 = "sha256-gntZf7RkaR4qzrhjrXSC69jE44SknPDBmfs4z9rVa5Q=";
      })
    ] (super.hourglass);


  # Test suite doesn't compile with base-4.18 / GHC 9.6
  # https://github.com/dreixel/syb/issues/40
  syb = dontCheck super.syb;

  # Patch 0.17.1 for support of mtl-2.3
  xmonad-contrib = appendPatch
    (pkgs.fetchpatch {
      name = "xmonad-contrib-mtl-2.3.patch";
      url = "https://github.com/xmonad/xmonad-contrib/commit/8cb789af39e93edb07f1eee39c87908e0d7c5ee5.patch";
      sha256 = "sha256-ehCvVy0N2Udii/0K79dsRSBP7/i84yMoeyupvO8WQz4=";
    })
    (doJailbreak super.xmonad-contrib);

  # Patch 0.12.0.1 for support of unix-2.8.0.0
  arbtt = appendPatch
    (pkgs.fetchpatch {
      name = "arbtt-unix-2.8.0.0.patch";
      url = "https://github.com/nomeata/arbtt/pull/168/commits/ddaac94395ac50e3d3cd34c133dda4a8e5a3fd6c.patch";
      sha256 = "sha256-5Gmz23f4M+NfgduA5O+9RaPmnneAB/lAlge8MrFpJYs=";
    })
    super.arbtt;

  # Jailbreaks for servant <0.20
  servant-lucid = doJailbreak super.servant-lucid;

  lifted-base = dontCheck super.lifted-base;
  hw-fingertree = dontCheck super.hw-fingertree;
  hw-prim = dontCheck (doJailbreak super.hw-prim);
  stm-containers = dontCheck super.stm-containers;
  regex-tdfa = dontCheck super.regex-tdfa;
  hiedb = dontCheck super.hiedb;
  retrie = dontCheck super.retrie;
  # https://github.com/kowainik/relude/issues/436
  relude = dontCheck (doJailbreak super.relude);

  inherit (pkgs.lib.mapAttrs (_: doJailbreak ) super)
    hls-cabal-plugin
    algebraic-graphs
    co-log-core
    lens
    cryptohash-sha1
    cryptohash-md5
    ghc-trace-events
    tasty-hspec
    constraints-extras
    tree-diff
    implicit-hie-cradle
    focus
    hie-compat
    dbus       # template-haskell >=2.18 && <2.20, transformers <0.6, unix <2.8
    gi-cairo-connector          # mtl <2.3
    haskintex                   # text <2
    lens-family-th              # template-haskell <2.19
    ghc-prof                    # base <4.18
    profiteur                   # vector <0.13
    mfsolve                     # mtl <2.3
    cubicbezier                 # mtl <2.3
    dhall                       # template-haskell <2.20
    env-guard                   # doctest <0.21
    package-version             # doctest <0.21, tasty-hedgehog <1.4
  ;

  # Avoid triggering an issue in ghc-9.6.2
  gi-gtk = disableParallelBuilding super.gi-gtk;

  # Pending text-2.0 support https://github.com/gtk2hs/gtk2hs/issues/327
  gtk = doJailbreak super.gtk;

  # Doctest comments have bogus imports.
  bsb-http-chunked = dontCheck super.bsb-http-chunked;

  # Fix ghc-9.6.x build errors.
  libmpd = appendPatch
    # https://github.com/vimus/libmpd-haskell/pull/138
    (pkgs.fetchpatch { url = "https://github.com/vimus/libmpd-haskell/compare/95d3b3bab5858d6d1f0e079d0ab7c2d182336acb...5737096a339edc265a663f51ad9d29baee262694.patch";
                       name = "vimus-libmpd-haskell-pull-138.patch";
                       sha256 = "sha256-CvvylXyRmoCoRJP2MzRwL0SBbrEzDGqAjXS+4LsLutQ=";
                     })
    super.libmpd;

  # Apply patch from PR with mtl-2.3 fix.
  ConfigFile = overrideCabal (drv: {
    editedCabalFile = null;
    buildDepends = drv.buildDepends or [] ++ [ self.HUnit ];
    patches = [(pkgs.fetchpatch {
      # https://github.com/jgoerzen/configfile/pull/12
      name = "ConfigFile-pr-12.patch";
      url = "https://github.com/jgoerzen/configfile/compare/d0a2e654be0b73eadbf2a50661d00574ad7b6f87...83ee30b43f74d2b6781269072cf5ed0f0e00012f.patch";
      sha256 = "sha256-b7u9GiIAd2xpOrM0MfILHNb6Nt7070lNRIadn2l3DfQ=";
    })];
  }) super.ConfigFile;

  # The NCG backend for aarch64 generates invalid jumps in some situations,
  # the workaround on 9.6 is to revert to the LLVM backend (which is used
  # for these sorts of situations even on 9.2 and 9.4).
  # https://gitlab.haskell.org/ghc/ghc/-/issues/23746#note_525318
  tls = if pkgs.stdenv.hostPlatform.isAarch64 then self.forceLlvmCodegenBackend super.tls else super.tls;
}
