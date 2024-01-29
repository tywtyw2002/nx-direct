
let
    pkgs_name = ["alejandra" "dasel" "jq" "nixpkgs-fmt" "python39"];
    pkgs = builtins.listToAttrs (builtins.map (k: {name = k; value = import ./${k}.nix; }) pkgs_name);
in
pkgs
