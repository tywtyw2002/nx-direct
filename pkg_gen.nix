{ nixpkgs
, allSystems
, writeText
, ...
}:
let
  inherit (nixpkgs) lib;
  wantedPackages = builtins.fromTOML (builtins.readFile ./build.toml);
  makeBootstrap = pkg_name:
    lib.strings.concatStringsSep "\n" (lib.forEach allSystems (
      system:
      let
        package = nixpkgs.legacyPackages.${system}.${pkg_name};
      in
      # writeTextDir "out/${pkg_name}.nix"
      ''
        "${system}" = (mkFakeDerivation {
          name = "${package.name}";
          pname = "${package.pname}";
          system = "${system}";
        } {
          out = "${package.out}";
        }).out;
      ''
    ));
  pkgConfig = builtins.mapAttrs (k: v: makeBootstrap k) wantedPackages;
in
  writeText "pkgs.json" (builtins.toJSON pkgConfig)