
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
      name = "dasel-2.3.6";
      pname = "dasel";
      system = "x86_64-linux";
    } {
      out = "/nix/store/dnlzkjy535y58f7mm3xkkzlgjr9v8c47-dasel-2.3.6";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "dasel-2.3.6";
      pname = "dasel";
      system = "aarch64-linux";
    } {
      out = "/nix/store/3kjasmh9qdipkk85j7c68p0dbwvhzmfm-dasel-2.3.6";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "dasel-2.3.6";
      pname = "dasel";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/yn3ilyla6kb2sai34fc0ibia4fcmbsa3-dasel-2.3.6";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "dasel-2.3.6";
      pname = "dasel";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/whwgn3cyl4vjh2az38h7llqcqjmaina5-dasel-2.3.6";
    }).out;
}.${system}