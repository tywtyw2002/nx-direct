{ nixpkgs
, allSystems
, writeText
, # , writeTextFile
  # , bash
  # , stdenvNoCC
  # , ...
}:
let
  inherit (nixpkgs) lib;
  wantedPackages = builtins.fromTOML (builtins.readFile ./build.toml);
  makeBootstrap = pkg_name: (lib.attrsets.genAttrs allSystems (
    system:
    let
      package = (import nixpkgs { system = system; }).${pkg_name};
    in
    {
      name = package.name;
      pname = package.pname;
      out = package.out;
    }
  ));
  pkgConfig = builtins.mapAttrs (k: v: makeBootstrap k) wantedPackages;
  jsonContent = builtins.toJSON {
    packages = pkgConfig;
    systems = allSystems;
  };
in
jsonContent
