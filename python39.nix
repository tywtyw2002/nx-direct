
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
      name = "python3-3.9.17";
      pname = "python3";
      system = "x86_64-linux";
    } {
      out = "/nix/store/anshmp30br446l2yfk48569kqg133254-python3-3.9.17";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "python3-3.9.17";
      pname = "python3";
      system = "aarch64-linux";
    } {
      out = "/nix/store/prw71zm2z1c4qw12229bgrjmnx4vj4j1-python3-3.9.17";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "python3-3.9.17";
      pname = "python3";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/1ix962sag6dwb8bzligz4b6x0nlah9pa-python3-3.9.17";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "python3-3.9.17";
      pname = "python3";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/h5yq66l2x09pnbj10129bnwyj77hgxik-python3-3.9.17";
    }).out;
}.${system}