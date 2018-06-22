{ pkgs ? import <nixpkgs> {} }: with pkgs;
let
  mkOlderVersion = {rev, sha256}:
    let olderVersion = fetchFromGitHub {
          owner  = "hussein-aitlahcen"; # assume fretlink when merged, just for testing now
          repo   = "clever-tools-nix";
          rev    = rev;
          sha256 = sha256;
        };
    in (import olderVersion {}).latest;
in
{
  v0_9_3 = mkOlderVersion {
             rev    = "719156204e8a9569a687ec14ef88660da1eb08f3";
             sha256 = "0a7ylqymx7wi97cd5f4gx7vpn8kk5sfgj35q5ha2y552mirzjlzf";
           };
  latest = callPackage ./clever-tools {
             nodegit = callPackage ./nodegit {};
           };
}
