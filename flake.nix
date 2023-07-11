{
  description = "NX build service";

  inputs = {
    upstream.url = "github:tywtyw2002/nix-repo/master";
  };

  outputs = { upstream, ... }:
    let
      nixpkgs = upstream.inputs.nixpkgs;
      allSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSystem = allSystems: f: nixpkgs.lib.genAttrs allSystems (system: f system);
      forAllSystems = forEachSystem allSystems;
    in
    {
       packages = forAllSystems (
        system:
          let
            pkg = import nixpkgs {system = system;};
          in
          {
            nx-direct-builder = pkg.callPackage ./pkg_gen.nix { inherit nixpkgs allSystems; };
          }
      );
    };
}