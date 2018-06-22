{ pkgs ? import <nixpkgs> {} }: with pkgs;
let
  clever-tools = fetchFromGitHub {
                   owner  = "hussein-aitlahcen"; # assume fretlink
                   repo   = "clever-tools-nix";
                   rev    = "9ebdf0e178cb40d1edae8689fa0aaab481edbd3e";
                   sha256 = "0kyydkb4vm5jc0q5sv8y0bmi032prillm70cza8b8vk3c2pfpqcv";
                 };
in (import clever-tools {}).v0_9_3
