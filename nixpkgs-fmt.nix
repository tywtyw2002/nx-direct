
{ system ? builtins.currentSystem
}:

let
  mkFakeDerivation = attrs: outputs:
    let
        outputNames = builtins.attrNames outputs;
        common = attrs // outputsSet //
            { type = "derivation";
            outputs = outputNames;
            # TODO: this has name/value pairs
            all = outputsList;
            };
        outputToAttrListElement = outputName:
            { name = outputName;
              value = common // {
                inherit outputName;
                outPath = builtins.storePath (builtins.getAttr outputName outputs);
                # TODO: we lie here so that Nix won't build it
                drvPath = builtins.storePath (builtins.getAttr outputName outputs);
              };
            };
        outputsList = map outputToAttrListElement outputNames;
        outputsSet = builtins.listToAttrs outputsList;
    in outputsSet;
in
{

    "x86_64-linux" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "x86_64-linux";
    } {
      out = "/nix/store/gc7v0h6bc8whfkszgnkm6qhaglcbwih8-nixpkgs-fmt-1.3.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "aarch64-linux";
    } {
      out = "/nix/store/4z2917l6b59fs81z98grn7h9h10la4bc-nixpkgs-fmt-1.3.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/mmfijswyz3cvpr8b2xg50qjvcf2d7ipp-nixpkgs-fmt-1.3.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/pl4vh1f3wwk3snk5bx963rsza6dcgd8d-nixpkgs-fmt-1.3.0";
    }).out;
}.${system}