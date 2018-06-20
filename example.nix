with import <nixpkgs> {};

let clever-tools = fetchFromGitHub
                   { owner  = "hussein-aitlahcen";
                     repo   = "clever-tools-nix";
                     rev    = "ee8c462a076680204c37cedd2fbdf7e6abbc9a24";
                     sha256 = "0f58gfzl8kv2dwb6yw246fyjscn9dpkcbayf5cbnc2zrphyvb9jc";
                   };
in import clever-tools
