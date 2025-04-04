with import <nixpkgs> {};

mkShell {
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    stdenv.cc.cc
    zlib
  ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
  buildInputs = [ python311 ];
  shellHook = ''
    export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
  '';
}

#  Note that this requires at least programs.nix-ld.enable = true; somewhere in your Nix config to work
# source; https://github.com/mcdonc/.nixconfig/blob/master/videos/pydev/script.rst
