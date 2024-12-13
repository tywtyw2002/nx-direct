
let
    pkgs_name = ["alejandra" "dasel" "jq" "nixpkgs-fmt" "python311" "python39"];
    pkgs = builtins.listToAttrs (builtins.map (k: {name = k; value = import ./${k}.nix; }) pkgs_name);
in
pkgs
