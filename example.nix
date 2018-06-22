{ pkgs ? import <nixpkgs> {} }: with pkgs;
let
  clever-tools = fetchFromGitHub {
                   owner  = "hussein-aitlahcen"; # assume fretlink
                   repo   = "clever-tools-nix";
                   rev    = "f4b7fca8a69144b6415f11c9218730d12ad9a542";
                   sha256 = "091k5srdl7f51c4xah2cvjq7wisml0bmzs8ychnk7g5hlc687s9m";
                 };
in (import clever-tools {}).latest
