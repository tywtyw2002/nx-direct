
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
      out = "/nix/store/wrzvs3sw2g2l2m4483n2hgmb3vp686bv-nixpkgs-fmt-1.3.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "aarch64-linux";
    } {
      out = "/nix/store/765w3mfckpv3y6zs9j58j3db23fvkcnm-nixpkgs-fmt-1.3.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/b6mnpgal2zlhlsy98bjh18qzdajxi82g-nixpkgs-fmt-1.3.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/ar69kjmkp1zzrfifsyfsllpqlcsz4lfz-nixpkgs-fmt-1.3.0";
    }).out;
}.${system}